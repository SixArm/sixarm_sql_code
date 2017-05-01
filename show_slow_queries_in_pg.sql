-- To get a high-level view of what's happening in the database,
-- we use the `pg_stat_statements` extension. For example, this
-- enables us to see which queries have been running since the
-- last statistics reset, and how they were performing.
--
-- To see the 10 most time consuming queries, and their average time,
-- use this script below.
--
-- If you enable “track_io_timing” on your Postgres database,
-- this also allows you to see whether you are bottlenecked
-- on CPU or I/O performance.
--
-- Read more here:
-- http://www.craigkerstiens.com/2013/01/10/more-on-postgres-performance/

SELECT query, total_time / calls AS avg_time
FROM pg_stat_statements
ORDER BY total_time DESC 
LIMIT 10;
