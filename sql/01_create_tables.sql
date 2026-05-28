-- 01_create_tables.sql
-- Aerospace Predictive Maintenance Project
-- This file documents the main SQLite tables used in the project.
-- The tables are created from cleaned CSV files using Python and pandas.

-- Main tables:
-- train_labeled
-- test_labeled
-- maintenance_priority
-- model_metrics
-- feature_importance
-- sensor_change
-- sensor_summary_by_life_stage
-- risk_label_counts
-- rul_summary_by_risk

-- Preview all available tables
SELECT name AS table_name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

-- Preview labeled training data
SELECT *
FROM train_labeled
LIMIT 10;

-- Preview labeled test data
SELECT *
FROM test_labeled
LIMIT 10;

-- Preview maintenance priority outputs
SELECT *
FROM maintenance_priority
LIMIT 10;

-- Preview model metrics
SELECT *
FROM model_metrics;

-- Preview feature importance
SELECT *
FROM feature_importance
LIMIT 10;