   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS zip_lookup_all cascade;
CREATE TABLE
       zip_lookup_all  AS
SELECT *
     , count(*) as cnt
  FROM (
                SELECT zipl as zip
                     , edges.statefp as statefp
                     , sl.abbrev as state
                     , edges.countyfp as countyfp
                     , cl.name as county
                     , cl.namelsad as countyfull
                     , f.cousubfp as cousubfp
                     , cs.name as countysub
                     , f.placefp as placefp
                     , pl.name as place
                  FROM edges
                  LEFT JOIN faces f
                    ON (edges.tfidl           = f.tfid)
                  LEFT JOIN place pl
                    ON (f.placefp  = pl.placefp AND f.statefp=pl.statefp)
                  LEFT JOIN countysub_lookup cs
                    ON (
                               edges.statefp          = cs.statefp
                           AND f.cousubfp          = cs.cousubfp
                       )
                  LEFT JOIN county_lookup cl
                    ON (
                               edges.statefp          = cl.statefp
                           AND edges.countyfp         = cl.countyfp
                       )
                  JOIN state_lookup sl
                    ON (edges.statefp         = sl.statefp)
                 WHERE zipl IS NOT NULL
                 UNION ALL
                SELECT zipr as zip
                     , edges.statefp as statefp
                     , sl.abbrev as state
                     , edges.countyfp as countyfp
                     , cl.name as county
                     , cl.namelsad as countyfull
                     , f.cousubfp as cousubfp
                     , cs.name as countysub
                     , f.placefp as placefp
                     , pl.name as place
                  FROM edges
                  LEFT JOIN faces f
                    ON (edges.tfidl           = f.tfid)
                  LEFT JOIN place pl
                    ON (f.placefp  = pl.placefp AND f.statefp=pl.statefp)
                  LEFT JOIN countysub_lookup cs
                    ON (
                               edges.statefp          = cs.statefp
                           AND f.cousubfp          = cs.cousubfp
                       )
                  LEFT JOIN county_lookup cl
                    ON (
                               edges.statefp          = cl.statefp
                           AND edges.countyfp         = cl.countyfp
                       )
                  JOIN state_lookup sl
                    ON (edges.statefp         = sl.statefp)
                 WHERE zipr IS NOT NULL
       ) as subquery
 GROUP BY zip
     , statefp
     , state
     , countyfp
     , county
     , countyfull
     , cousubfp
     , countysub
     , placefp
     , place;
