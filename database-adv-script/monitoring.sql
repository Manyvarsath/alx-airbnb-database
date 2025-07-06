-- Step 1: Monitor Performance of Frequently Used Queries

EXPLAIN ANALYZE
SELECT
    r.rating,
    r.comment,
    r.created_at,
    u.first_name,
    u.last_name
FROM
    REVIEW r
JOIN
    USER u ON r.user_id = u.user_id
WHERE
    r.property_id = 'PID46523-4c2b-8f3d-123456789abc';

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    p.name AS property_name,
    p.location
FROM
    BOOKING b
JOIN
    PROPERTY p ON b.property_id = p.property_id
WHERE
    b.user_id = '46153489iklj-4c2b-8f3d-123456789abc'
    AND b.status = 'confirmed'
ORDER BY
    b.start_date DESC;


-- Step 2 & 3: Identify Bottleneck and Implement the Change

CREATE INDEX idx_booking_user_status_date ON BOOKING(user_id, status, start_date DESC);

-- Step 4: Verify the Improvement

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    p.name AS property_name,
    p.location
FROM
    BOOKING b
JOIN
    PROPERTY p ON b.property_id = p.property_id
WHERE
    b.user_id = '46153489iklj-4c2b-8f3d-123456789abc'
    AND b.status = 'confirmed'
ORDER BY
    b.start_date DESC;
