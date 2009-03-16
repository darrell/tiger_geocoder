set search_path=public,tiger;
set client_min_messages=error;
drop view if exists roads_local;
create view roads_local as
  SELECT * from edges where roadflg='Y';
