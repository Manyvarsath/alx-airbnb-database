CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');

CREATE TABLE "USER" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    role user_role NOT NULL DEFAULT 'guest',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);


CREATE INDEX idx_user_email ON "USER"(email);

CREATE TABLE PROPERTY (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    CONSTRAINT fk_host
        FOREIGN KEY(host_id)
        REFERENCES "USER"(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_property_host_id ON PROPERTY(host_id);
CREATE INDEX idx_property_location ON PROPERTY(location);

CREATE TABLE BOOKING (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    CONSTRAINT fk_property
        FOREIGN KEY(property_id)
        REFERENCES PROPERTY(property_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
        REFERENCES "USER"(user_id)
        ON DELETE SET NULL,

    CONSTRAINT check_dates CHECK (end_date > start_date)
);

CREATE INDEX idx_booking_property_id ON BOOKING(property_id);
CREATE INDEX idx_booking_user_id ON BOOKING(user_id);
CREATE INDEX idx_booking_status ON BOOKING(status);

CREATE TABLE PAYMENT (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL UNIQUE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    payment_method payment_method_enum NOT NULL,

    CONSTRAINT fk_booking
        FOREIGN KEY(booking_id)
        REFERENCES BOOKING(booking_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_payment_booking_id ON PAYMENT(booking_id);

CREATE TABLE REVIEW (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    CONSTRAINT fk_property_review
        FOREIGN KEY(property_id)
        REFERENCES PROPERTY(property_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user_review
        FOREIGN KEY(user_id)
        REFERENCES "USER"(user_id)
        ON DELETE CASCADE,

    CONSTRAINT check_rating CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT unique_review_per_user_property UNIQUE (user_id, property_id)
);

CREATE INDEX idx_review_property_id ON REVIEW(property_id);
CREATE INDEX idx_review_user_id ON REVIEW(user_id);

CREATE TABLE MESSAGE (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    CONSTRAINT fk_sender
        FOREIGN KEY(sender_id)
        REFERENCES "USER"(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_recipient
        FOREIGN KEY(recipient_id)
        REFERENCES "USER"(user_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_message_sender_id ON MESSAGE(sender_id);
CREATE INDEX idx_message_recipient_id ON MESSAGE(recipient_id);
CREATE INDEX idx_message_conversation ON MESSAGE(sender_id, recipient_id);
