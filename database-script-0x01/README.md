
# Explanation of the Database Schema SQL

---

## 1. Custom Type Definitions (ENUMs)

Before creating the tables, several custom ENUM types are defined. Using ENUMs is more efficient and provides better data integrity than using plain strings, as it restricts the possible values for a column to a predefined set.

- **`user_role`**: Defines the possible roles a user can have (`guest`, `host`, `admin`).
- **`booking_status`**: Defines the lifecycle states of a booking (`pending`, `confirmed`, `canceled`).
- **`payment_method_enum`**: Defines the accepted payment methods (`credit_card`, `paypal`, `stripe`).

---

## 2. Table Creation

Each table is created with specific columns, data types, and constraints to enforce the rules of the database logic.

### Table: `USER`

**Purpose**: Stores all user account information.

**Columns**:
- `user_id`: A UUID serving as the primary key, automatically generated.
- `first_name`, `last_name`: The user's name (cannot be null).
- `email`: The user's email address, which must be unique for each user.
- `password_hash`: Stores the hashed password for security.
- `role`: The user's role, using the `user_role` ENUM type.
- `created_at`: A timestamp that records when the user account was created.

**Indexes**:
- `idx_user_email`: An index on the `email` column to speed up login authentications and lookups.

---

### Table: `PROPERTY`

**Purpose**: Stores details about the properties available for rent.

**Columns**:
- `property_id`: A UUID serving as the primary key.
- `host_id`: A foreign key that references `USER(user_id)`, linking the property to its host.
- `name`, `description`, `location`, `price_per_night`: Attributes describing the property.
- `updated_at`: A timestamp to track the last modification.

**Constraints**:
- `fk_host`: Ensures that every property has a valid host. `ON DELETE CASCADE` deletes all properties if the host is deleted.

**Indexes**:
- `idx_property_host_id`: Speeds up queries that fetch all properties belonging to a specific host.
- `idx_property_location`: Optimizes searches for properties based on their location.

---

### Table: `BOOKING`

**Purpose**: Manages all booking records.

**Columns**:
- `booking_id`: A UUID serving as the primary key.
- `property_id`, `user_id`: Foreign keys linking the booking to a property and the guest.
- `start_date`, `end_date`: The duration of the booking.
- `total_price`: The calculated price for the stay.
- `status`: The current booking status using the `booking_status` ENUM.

**Constraints**:
- `fk_property`: Links to `PROPERTY`. `ON DELETE CASCADE`.
- `fk_user`: Links to `USER`. `ON DELETE SET NULL`.
- `check_dates`: Ensures `end_date` is after `start_date`.

**Indexes**:
- `idx_booking_property_id`, `idx_booking_user_id`: Improve JOIN performance.
- `idx_booking_status`: Speeds up filtering by status (e.g., 'confirmed').

---

### Table: `PAYMENT`

**Purpose**: Stores payment information for each booking.

**Columns**:
- `payment_id`: A UUID serving as the primary key.
- `booking_id`: A foreign key linking the payment to a booking. `UNIQUE` for one-to-one relation.

**Constraints**:
- `fk_booking`: Links to `BOOKING`. `ON DELETE CASCADE`.

**Indexes**:
- `idx_payment_booking_id`: Quickly fetch payment details for a booking.

---

### Table: `REVIEW`

**Purpose**: Stores user reviews for properties.

**Columns**:
- `review_id`: A UUID serving as the primary key.
- `property_id`, `user_id`: Foreign keys linking the review to the property and user.
- `rating`: An integer for the review score.

**Constraints**:
- `fk_property_review`, `fk_user_review`: With `ON DELETE CASCADE`.
- `check_rating`: Ensures `rating` is between 1 and 5.
- `unique_review_per_user_property`: Ensures a user can only write one review per property.

**Indexes**:
- `idx_review_property_id`, `idx_review_user_id`: Improve performance on joins and filters.

---

### Table: `MESSAGE`

**Purpose**: Stores communication between users (e.g., guest to host).

**Columns**:
- `message_id`: A UUID serving as the primary key.
- `sender_id`, `recipient_id`: Foreign keys referencing `USER`.

**Constraints**:
- `fk_sender`, `fk_recipient`: With `ON DELETE CASCADE`.

**Indexes**:
- `idx_message_sender_id`, `idx_message_recipient_id`: Quickly find all messages by user.
- `idx_message_conversation`: Composite index on `(sender_id, recipient_id)` to optimize message history lookups.
