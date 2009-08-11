set search_path=tiger,public;
CREATE OR REPLACE FUNCTION address_variants(instring text, 
                                            OUT out_addy norm_addy,
                                            OUT relevance double precision)
  RETURNS SETOF record AS $_$
  DECLARE
  rec record;
  BEGIN
    FOR rec in SELECT * from address_variants(normalize_address(instring)) LOOP
      out_addy:=rec.out_addy;
      relevance:=rec.relevance;
      RETURN NEXT;
    END LOOP;
    RETURN;
  END;
$_$ language plpgsql stable strict;
    
CREATE OR REPLACE FUNCTION 
  address_variants(in_addr norm_addy, 
                   OUT out_addy norm_addy,
                   OUT relevance double precision) 
  RETURNS SETOF record AS $_$
  DECLARE
    similar record;
    ziplen integer;
    stateAbrv  text;
    my_statefp text;
    stmt text;
  BEGIN
    IF in_addr.streetName IS NULL THEN
      RETURN;
    END IF;
    
    IF in_addr.stateAbbrev IS NOT NULL THEN
      my_statefp := statefp from state_lookup where abbrev ilike in_addr.stateAbbrev;
    END IF;
    stateAbrv:=upper(in_addr.stateAbbrev);

    SET constraint_exclusion=on;
    
    DROP TABLE IF EXISTS addr_var_temp;
    
    stmt := $$ CREATE TEMP TABLE addr_var_temp
    AS SELECT q.*,e.zipl as zipl_a,
         e.zipr as zipr_a 
    FROM (
      SELECT DISTINCT ON 
     (a.predirabrv,a.pretypabrv,a.prequalabr,
     a.name,a.sufdirabrv,a.suftypabrv,a.sufqualabr,
     state, a.statefp,
     b.fullname,b.predirabrv,b.pretypabrv,b.prequalabr, 
     b.name,b.sufdirabrv,b.suftypabrv,b.sufqualabr)
      a.fullname as fullname_a,
      a.tlid as tlid_a,
      a.predirabrv as predirabrv_a,
      a.pretypabrv as pretypabrv_a,
      a.prequalabr as prequalabr_a,
      a.name as name_a,
      a.street_snd as street_snd_a,
      a.sufdirabrv as sufdirabrv_a,
      a.suftypabrv as suftypabrv_a,
      a.sufqualabr as sufqualabr_a,
      $$  || quote_literal(stateAbrv) || $$ as state,
      a.statefp,
      b.tlid as tlid_b,
      b.fullname as fullname_b,
      b.predirabrv as predirabrv_b,
      b.pretypabrv as pretypabrv_b,
      b.prequalabr as prequalabr_b,
      b.name as name_b,
      b.street_snd as street_snd_b,
      b.sufdirabrv as sufdirabrv_b,
      b.suftypabrv as suftypabrv_b,
      b.sufqualabr as sufqualabr_b,
      NULL::varchar(5) as zipl_b,
      NULL::varchar(5) as zipr_b,
      levenshtein(a.fullname,b.fullname),
      case WHEN a.tlid=b.tlid THEN true ELSE false END as exact
      FROM featnames AS a 
      LEFT JOIN featnames AS b 
      --statefp is used by constraint exclusion, you *really* want to have it
      ON ((a.street_snd=b.street_snd or a.tlid=b.tlid) AND a.statefp=b.statefp)
      WHERE b.name is not null
      AND NOT a.fullname = b.fullname
      AND upper(a.name) = $$ || upper(quote_literal(in_addr.streetName)) 
       || CASE 
            WHEN stateAbrv IS NOT NULL THEN ' AND a.statefp=' || quote_literal(my_statefp)
            ELSE ''
          END
      || $$
      ) as q 
      LEFT JOIN edges as e ON (q.tlid_a=e.tlid)
      $$ || CASE
           WHEN stateAbrv IS NOT NULL THEN ' WHERE e.statefp=' || quote_literal(my_statefp)
           ELSE ''
           END
      ;

    RAISE DEBUG 'stmt: %', stmt;
    EXECUTE stmt;
      
     UPDATE addr_var_temp 
            SET zipr_b=edges.zipr,zipl_b=edges.zipl 
            FROM edges 
            WHERE edges.tlid=tlid_b 
              AND edges.zipr IS NOT NULL
              AND edges.zipl IS NOT NULL
              AND edges.statefp = addr_var_temp.statefp;

    RAISE DEBUG 'in_addr: %', in_addr;
    <<addrs>>
    FOR similar IN SELECT 
              ROW(in_addr.address,predirabrv_b,pretypabrv_b,
                  prequalabr_b,name_b,suftypabrv_b,
                  sufdirabrv_b,sufqualabr_b,
                  in_addr.internal,in_addr.location,state,
                  in_addr.zip,in_addr.zip4,in_addr.parsed)::norm_addy as addr,
              fullname_a,fullname_b,
              array_sort(ARRAY[zipr_a,zipl_a,zipr_b,zipl_b]) as zips,
              exact,levenshtein
             FROM addr_var_temp
             -- oh for the want of a case insensitive "is distinct"
             WHERE (upper(name_a),upper(predirabrv_a),upper(pretypabrv_a), upper(prequalabr_a),
                    upper(sufdirabrv_a),upper(suftypabrv_a),upper(sufqualabr_a))
                    IS NOT DISTINCT FROM
                    (upper(in_addr.streetName),upper(in_addr.preDirAbbrev),upper(in_addr.preTypeAbbrev),upper(in_addr.preQualAbbrev),
                     upper(in_addr.streetDirAbbrev),upper(in_addr.streetTypeAbbrev),upper(in_addr.streetQualAbbrev))

      LOOP
        RAISE DEBUG 'got: %', similar;
        ziplen := array_upper(similar.zips,1);
        IF ziplen IS NULL THEN
          similar.zips:=array_append(similar.zips, in_addr.zip::varchar);
          ziplen := 1;
        END IF;
        FOR anInt IN 1..ziplen LOOP
          out_addy:=similar.addr;
          IF similar.exact OR similar.levenshtein=0 THEN
            relevance := 1.0;
          ELSE
            -- deduct .1 for inexact
            relevance := 0.9;
            relevance := (relevance-(similar.levenshtein/cast(greatest(length(similar.fullname_a),length(similar.fullname_b))as double precision)));
            raise DEBUG 'here with: %', relevance;
          --relevance:=1.0;
          END IF;
           out_addy.zip := similar.zips[anInt];
           IF out_addy.zip <> in_addr.zip AND NOT similar.exact THEN
            IF substr(out_addy.zip,1,3) = substr(in_addr.zip,1,3) THEN
              relevance:=relevance-.1;
            ELSE
             relevance:=relevance-.2;
            END IF;
          END IF;
          RETURN NEXT;
        END LOOP;
      END LOOP addrs;
    --DROP TABLE IF EXISTS addr_var_temp;    
    RETURN;
  END;
$_$ language plpgsql STRICT;
