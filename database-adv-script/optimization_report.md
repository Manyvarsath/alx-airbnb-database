
# Query Performance and Refactoring Analysis

This document analyzes a complex query that joins multiple tables, identifies performance inefficiencies, and provides a refactored approach to improve execution time.

---

## 1. The Initial Query

The starting point is a query designed to retrieve a comprehensive record for each booking, pulling related data from the `User`, `Property`, and `Payment` tables.

```sql
SELECT
    b.booking_id, b.start_date, b.end_date, b.status,
    u.first_name, u.last_name, u.email,
    p.name AS property_name, p.location,
    pay.payment_id, pay.amount, pay.payment_date, pay.payment_method
FROM
    Booking AS b
JOIN User AS u ON b.user_id = u.user_id
JOIN Property AS p ON b.property_id = p.property_id
JOIN Payment AS pay ON b.booking_id = pay.booking_id;
```

---

## 2. Performance Analysis with `EXPLAIN`

Running `EXPLAIN ANALYZE` on this query—especially on a database **without proper indexes** on foreign key columns—would reveal several inefficiencies:

- **Sequential Scans**:  
  The most significant issue would be the database performing a sequential scan on the `Payment` table. To find the matching payment for each booking, it would need to scan the entire `Payment` table for every row from the `Booking` table. This scales poorly as the table grows.

- **Multiple Joins**:  
  While necessary, each join adds computational overhead. The cost increases significantly without indexing.

- **Join Order**:  
  The query planner may not select the most optimal order to join tables, further increasing execution time.

The `EXPLAIN` output would likely show:
- High estimated cost
- Sequential scans dominating the plan (especially on `Payment`)

---

## 3. Refactoring the Query and Underlying Structure

In this case, the query logic is sound. The most effective refactoring is not changing the query itself, but **optimizing the database structure**. This is done by adding an index.

###  The Inefficiency

The core problem lies in the join condition:

```sql
ON b.booking_id = pay.booking_id
```

Without an index on `Payment(booking_id)`, this lookup is inefficient.

###  The Solution: Add an Index

Create an index on the foreign key column used in the join:

```sql
-- Create an index on the column used in the JOIN condition
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
```

---

## 4. Performance After Refactoring (Indexing)

After creating the index, the performance of the original query improves dramatically.

Running `EXPLAIN ANALYZE` again would now show:

- **Index Scan**:  
  Instead of a sequential scan, the database uses `idx_payment_booking_id` to perform efficient lookups on the `Payment` table.

- **Lower Cost**:  
  Both estimated cost and actual execution time drop significantly.

---

## Summary

> By optimizing the schema, we significantly improve query performance without touching the SQL.
