-- Get the size of your indexes.

SELECT pg_size_pretty(pg_total_relation_size('idx_name'));
