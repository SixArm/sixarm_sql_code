-- SQL that generates the SQL to add an index to every column.
--
-- Output:
--                      ?column?
-- -------------------------------------------------------------------
-- CREATE INDEX idx_pg_proc_proname ON pg_proc ("proname");
-- CREATE INDEX idx_pg_proc_pronamespace ON pg_proc ("pronamespace");
-- CREATE INDEX idx_pg_proc_proowner ON pg_proc ("proowner");
--
-- The reasoning behind this is guessing whether an index will be helpful 
-- can be a bit hard within Postgres. So the easy solution is to add indexes
-- to everything, then just observe if they’re being used. Of course you
-- want to add it to all tables/columns because you never know if core of
-- Postgres may be missing some needed ones.
--
-- As included with the pg-extras plugin for Heroku you can run a query to
-- show you all unused indexes. On Heroku simply install the plugin the run 
-- heroku pg:pg:unused_indexes to show the size and number of times an index
-- scan has been used. On a non Heroku Postgres database you can run the SQL
-- from the file show_unused_indexes.sql; the file in this same directory.
--
-- From Postgres Indexing - A collection of indexing tips
-- http://www.craigkerstiens.com/2013/05/30/a-collection-of-indexing-tips/

SELECT 'CREATE INDEX idx_' 
    || table_name || '_' 
    || column_name || ' ON ' 
    || table_name || ' ("' 
    || column_name || '");' 
  FROM information_schema.columns;




