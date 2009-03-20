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
--CREATE OR REPLACE FUNCTION address_variants(in_addr norm_addy) 
  RETURNS SETOF record AS $_$
  DECLARE
    similar record;
    total integer;
    ziplen integer;
  BEGIN
    IF in_addr.streetName IS NULL THEN
      RETURN;
    END IF;
    
    DROP TABLE IF EXISTS addr_var_temp;
    CREATE TEMP TABLE addr_var_temp
    AS SELECT DISTINCT ON 
     (a.predirabrv,a.pretypabrv,a.prequalabr,
     a.name,a.sufdirabrv,a.suftypabrv,a.sufqualabr,
     st.stusps,
     b.fullname,b.predirabrv,b.pretypabrv,b.prequalabr, 
     b.name,b.sufdirabrv,b.suftypabrv,b.sufqualabr)
      a.fullname as fullname_a,
      a.tlid as tlid_a,
      a.predirabrv as predirabrv_a,
      a.pretypabrv as pretypabrv_a,
      a.prequalabr as prequalabr_a,
      a.name as name_a,
      metaphone(a.fullname, 10) as snd_a,
      a.sufdirabrv as sufdirabrv_a,
      a.suftypabrv as suftypabrv_a,
      a.sufqualabr as sufqualabr_a,
      st.stusps as state,
      e.zipl as zipl_a,
      e.zipr as zipr_a,
      b.tlid as tlid_b,
      b.fullname as fullname_b,
      b.predirabrv as predirabrv_b,
      b.pretypabrv as pretypabrv_b,
      b.prequalabr as prequalabr_b,
      b.name as name_b,
      metaphone(b.fullname,10) as snd_b,
      b.sufdirabrv as sufdirabrv_b,
      b.suftypabrv as suftypabrv_b,
      b.sufqualabr as sufqualabr_b,
      NULL::varchar(5) as zipl_b,
      NULL::varchar(5) as zipr_b,
      levenshtein(a.fullname,b.fullname),
      --,count(*)
      case WHEN a.tlid=b.tlid THEN true ELSE false END as exact
      FROM featnames AS a 
      LEFT JOIN featnames AS b 
--      ON (a.tlid=b.tlid OR metaphone(a.name, 7)=metaphone(b.name, 7))
      ON (metaphone(a.fullname, 10)=metaphone(b.fullname, 10) or a.tlid=b.tlid)
--      ON (a.tlid=b.tlid and a.linearid<>b.linearid
--           AND 
--          (a.predirabrv,a.pretypabrv,a.prequalabr,a.name,a.sufdirabrv,a.suftypabrv,a.sufqualabr)
--          <> 
--          (b.predirabrv,b.pretypabrv,b.prequalabr,b.name,b.sufdirabrv,b.suftypabrv,b.sufqualabr)
--          )
      LEFT JOIN edges as e ON (a.tlid=e.tlid)
      LEFT JOIN state as st on (a.statefp=st.statefp)
      WHERE b.name is not null
      AND (a.name ilike in_addr.streetName)
      AND NOT a.fullname ILIKE b.fullname;
--     GROUP BY 
--      a.name, a.tlid,b.tlid,a.predirabrv,a.pretypabrv,a.prequalabr,a.sufdirabrv,
--      a.suftypabrv, a.sufqualabr, a.fullname,st.stusps,e.zipr,e.zipl,
--      b.predirabrv,b.pretypabrv,b.prequalabr,b.name,b.sufdirabrv,b.suftypabrv,b.sufqualabr,
--      b.fullname;

     UPDATE addr_var_temp 
            SET zipr_b=edges.zipr,zipl_b=edges.zipl 
            FROM edges 
            WHERE edges.tlid=tlid_b 
              AND edges.zipr IS NOT NULL
              AND edges.zipl IS NOT NULL;
    --update addr_var_temp set zipr_b='95201',zipl_a='95202' where name_b='Fountaingrove';
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
             WHERE ((predirabrv_a IS NULL )--AND in_addr.preDirAbbrev IS NULL) 
                      OR predirabrv_a ilike in_addr.preDirAbbrev) 
                  AND
                   ((pretypabrv_a IS NULL AND in_addr.preTypeAbbrev IS NULL) 
                      OR pretypabrv_a ilike in_addr.preTypeAbbrev) 
                  AND
                    ((prequalabr_a IS NULL AND in_addr.preQualAbbrev IS NULL) 
                      OR prequalabr_a ilike in_addr.preQualAbbrev) 
                  AND
                    ((sufdirabrv_a IS NULL AND in_addr.streetDirAbbrev IS NULL) 
                      OR sufdirabrv_a ilike in_addr.streetDirAbbrev) 
                  AND
                    ((suftypabrv_a IS NULL AND in_addr.streetTypeAbbrev IS NULL) 
                      OR suftypabrv_a ilike in_addr.streetTypeAbbrev) 
                  AND
                    ((sufqualabr_a IS NULL AND in_addr.streetQualAbbrev IS NULL) 
                      OR sufqualabr_a ilike in_addr.streetQualAbbrev) 
                  AND
                    name_a ilike in_addr.streetName 
                  AND
                    state ilike in_addr.stateAbbrev 
      LOOP
        RAISE DEBUG 'got: %', similar;
        ziplen := array_upper(similar.zips,1);
        IF ziplen IS NULL THEN
          similar.zips:=array_append(similar.zips, in_addr.zip);
          ziplen := 1;
        END IF;
        FOR i IN 1..ziplen LOOP
          out_addy:=similar.addr;
          IF similar.exact OR similar.levenshtein=0 THEN
            relevance := 1.0;
          ELSE
            relevance := (1-(similar.levenshtein/cast(greatest(length(similar.fullname_a),length(similar.fullname_b))as double precision)));
            raise DEBUG 'here with: %', relevance;
          --relevance:=1.0;
          END IF;
           out_addy.zip := similar.zips[i];
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
    DROP TABLE IF EXISTS addr_var_temp;    
    RETURN;
  END;
$_$ language plpgsql STRICT;
