INSERT INTO "USER" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('uid1378378', 'Wili', 'La', 'wili.la.host@example.com', 'hashed_password_1', '123-456-7890', 'host'),
('uid2378333', 'Hamid', 'Aji', 'hamid.aji.host@example.com', 'hashed_password_2', '234-567-8901', 'host'),
('uid3378377', 'Moul', 'Chkara', 'moul.chkara.guest@example.com', 'hashed_password_3', '345-678-9012', 'guest'),
('uid4737871', 'Machi', 'Kolo', 'machi.kolo.guest@example.com', 'hashed_password_4', '456-789-0123', 'guest');

INSERT INTO PROPERTY (property_id, host_id, name, description, location, price_per_night) VALUES
('pid178373', 'hid17837', 'Cozy Beachfront Cottage', 'A beautiful cottage right on the beach, perfect for a romantic getaway.', 'Malibu, CA', 250.00),
('pid245773', 'hid28723', 'Modern Downtown Loft', 'Stylish loft in the heart of the city, close to all attractions.', 'New York, NY', 350.50);

INSERT INTO PROPERTY (property_id, host_id, name, description, location, price_per_night) VALUES
('pid151679', 'hid15499', 'Rustic Mountain Cabin', 'Escape to this peaceful cabin in the woods. Great for hiking.', 'Aspen, CO', 180.75);

INSERT INTO BOOKING (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('bid51951', 'pid178373', 'uid47351571', '2025-08-01', '2025-08-07', 1500.00, 'confirmed');

INSERT INTO BOOKING (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('bid91155', 'pid151679', 'uid47581571', '2025-09-10', '2025-09-15', 903.75, 'confirmed');

INSERT INTO BOOKING (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('bid522211', 'pid245773', 'uid47351571', '2025-11-20', '2025-11-25', 1752.50, 'pending');

INSERT INTO PAYMENT (payment_id, booking_id, amount, payment_method) VALUES
('paid156612', 'bid51951', 1500.00, 'credit_card');

INSERT INTO PAYMENT (payment_id, booking_id, amount, payment_method) VALUES
('paid416516', 'bid91155', 903.75, 'paypal');

INSERT INTO REVIEW (review_id, property_id, user_id, rating, comment) VALUES
('rid56198', 'pid821312', 'uid5165132', 5, 'Absolutely stunning location and a wonderful host. The cottage was clean, comfortable, and had everything we needed. Will definitely be back!');

INSERT INTO REVIEW (review_id, property_id, user_id, rating, comment) VALUES
('rid49845', 'sid8941111', 4, 'Great cabin for a quiet getaway. The surroundings are beautiful. The cabin could have been a bit cleaner, but overall a great experience.');

INSERT INTO MESSAGE (message_id, sender_id, recipient_id, message_body) VALUES
('mid051', 'sid94619', 'reid5165165', 'Hi Jane, we are very excited about our upcoming stay! Just wanted to confirm if the cabin has a coffee maker? Thanks!');

INSERT INTO MESSAGE (message_id, sender_id, recipient_id, message_body) VALUES
('mid461', 'sid161655', 'reid165132', 'Hi Mary, absolutely! The cabin is equipped with a standard drip coffee maker and we provide some starter coffee grounds. Looking forward to hosting you!');

