-- Query 1: INNER JOIN

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    Booking AS b
INNER JOIN
    User AS u ON b.user_id = u.user_id;

-- Query 2: LEFT JOIN

SELECT
    p.property_id,
    p.name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM
    Property AS p
LEFT JOIN
    Review AS r ON p.property_id = r.property_id
ORDER BY
	p.property_id;

-- Query 3: FULL OUTER JOIN

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM
    User AS u
FULL OUTER JOIN
    Booking AS b ON u.user_id = b.user_id;