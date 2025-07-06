-- Step 1: Implement Partitioning on the BOOKING table

CREATE TABLE BOOKING_PARTITIONED (
    booking_id      UUID PRIMARY KEY,
    property_id     UUID NOT NULL,
    user_id         UUID NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    total_price     DECIMAL NOT NULL,
    status          VARCHAR(10) NOT NULL,
    created_at      TIMESTAMP
) PARTITION BY RANGE (start_date);


CREATE TABLE booking_y2023 PARTITION OF BOOKING_PARTITIONED
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_y2024 PARTITION OF BOOKING_PARTITIONED
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_y2025 PARTITION OF BOOKING_PARTITIONED
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE booking_default PARTITION OF BOOKING_PARTITIONED DEFAULT;


-- Step 2: Test Performance of Queries on the Partitioned Table

EXPLAIN ANALYZE
SELECT
    booking_id,
    start_date,
    end_date,
    total_price
FROM
    BOOKING_PARTITIONED
WHERE
    start_date >= '2024-01-01' AND start_date < '2024-04-01'
    AND status = 'confirmed';
