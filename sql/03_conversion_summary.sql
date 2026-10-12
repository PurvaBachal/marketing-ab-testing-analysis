-- Overall dataset summary.
SELECT
    COUNT(*) AS total_users,
    COUNT(*) FILTER (WHERE converted IS TRUE) AS total_conversions,
    COUNT(*) FILTER (WHERE converted IS FALSE) AS total_non_conversions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE converted IS TRUE)
        / NULLIF(COUNT(*), 0),
        4) AS overall_conversion_rate_pct
FROM marketing_ab_test;


-- Conversion performance by experiment group.
SELECT
    test_group,
    COUNT(*) AS total_users,
    COUNT(*) FILTER (WHERE converted IS TRUE) AS conversions,
    COUNT(*) FILTER (WHERE converted IS FALSE) AS non_conversions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE converted IS TRUE)
        / NULLIF(COUNT(*), 0),
        4) AS conversion_rate_pct
FROM marketing_ab_test
GROUP BY test_group
ORDER BY test_group;


-- Compare ad and PSA conversion rates and calculate descriptive lift.
WITH group_summary AS (
    SELECT
        test_group,
        COUNT(*) AS total_users,
        COUNT(*) FILTER (WHERE converted IS TRUE) AS conversions,
        COUNT(*) FILTER (WHERE converted IS FALSE) AS non_conversions,
        COUNT(*) FILTER (WHERE converted IS TRUE)::NUMERIC
            / NULLIF(COUNT(*), 0) AS conversion_rate
    FROM marketing_ab_test
    GROUP BY test_group),
rate_comparison AS (
    SELECT
        MAX(total_users) FILTER (
            WHERE test_group = 'ad') AS ad_users,

        MAX(total_users) FILTER (
            WHERE test_group = 'psa') AS psa_users,

        MAX(conversions) FILTER (
            WHERE test_group = 'ad') AS ad_conversions,

        MAX(conversions) FILTER (
            WHERE test_group = 'psa') AS psa_conversions,

        MAX(conversion_rate) FILTER (
            WHERE test_group = 'ad') AS ad_rate,

        MAX(conversion_rate) FILTER (
            WHERE test_group = 'psa') AS psa_rate
    FROM group_summary)
SELECT
    ad_users,
    ad_conversions,
    ROUND(ad_rate * 100, 4) AS ad_conversion_rate_pct,

    psa_users,
    psa_conversions,
    ROUND(psa_rate * 100, 4) AS psa_conversion_rate_pct,

    ROUND(
        (ad_rate - psa_rate) * 100,
        4) AS absolute_lift_percentage_points,

    ROUND(
        ((ad_rate - psa_rate) / NULLIF(psa_rate, 0)) * 100,
        4) AS relative_lift_pct,

    ROUND(
        (ad_rate - psa_rate) * 1000,
        2)AS incremental_conversions_per_1000_users

FROM rate_comparison;


-- Conversion performance by experiment group and day
-- with the highest recorded ad exposure.
SELECT
    test_group,
    most_ads_day,
    COUNT(*) AS total_users,
    COUNT(*) FILTER (WHERE converted IS TRUE) AS conversions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE converted IS TRUE)
        / NULLIF(COUNT(*), 0),
        4) AS conversion_rate_pct
FROM public.marketing_ab_test
GROUP BY
    test_group,
    most_ads_day
ORDER BY
    test_group,
    CASE most_ads_day
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
        ELSE 8
    END;


-- Conversion performance by experiment group and
-- the hour with the highest recorded ad exposure.
SELECT
    test_group,
    most_ads_hour,
    COUNT(*) AS total_users,
    COUNT(*) FILTER (WHERE converted IS TRUE) AS conversions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE converted IS TRUE)
        / NULLIF(COUNT(*), 0),
        4
    ) AS conversion_rate_pct
FROM public.marketing_ab_test
GROUP BY
    test_group,
    most_ads_hour
ORDER BY
    test_group,
    most_ads_hour;


-- Conversion performance by number of recorded ad exposures.
SELECT
    test_group,
    total_ads,
    COUNT(*) AS total_users,
    COUNT(*) FILTER (WHERE converted IS TRUE) AS conversions,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE converted IS TRUE)
        / NULLIF(COUNT(*), 0),
        4) AS conversion_rate_pct
FROM marketing_ab_test
GROUP BY
    test_group,
    total_ads
ORDER BY
    test_group,
    total_ads;