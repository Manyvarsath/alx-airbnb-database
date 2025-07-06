-- Initial Query
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location AS property_location,
    py.amount AS payment_amount,
    py.payment_date,
    py.payment_method
FROM
    BOOKING b
JOIN
    USER u ON b.user_id = u.user_id
JOIN
    PROPERTY p ON b.property_id = p.property_id
LEFT JOIN
    PAYMENT py ON b.booking_id = py.booking_id
WHERE
    p.location = 'New York' AND b.status = 'confirmed';

-- Index Creation

CREATE INDEX idx_booking_user_id ON BOOKING(user_id);
CREATE INDEX idx_booking_property_id ON BOOKING(property_id);
CREATE INDEX idx_payment_booking_id ON PAYMENT(booking_id);
CREATE INDEX idx_property_host_id ON PROPERTY(host_id);
CREATE INDEX idx_review_property_id ON REVIEW(property_id);
CREATE INDEX idx_review_user_id ON REVIEW(user_id);
CREATE INDEX idx_message_sender_id ON MESSAGE(sender_id);
CREATE INDEX idx_message_recipient_id ON MESSAGE(recipient_id);

-- Refactored Query
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.user_id,
    b.property_id
FROM
    BOOKING b
WHERE
    b.status = 'confirmed';

EXPLAIN ANALYZE
SELECT
    py.amount,
    py.payment_date,
    py.payment_method
FROM
    PAYMENT py
WHERE
    py.amount >= 500;

