-- Show unused indexes
--
-- Example output:
--
--          table      |                       index                | index_size | index_scans
-- ---------------------+--------------------------------------------+------------+-------------
-- public.grade_levels | index_placement_attempts_on_grade_level_id | 97 MB      |           0
-- public.observations | observations_attrs_grade_resources         | 33 MB      |           0
-- public.messages     | user_resource_id_idx                       | 12 MB      |           0
--
-- Compare the file create_all_indexes.sql in this same directory.
-- Using that file with this file can help you discover index usage.
--
-- N.b. As included with the pg-extras plugin for Heroku you can run a query 
-- to show you all unused indexes. On Heroku simply install the plugin the
-- run heroku pg:pg:unused_indexes to show the size and number of times an 
-- index scan has been used. 
--
-- From Postgres Indexing - A collection of indexing tips
-- http://www.craigkerstiens.com/2013/05/30/a-collection-of-indexing-tips/

SELECT
  schemaname || '.' || relname AS table,
  indexrelname AS index,
   pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
   idx_scan as index_scans
FROM pg_stat_user_indexes ui
JOIN pg_index i ON ui.indexrelid = i.indexrelid
WHERE NOT indisunique AND idx_scan < 50 AND pg_relation_size(relid) > 5 * 8192
ORDER BY pg_relation_size(i.indexrelid) / nullif(idx_scan, 0) DESC NULLS FIRST,
  pg_relation_size(i.indexrelid) DESC;




