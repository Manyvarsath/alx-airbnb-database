-- =================================================================
-- Performance Measurement Before Indexing
-- =================================================================

-- Query 1:

EXPLAIN ANALYZE
SELECT
    u.user_id,
    u.first_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    User AS u
JOIN
    Booking AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name
ORDER BY
    total_bookings DESC;


-- Query 2:

EXPLAIN ANALYZE
WITH PropertyBookings AS (
    SELECT
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS booking_count
    FROM
        Property AS p
    LEFT JOIN
        Booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.name
)
SELECT
    name,
    booking_count,
    RANK() OVER (ORDER BY booking_count DESC) AS property_rank
FROM
    PropertyBookings;

-- =================================================================
-- Index Creation Commands
-- =================================================================

CREATE INDEX idx_booking_user_id ON Booking(user_id);

CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- =================================================================
-- Performance Measurement After Indexing
-- =================================================================

-- Query 1:

EXPLAIN ANALYZE
SELECT
    u.user_id,
    u.first_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    User AS u
JOIN
    Booking AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name
ORDER BY
    total_bookings DESC;


-- Query 2 :

EXPLAIN ANALYZE
WITH PropertyBookings AS (
    SELECT
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS booking_count
    FROM
        Property AS p
    LEFT JOIN
        Booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.name
)
SELECT
    name,
    booking_count,
    RANK() OVER (ORDER BY booking_count DESC) AS property_rank
FROM
    PropertyBookings;