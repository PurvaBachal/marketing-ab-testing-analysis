# Decision Memo: Marketing Campaign Effectiveness

## Business Problem

The marketing team needs to determine whether showing product advertisements instead of a public-service announcement (PSA) in the same advertising placement leads to a higher user conversion rate. The objective is to measure the difference between the two groups, assess the strength of the evidence, and determine whether the result warrants further campaign testing.

## Finding

The ad group recorded a conversion rate of 2.55%, compared with 1.79% for the PSA group. The estimated absolute lift was **0.769 percentage points**, equivalent to approximately **7.69 additional conversions per 1,000 users** at the observed difference in conversion rates.

The two-sided hypothesis test was statistically significant at the 5% level (p = 1.71 × 10⁻¹³). The 95% confidence interval for absolute lift ranged from 0.587 to 0.936 percentage points.

The estimated lift also exceeded the predefined minimum worthwhile improvement of 0.5 percentage points, and the confidence interval was entirely above that threshold.

## Results

| Measure                                             |                             Result |
| --------------------------------------------------- | ---------------------------------: |
| Total users                                         |                            588,101 |
| Ad group users                                      |                            564,577 |
| PSA group users                                     |                             23,524 |
| Ad conversions                                      |                             14,423 |
| PSA conversions                                     |                                420 |
| Ad conversion rate                                  |                              2.55% |
| PSA conversion rate                                 |                              1.79% |
| Absolute lift                                       |           +0.769 percentage points |
| Relative lift                                       |                            +43.09% |
| 95% confidence interval for absolute lift           | +0.587 to +0.936 percentage points |
| Bootstrap 95% confidence interval for relative lift |                 +30.54% to +57.72% |
| Two-sided p-value                                   |                       1.71 × 10⁻¹³ |

## Interpretation

The results provide strong statistical evidence that the ad and PSA groups had different conversion rates, with the observed rate higher in the ad group. The estimated lift also meets the project's predefined practical-significance criterion.

The 0.5-percentage-point threshold was set as a planning assumption. It was not derived from advertising costs, revenue, or the value of a conversion.

The groups were highly unequal in size: 96% of users were in the ad group and 4% in the PSA group. The intended allocation ratio is not established by the available data, so the imbalance should be documented rather than automatically treated as an experiment failure.

## Sample-Size Planning

Using the observed PSA conversion rate as the baseline, the analysis estimated that approximately 12,474 users per group would be needed to detect a 0.5-percentage-point improvement with 80% power and a two-sided 5% significance level under equal allocation.

At the observed allocation ratio, the estimated requirement was approximately 155,921 ad users and 6,497 PSA users. Estimated power at the current sample sizes was 99.96%, with an approximate minimum detectable effect of 0.255 percentage points at 80% power.

These are planning estimates based on the observed baseline and stated assumptions, not guarantees of future performance.

## Recommendation

**Proceed with further controlled testing rather than making an immediate rollout decision.**

The conversion results favour the ad group, but the next test should have a documented assignment process, a clearly defined allocation plan, and a practical improvement threshold agreed in advance.

Before scaling the campaign, the marketing team should assess the value of additional conversions against advertising costs. The current dataset does not include the financial information needed to determine profitability or return on advertising spend.

## Limitations

- Advertising spend, revenue, and order value are not available, so financial return cannot be evaluated.
- The intended assignment ratio is not documented in the available data.
- The 0.5-percentage-point threshold is an assumption that should be validated against business objectives.
- Differences by ad exposure count, day, or hour are exploratory and should not be interpreted as causal effects.
- Statistical significance alone does not establish commercial value.
