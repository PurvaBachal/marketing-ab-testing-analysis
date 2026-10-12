CREATE TABLE marketing_ab_test (
    index_id INTEGER,
    user_id BIGINT,
    test_group VARCHAR(10),
    converted BOOLEAN,
    total_ads INTEGER,
    most_ads_day VARCHAR(20),
    most_ads_hour INTEGER
);