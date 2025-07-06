
# Normalization Analysis

The process of normalization aims to reduce data redundancy and improve data integrity by organizing a database into tables and columns. The key normal forms are:

- **First Normal Form (1NF)**
- **Second Normal Form (2NF)**
- **Third Normal Form (3NF)**

---

## First Normal Form (1NF)

A table is in **1NF** if all its attributes are **atomic**, meaning each cell contains a single, indivisible value, and each entry has a unique primary key.

### Tables in 1NF

- **USER**:  
  All attributes (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`) are atomic.  
  **Primary key**: `user_id`

- **PROPERTY**:  
  All attributes (`property_id`, `host_id`, `name`, `description`, `location`, `price_per_night`, `created_at`, `updated_at`) are atomic.  
  **Primary key**: `property_id`

- **BOOKING**:  
  All attributes (`booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`) are atomic.  
  **Primary key**: `booking_id`

- **PAYMENT**:  
  All attributes (`payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`) are atomic.  
  **Primary key**: `payment_id`

- **REVIEW**:  
  All attributes (`review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`) are atomic.  
  **Primary key**: `review_id`

- **MESSAGE**:  
  All attributes (`message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`) are atomic.  
  **Primary key**: `message_id`

✅ **Conclusion**: All tables in the schema satisfy the requirements of 1NF.

---

## Second Normal Form (2NF)

A table is in **2NF** if it is in 1NF and every non-primary-key attribute is **fully functionally dependent** on the entire primary key. This rule applies mainly to tables with **composite primary keys**.

In this schema, **every table has a single-column primary key** (e.g., `user_id`, `property_id`, `booking_id`, etc.). Therefore, **no partial dependencies** exist.

✅ **Conclusion**: All tables in the schema inherently satisfy 2NF.

---

## Third Normal Form (3NF)

A table is in **3NF** if it is in 2NF and there are **no transitive dependencies**.  
A transitive dependency exists when a non-key attribute depends on another non-key attribute, which in turn depends on the primary key.

### Analysis by Table

- **USER**:  
  Attributes like `first_name`, `last_name`, and `email` depend directly on `user_id`.  
  No transitive dependencies.

- **PROPERTY**:  
  `name`, `description`, and `location` depend directly on `property_id`.  
  `host_id` is a foreign key and is also directly related to `property_id`.

- **BOOKING**:  
  `start_date`, `end_date`, and `total_price` depend on `booking_id`.  
  `property_id` and `user_id` are foreign keys.  
  ⚠️ **Note**: While `total_price` could theoretically be calculated from `price_per_night` and the duration (`end_date - start_date`), it is stored to capture the value at time of booking—thus it is still directly dependent on `booking_id`.

- **PAYMENT**:  
  `amount`, `payment_date`, and `payment_method` depend on `payment_id`.  
  `booking_id` is a foreign key.

- **REVIEW**:  
  `rating` and `comment` depend on `review_id`.  
  `property_id` and `user_id` are foreign keys.

- **MESSAGE**:  
  `message_body` and `sent_at` depend on `message_id`.  
  `sender_id` and `recipient_id` are foreign keys.

✅ **Conclusion**: No transitive dependencies exist in any of the tables. Therefore, the entire schema is in **3NF**.

