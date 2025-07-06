
# Index Performance Analysis

Based on the common query patterns for our system, and the indexes created in the SQL file, we have identified three high-usage columns:

* **`User` Table**:
    * `user_id`: This is the primary key and is heavily used in `JOIN` clauses to link users to their bookings, reviews, and messages.
* **`Booking` Table**:
    * `user_id`: A foreign key used in `JOIN` clauses to connect a booking to the user who made it. This is critical for finding a user's booking history.
    * `property_id`: A foreign key used in `JOIN` clauses to connect a booking to a specific property. This is essential for finding all bookings for a property.
* **`Property` Table**:
    * `property_id`: The primary key used in `JOIN` clauses to link properties to bookings and reviews.

Check the "database_index.sql" file, to go over the queries used for this simple analysis.

### Query Performance Analysis: Before Indexing

These queries demonstrate the performance impact of missing indexes.

* Query 1: Performance for joining User and Booking tables.
Before indexing 'Booking(user_id)', this will likely cause a full table scan on the Booking table.

* Query 2: Performance for joining Property and Booking tables.
Before indexing 'Booking(property_id)', this will also likely cause a full table scan on the Booking table.

### Index Creation
Create Index on the user_id column in the Booking table.
This will significantly speed up joins between the User and Booking tables.
```sql
CREATE INDEX idx_booking_user_id ON Booking(user_id);
```

Create Index on the property_id column in the Booking table.
This will significantly speed up joins between the Property and Booking tables.
```sql
CREATE INDEX idx_booking_property_id ON Booking(property_id);
```


### Performance After Indexing
Re-running these queries after creating the indexes will make it so that the execution time are significantly lower.

* Query 1: Checks performance for User/Booking join.
Our queries should now use 'idx_booking_user_id'.

* Query 2: Checks performance for Property/Booking join.
Our queries should now use 'idx_booking_property_id'.