# Marketing A/B Test Analysis: Ad vs. PSA Conversion Impact

 Designed and analyzed an A/B experiment on 588K users to quantify the business impact of ad exposure on conversion. Found a statistically significant 43% relative lift (p < 0.001) in the ad group vs. PSA control, and made a launch recommendation weighing statistical significance, practical significance, and sample-size limitations.

---

## Problem Statement
A marketing team wants to know whether showing users a targeted advertisement
increases their likelihood of making a purchase, compared to showing them a
generic public service announcement (PSA). This analysis uses historical
exposure and conversion data (588,101 users) to determine whether the ad
campaign had a measurable, positive effect on conversion rate.

## Hypothesis
- **H₀ (Null):** No difference in conversion rate between ad and psa groups.
- **H₁ (Alternative):** Users who saw the ad have a higher conversion rate than
  users who saw the PSA.

## Methodology
1. Loaded 588,101 records into MySQL (`LOAD DATA INFILE`)
2. Ran SQL aggregation queries to calculate conversion rate by group and by day
3. Validated experiment integrity (group size check)
4. Ran a two-proportion z-test in Python to confirm statistical significance
5. Visualized results in an interactive Tableau dashboard

## Validity Check
- Ad group: 564,577 users
- PSA group: 23,524 users (~24:1 imbalance)
- This imbalance is consistent with common real-world ad-testing practice,
  where companies limit control-group size to reduce revenue loss from
  withholding ads. The PSA group's estimate is less precise as a result,
  though its large absolute size (23K+) still supports a reliable comparison.

## Results
| Metric | Ad Group | PSA Group |
|---|---|---|
| Conversion Rate | 2.55% | 1.79% |
| Sample Size | 564,577 | 23,524 |

- **Absolute lift:** 0.77 percentage points
- **Relative lift:** ~43% improvement
- **z-statistic:** 7.370
- **p-value:** < 0.001 (statistically significant)

## Launch Decision
Given the statistically significant result and a practically meaningful
~43% relative lift in conversion rate, I recommend launching the ad campaign
over the PSA control, assuming ad delivery cost is reasonable relative to
the value of each additional conversion. The PSA group's smaller sample
size is a noted limitation, though it does not undermine the overall
conclusion given the scale of the effect.

## Dashboard
🔗 [View the interactive Tableau dashboard](https://public.tableau.com/app/profile/arpita.sarkar2356/viz/MarketingABTestAnalysis_17857674125260/Dashboard1)

## Tools Used
MySQL · Python (Pandas, statsmodels) · Tableau · Google Colab

## Repo Structure
```
marketing-ab-test-analysis/
├── README.md
├── data/                  → raw dataset (or link, see data/README.md)
├── sql/                   → table creation, validity check, analysis queries
├── notebooks/             → significance_test.ipynb (Colab export)
├── exports/               → CSVs exported from MySQL, feeding Tableau
├── dashboard/             → Tableau Public link + workbook
└── images/                → dashboard screenshot for this README
```

## How to Reproduce
1. Download the dataset from [Kaggle: Marketing A/B Testing](#) and place it in `data/`
2. Run `sql/01_create_table.sql`, then `sql/02_validity_check.sql`, then `sql/03_analysis_queries.sql` in MySQL Workbench
3. Export the query results as CSVs into `exports/`
4. Open `notebooks/significance_test.ipynb` in Colab to reproduce the z-test
5. Open the Tableau workbook in `dashboard/` (or the Tableau Public link above) to view the dashboard
