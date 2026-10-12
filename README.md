# Marketing Campaign Effectiveness — A/B Test Analysis

## Business Problem

The marketing team needs to determine whether showing product advertisements instead of a public-service announcement (PSA) in the same advertising placement leads to a higher user conversion rate. The objective is to measure the difference between the two groups, assess the strength of the evidence, and determine whether the result warrants further campaign testing.

## Project Overview

This case study analyzes a public marketing A/B testing dataset to compare conversion rates between the ad and PSA groups. The analysis covers data validation, SQL-based summaries, conversion lift, statistical hypothesis testing, confidence intervals, and sample-size planning.

**Dataset:** Marketing A/B Testing — Favio Vázquez, Kaggle
**License:** CC0 : Public Domain, as listed on Kaggle

## Key Findings

The analysis covered 588,101 unique users. The ad group accounted for 96% of users, while the PSA group accounted for 4%.

| Metric          | Ad Group | PSA Group |
| --------------- | -------: | --------: |
| Users           |  564,577 |    23,524 |
| Conversions     |   14,423 |       420 |
| Conversion rate |    2.55% |     1.79% |

The difference between the groups was:

- **Absolute lift:** +0.769 percentage points
- **Relative lift:** +43.09%
- **95% confidence interval for absolute lift:** +0.587 to +0.936 percentage points
- **Two-sided p-value:** 1.71 × 10⁻¹³
- **Estimated additional conversions per 1,000 users:** 7.69, based on the observed difference in conversion rates

The result was statistically significant at the 5% level. The estimated absolute lift also exceeded the predefined minimum worthwhile improvement of 0.5 percentage points, and the confidence interval was entirely above that threshold.

These findings favour the ad group on conversion rate and support further testing. They do not establish campaign profitability or the financial return from advertising.

## Approach

### Data Validation and SQL

- Checked required fields, missing values, user ID uniqueness, group labels, conversion values, and ad exposure counts.
- Reviewed group sizes and conversion outcomes.
- Used PostgreSQL to validate the data and calculate conversion summaries by experiment group.

### Conversion and Lift Analysis

Conversion rate was calculated as:

**Conversion rate** = Converted users ÷ Total users

The analysis measured both absolute and relative lift:

**Absolute lift** = Ad conversion rate − PSA conversion rate

**Relative lift** = (Ad conversion rate − PSA conversion rate) ÷ PSA conversion rate × 100%

Absolute lift is expressed in percentage points; relative lift expresses the difference as a percentage of the PSA conversion rate.

### Statistical Testing

A two-sided two-proportion z-test was used to test whether the conversion rates differed.

- **Null hypothesis (H₀):** The ad and PSA conversion rates are equal.
- **Alternative hypothesis (H₁):** The conversion rates differ.
- **Significance level:** 5%.
- **Confidence level:** 95%.

A Newcombe confidence interval was calculated for absolute lift, and bootstrap estimation was used to quantify uncertainty in relative lift.

### Practical Significance and Power Analysis

The observed lift was compared with a predefined minimum worthwhile improvement of 0.5 percentage points. This is a planning assumption, not a threshold derived from campaign economics.

Using the observed PSA conversion rate as the baseline, sample-size planning estimated the users required to detect a 0.5-percentage-point improvement with 80% power and a two-sided 5% significance level.

| Planning Measure                                    |                Estimate |
| --------------------------------------------------- | ----------------------: |
| Required users per group with equal allocation      |                  12,474 |
| Required PSA users at the observed allocation ratio |                   6,497 |
| Corresponding ad users at that ratio                |                 155,921 |
| Estimated power at the observed sample sizes        |                  99.96% |
| Approximate minimum detectable effect at 80% power  | 0.255 percentage points |

These estimates depend on the observed baseline rate and the stated statistical assumptions. They are planning figures, not a guarantee of future results.

## Recommendation

The ad group recorded a higher conversion rate, and the estimated lift exceeded the project's predefined threshold. The next step is to validate the result through a further controlled experiment with a documented assignment process and a clearly defined allocation plan.

Before making a rollout decision, the marketing team should determine the value of an additional conversion and account for advertising costs. The current dataset does not contain the financial information needed to assess profitability or return on advertising spend.

## Limitations

- The dataset does not include advertising spend, revenue, or order value, so profitability cannot be assessed.
- The group sizes are highly unequal. The intended allocation ratio is not established by the available data, so the imbalance alone is not treated as evidence of a sample-ratio mismatch.
- The 0.5-percentage-point threshold is a planning assumption and should be validated against business objectives.
- Comparisons by ad exposure count, day, or hour are exploratory. These characteristics are not treated as randomized assignments, so observed differences should not be interpreted as causal effects.
- Statistical significance does not, by itself, establish business value.

## Tools

- **SQL:** PostgreSQL
- **Python:** Pandas, NumPy, Matplotlib, Statsmodels
- **Analysis:** Data validation, conversion-rate analysis, hypothesis testing, confidence intervals, power analysis, and sample-size estimation

## Repository Structure

```text
marketing-ab-test-analysis/
│
├── data/
│ └── raw/
|
├── docs/
|
├── notebooks/
│
├── sql/
│
├── .gitignore
├── README.md
└── requirements.txt
```

## How to Run

1. Download the dataset from the Kaggle source above and place the CSV in the local `data/raw/` directory.
2. Set up the Python environment using the project's dependency list.
3. Run the PostgreSQL scripts in order: table setup, data quality checks, then conversion summary.
4. Open the notebook in VS Code, select the project environment as the kernel, and run the analysis from top to bottom.
5. Review the decision memo for the findings and recommended next steps.
