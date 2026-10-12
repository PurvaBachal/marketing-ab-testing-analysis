-- Check total rows and distinct IDs.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT user_id) AS distinct_user_ids,
    COUNT(DISTINCT index_id) AS distinct_index_ids
FROM marketing_ab_test;


-- Check Missing values in each column.
SELECT
    COUNT(*) - COUNT(index_id) AS missing_index_id,
    COUNT(*) - COUNT(user_id) AS missing_user_id,
    COUNT(*) - COUNT(test_group) AS missing_test_group,
    COUNT(*) - COUNT(converted) AS missing_converted,
    COUNT(*) - COUNT(total_ads) AS missing_total_ads,
    COUNT(*) - COUNT(most_ads_day) AS missing_most_ads_day,
    COUNT(*) - COUNT(most_ads_hour) AS missing_most_ads_hour
FROM marketing_ab_test;


-- Check duplicate index IDs.
SELECT
    COUNT(*) AS duplicate_index_values
FROM (
    SELECT index_id
    FROM marketing_ab_test
    WHERE index_id IS NOT NULL
    GROUP BY index_id
    HAVING COUNT(*) > 1
) AS duplicate_ids;


-- Check duplicate user IDs.
SELECT
    COUNT(*) AS duplicate_user_values
FROM (
    SELECT user_id
    FROM marketing_ab_test
    WHERE user_id IS NOT NULL
    GROUP BY user_id
    HAVING COUNT(*) > 1
) AS duplicate_users;


-- Check the number of records in each experiment group.
SELECT
    test_group,
    COUNT(*) AS total_users
FROM marketing_ab_test
GROUP BY test_group
ORDER BY test_group;


-- Check the distribution of conversion outcomes.
SELECT
    converted,
    COUNT(*) AS total_records
FROM marketing_ab_test
GROUP BY converted
ORDER BY converted;


-- Check the distinct experiment group values.
SELECT DISTINCT
    test_group
FROM marketing_ab_test
ORDER BY test_group;


-- Check the distinct values for the day with the most ad exposure.
SELECT DISTINCT
    most_ads_day
FROM marketing_ab_test
ORDER BY most_ads_day;


-- Check the range of ad exposure hours.
SELECT
    MIN(most_ads_hour) AS minimum_ad_hour,
    MAX(most_ads_hour) AS maximum_ad_hour
FROM marketing_ab_test;


-- Identify invalid or unexpected values.
SELECT
    SUM(
        CASE
            WHEN test_group IS NOT NULL
             AND test_group NOT IN ('ad', 'psa')
            THEN 1 ELSE 0
        END) AS invalid_test_group_rows,
	
    SUM(
        CASE
            WHEN total_ads < 0
            THEN 1 ELSE 0
        END) AS negative_total_ads_rows,

    SUM(
        CASE
            WHEN most_ads_hour NOT BETWEEN 0 AND 23
            THEN 1 ELSE 0
        END) AS invalid_ad_hour_rows,

    SUM(
        CASE
            WHEN most_ads_day IS NOT NULL
             AND most_ads_day NOT IN (
                 'Monday', 'Tuesday', 'Wednesday',
                 'Thursday', 'Friday', 'Saturday', 'Sunday')
            THEN 1 ELSE 0
        END) AS invalid_ad_day_rows
FROM marketing_ab_test;