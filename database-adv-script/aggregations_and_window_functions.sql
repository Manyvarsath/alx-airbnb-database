SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    User AS u
JOIN
    Booking AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.first_name,
    u.last_name
ORDER BY
    total_bookings DESC;

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
    RANK() OVER (ORDER BY booking_count DESC) AS property_rank,
    ROW_NUMBER() OVER (ORDER BY booking_count DESC) AS property_row_number
FROM
    PropertyBookings;