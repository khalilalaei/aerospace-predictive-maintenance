-- 03_sensor_summary.sql
-- Sensor analysis queries for aerospace predictive maintenance.

-- 1. Top 10 sensors with the largest average difference between low-risk and high-risk observations
SELECT
    "index" AS sensor_name,
    ROUND(low_risk_avg, 4) AS low_risk_avg,
    ROUND(high_risk_avg, 4) AS high_risk_avg,
    ROUND(absolute_change, 4) AS absolute_change
FROM sensor_change
ORDER BY absolute_change DESC
LIMIT 10;

-- 2. Top 10 Random Forest feature importances
SELECT
    feature,
    ROUND(importance, 4) AS importance
FROM feature_importance
ORDER BY importance DESC
LIMIT 10;

-- 3. Model metrics comparison
SELECT
    model,
    ROUND(accuracy, 4) AS accuracy,
    ROUND(precision, 4) AS precision,
    ROUND(recall, 4) AS recall,
    ROUND(f1_score, 4) AS f1_score,
    ROUND(roc_auc, 4) AS roc_auc
FROM model_metrics
ORDER BY roc_auc DESC;

-- 4. Average key sensor values by risk label
SELECT
    risk_label,
    ROUND(AVG(sensor_2), 4) AS avg_sensor_2,
    ROUND(AVG(sensor_3), 4) AS avg_sensor_3,
    ROUND(AVG(sensor_4), 4) AS avg_sensor_4,
    ROUND(AVG(sensor_7), 4) AS avg_sensor_7,
    ROUND(AVG(sensor_11), 4) AS avg_sensor_11,
    ROUND(AVG(sensor_12), 4) AS avg_sensor_12,
    ROUND(AVG(sensor_15), 4) AS avg_sensor_15,
    ROUND(AVG(sensor_20), 4) AS avg_sensor_20,
    ROUND(AVG(sensor_21), 4) AS avg_sensor_21
FROM train_labeled
GROUP BY risk_label
ORDER BY
    CASE risk_label
        WHEN 'Low Risk' THEN 1
        WHEN 'Medium Risk' THEN 2
        WHEN 'High Risk' THEN 3
        ELSE 4
    END;

-- 5. Average RUL and cycle position by risk label
SELECT
    risk_label,
    COUNT(*) AS observation_count,
    ROUND(AVG(time_in_cycles), 2) AS avg_cycle,
    ROUND(AVG(RUL), 2) AS avg_rul
FROM train_labeled
GROUP BY risk_label
ORDER BY avg_rul DESC;

-- 6. Sensor readings for top maintenance-priority engines
SELECT
    m.unit_number,
    m.RUL,
    m.risk_label,
    ROUND(m.predicted_risk_probability, 4) AS predicted_risk_probability,
    ROUND(t.sensor_2, 4) AS sensor_2,
    ROUND(t.sensor_3, 4) AS sensor_3,
    ROUND(t.sensor_4, 4) AS sensor_4,
    ROUND(t.sensor_11, 4) AS sensor_11,
    ROUND(t.sensor_15, 4) AS sensor_15
FROM maintenance_priority AS m
JOIN test_labeled AS t
    ON m.unit_number = t.unit_number
WHERE m.predicted_high_risk = 1
ORDER BY m.predicted_risk_probability DESC
LIMIT 20;