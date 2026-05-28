-- 02_risk_analysis.sql
-- Risk analysis queries for aerospace predictive maintenance.

-- 1. Count training observations by risk label
SELECT
    risk_label,
    COUNT(*) AS observation_count
FROM train_labeled
GROUP BY risk_label
ORDER BY observation_count DESC;

-- 2. Average RUL by risk label
SELECT
    risk_label,
    COUNT(*) AS observation_count,
    ROUND(AVG(RUL), 2) AS avg_rul,
    MIN(RUL) AS min_rul,
    MAX(RUL) AS max_rul
FROM train_labeled
GROUP BY risk_label
ORDER BY avg_rul DESC;

-- 3. Number of unique engines that ever enter each risk label
SELECT
    risk_label,
    COUNT(DISTINCT unit_number) AS engine_count
FROM train_labeled
GROUP BY risk_label
ORDER BY engine_count DESC;

-- 4. Average engine lifetime in training data
SELECT
    COUNT(*) AS engine_count,
    ROUND(AVG(engine_lifetime), 2) AS avg_lifetime_cycles,
    MIN(engine_lifetime) AS shortest_lifetime_cycles,
    MAX(engine_lifetime) AS longest_lifetime_cycles
FROM (
    SELECT
        unit_number,
        MAX(time_in_cycles) AS engine_lifetime
    FROM train_labeled
    GROUP BY unit_number
);

-- 5. Top 20 test engines by predicted failure-risk probability
SELECT
    unit_number,
    time_in_cycles,
    RUL,
    risk_label,
    high_risk_flag,
    predicted_high_risk,
    ROUND(predicted_risk_probability, 4) AS predicted_risk_probability,
    predicted_risk_label
FROM maintenance_priority
ORDER BY predicted_risk_probability DESC
LIMIT 20;

-- 6. Model prediction summary on test engines
SELECT
    predicted_risk_label,
    COUNT(*) AS engine_count,
    ROUND(AVG(predicted_risk_probability), 4) AS avg_predicted_probability,
    ROUND(AVG(RUL), 2) AS avg_true_rul
FROM maintenance_priority
GROUP BY predicted_risk_label
ORDER BY avg_predicted_probability DESC;

-- 7. Actual vs predicted high-risk counts
SELECT
    high_risk_flag AS actual_high_risk,
    predicted_high_risk,
    COUNT(*) AS engine_count
FROM maintenance_priority
GROUP BY high_risk_flag, predicted_high_risk
ORDER BY actual_high_risk DESC, predicted_high_risk DESC;

-- 8. High-priority maintenance list
SELECT
    unit_number,
    time_in_cycles,
    RUL,
    risk_label,
    ROUND(predicted_risk_probability, 4) AS predicted_risk_probability
FROM maintenance_priority
WHERE predicted_high_risk = 1
ORDER BY predicted_risk_probability DESC;