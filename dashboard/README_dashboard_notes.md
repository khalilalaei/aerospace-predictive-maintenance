# Power BI Dashboard Notes

## Dashboard Purpose

This dashboard translates NASA C-MAPSS turbofan engine degradation data into an operations-focused predictive maintenance view. It summarizes engine failure-risk predictions, model performance, sensor importance, and maintenance-priority rankings.

## Key Dashboard KPIs

- Test engines analyzed: 100
- Predicted high-risk engines: 26
- Average remaining useful life: 75.52 cycles
- Best model ROC-AUC: 0.98

## Main Data Sources

- `maintenance_priority_table.csv`
- `model_metrics.csv`
- `feature_importance.csv`
- `sensor_change_low_vs_high_risk.csv`
- `rul_summary_by_risk.csv`

## Dashboard Sections

### Fleet Risk Overview

Shows the number of test engines analyzed, predicted high-risk engines, average remaining useful life, and best model ROC-AUC.

### Risk Distribution

Compares actual RUL-based risk tiers with predicted maintenance-risk classifications.

### Model Performance

Compares Logistic Regression and Random Forest using recall, F1 score, and ROC-AUC.

### Maintenance Priority Table

Ranks test engines by predicted high-risk probability so maintenance teams can prioritize inspections.

### Feature and Sensor Importance

Shows the most important Random Forest model features and the sensor channels with the largest differences between low-risk and high-risk observations.

## Final Model

Random Forest was selected as the final model because it matched Logistic Regression on accuracy, precision, recall, and F1 score while achieving slightly higher ROC-AUC and providing feature importance for model interpretation.