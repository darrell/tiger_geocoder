   set search_path=tiger,public;
   set client_min_messages = error;
  DROP TABLE IF EXISTS zip_lookup_all cascade;
CREATE TABLE
       zip_lookup_all  AS
SELECT *
     , count(*) as cnt
  FROM (
                SELECT zipl as zip
                     , rl.statefp as statefp
                     , sl.abbrev as state
                     , rl.countyfp as countyfp
                     , cl.name as county
                     , cl.namelsad as countyfull
                     , f.cousubfp as cousubfp
                     , cs.name as countysub
                     , f.placefp as placefp
                     , pl.name as place
                  FROM edges as rl
                  LEFT JOIN faces f
                    ON (rl.tfidl           = f.tfid)
                  LEFT JOIN place pl
                    ON (f.placefp          = pl.placefp)
                  LEFT JOIN countysub_lookup cs
                    ON (
                               rl.statefp          = cs.statefp
                           AND f.cousubfp          = cs.cousubfp
                       )
                  LEFT JOIN county_lookup cl
                    ON (
                               rl.statefp          = cl.statefp
                           AND rl.countyfp         = cl.countyfp
                       )
                  JOIN state_lookup sl
                    ON (rl.statefp         = sl.statefp)
                 WHERE zipl IS NOT NULL
                 UNION ALL
                SELECT zipr as zip
                     , rl.statefp as statefp
                     , sl.abbrev as state
                     , rl.countyfp as countyfp
                     , cl.name as county
                     , cl.namelsad as countyfull
                     , f.cousubfp as cousubfp
                     , cs.name as countysub
                     , f.placefp as placefp
                     , pl.name as place
                  FROM edges as rl
                  LEFT JOIN faces f
                    ON (rl.tfidl           = f.tfid)
                  LEFT JOIN place pl
                    ON (f.placefp          = pl.placefp)
                  LEFT JOIN countysub_lookup cs
                    ON (
                               rl.statefp          = cs.statefp
                           AND f.cousubfp          = cs.cousubfp
                       )
                  LEFT JOIN county_lookup cl
                    ON (
                               rl.statefp          = cl.statefp
                           AND rl.countyfp         = cl.countyfp
                       )
                  JOIN state_lookup sl
                    ON (rl.statefp         = sl.statefp)
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
