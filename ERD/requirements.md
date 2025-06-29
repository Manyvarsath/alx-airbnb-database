# Airbnb Database Schema Analysis

This document outlines the structure of the Airbnb-style database, detailing the entities (tables), their attributes (columns), and the relationships between them.

### Entities and Attributes

Below are the six main entities in the database schema.

#### 👤 User

Stores information about all users, who can be guests, hosts, or administrators.

| Attribute | Data Type | Constraints/Notes |
| :--- | :--- | :--- |
| `user_id` | `UUID` | **Primary Key** |
| `first_name` | `VARCHAR` | NOT NULL |
| `last_name` | `VARCHAR` | NOT NULL |
| `email` | `VARCHAR` | UNIQUE, NOT NULL |
| `password_hash` | `VARCHAR` | NOT NULL |
| `phone_number`| `VARCHAR` | NULLABLE |
| `role` | `ENUM` | 'guest', 'host', 'admin' |
| `created_at` | `TIMESTAMP` | Record creation timestamp |

---

#### 🏠 Property

Contains details about the listings available for rent.

| Attribute | Data Type | Constraints/Notes |
| :--- | :--- | :--- |
| `property_id` | `UUID` | **Primary Key** |
| `host_id` | `UUID` | **Foreign Key** (references `User.user_id`) |
| `name` | `VARCHAR` | NOT NULL |
| `description` | `TEXT` | NOT NULL |
| `location` | `VARCHAR` | NOT NULL |
| `price_per_night`| `DECIMAL` | NOT NULL |
| `created_at` | `TIMESTAMP` | Record creation timestamp |
| `updated_at` | `TIMESTAMP` | Record last update timestamp |

---

#### 🗓️ Booking

Represents a reservation made by a user for a specific property.

| Attribute | Data Type | Constraints/Notes |
| :--- | :--- | :--- |
| `booking_id` | `UUID` | **Primary Key** |
| `property_id` | `UUID` | **Foreign Key** (references `Property.property_id`) |
| `user_id` | `UUID` | **Foreign Key** (references `User.user_id`) |
| `start_date` | `DATE` | NOT NULL |
| `end_date` | `DATE` | NOT NULL |
| `total_price` | `DECIMAL` | NOT NULL |
| `status` | `ENUM` | 'pending', 'confirmed', 'canceled' |
| `created_at` | `TIMESTAMP` | Record creation timestamp |

---

#### 💳 Payment

Stores payment information related to a booking.

| Attribute | Data Type | Constraints/Notes |
| :--- | :--- | :--- |
| `payment_id` | `UUID` | **Primary Key** |
| `booking_id` | `UUID` | **Foreign Key** (references `Booking.booking_id`) |
| `amount` | `DECIMAL` | NOT NULL |
| `payment_date`| `TIMESTAMP` | Payment completion timestamp |
| `payment_method`| `ENUM` | 'credit_card', 'paypal', 'stripe' |

---

#### ⭐ Review

Holds user-submitted reviews and ratings for properties.

| Attribute | Data Type | Constraints/Notes |
| :--- | :--- | :--- |
| `review_id` | `UUID` | **Primary Key** |
| `property_id` | `UUID` | **Foreign Key** (references `Property.property_id`) |
| `user_id` | `UUID` | **Foreign Key** (references `User.user_id`) |
| `rating` | `INTEGER` | NOT NULL, CHECK (1-5) |
| `comment` | `TEXT` | NOT NULL |
| `created_at` | `TIMESTAMP` | Record creation timestamp |

---

#### ✉️ Message

Represents messages sent between users (e.g., guest to host).

| Attribute | Data Type | Constraints/Notes |
| :--- | :--- | :--- |
| `message_id` | `UUID` | **Primary Key** |
| `sender_id` | `UUID` | **Foreign Key** (references `User.user_id`) |
| `recipient_id`| `UUID` | **Foreign Key** (references `User.user_id`) |
| `message_body`| `TEXT