SELECT
    p.property_id,
    p.name,
    p.location,
    p.price_per_night
FROM
    Property AS p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            Review AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    User AS u
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            Booking AS b
        WHERE
            b.user_id = u.user_id
    ) > 3;