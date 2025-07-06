# Partitioning Performance

To improve our queries' performance, we implement table partitioning on the BOOKING table to optimize queries on large datasets, particularly those involving date ranges.

Note on the Database System: The following syntax is for PostgreSQL. Syntax for other systems like MySQL or SQL Server will likely differ.

### Step 1: Implement Partitioning on the BOOKING table

- In a real-world scenario, we would first rename the existing BOOKING table, create a new partitioned table with the original name, and then migrate the data. For this educational project, we'll just define the creation of a new partitioned table.

- We also create the main partitioned table (the "parent" table). This table itself does not store any data. It acts as a template for the partitions. We are partitioning by RANGE on the `start_date` column.

- After the first two steps, we create the actual partitions (the "child" tables). Each partition will store a subset of the data based on the start_date range. and we assume the creation of partitions for each year.

- It's also good practice to create a default partition to catch any data that doesn't fit into the other defined partitions.

- After creating the partitions, we migrate the data from the old BOOKING table into the new BOOKING_PARTITIONED table. INSERT INTO BOOKING_PARTITIONED SELECT * FROM BOOKING;

### Step 2: Test Performance of Queries on the Partitioned Table

We test a query that fetches bookings within a specific date range. This type of query is where partitioning shows its greatest strength.

Example Query: Fetch all confirmed bookings for the first quarter of 2024.
The EXPLAIN ANALYZE command shows the query plan and actual execution stats.

## Analysis Of The Partitioning

1.  **Partition Pruning:**
    When we run the test query with the WHERE clause on `start_date`, the PostgreSQL query planner is smart enough to know that the required data only exists in the `booking_y2024` partition. This is called "partition pruning" or "partition elimination".
    The `EXPLAIN ANALYZE` output would show that the database only performs a scan on the `booking_y2024` table. It completely ignores the other partitions (`booking_y2023`, `booking_y2025`, `booking_default`), as if they didn't exist for this query.

2.  **Reduced Scan Size:**
    Instead of scanning the entire `BOOKING_PARTITIONED` table (which could contain millions of rows), the database only needs to scan the much smaller `booking_y2024` partition. This dramatically reduces the amount of data that needs to be read from disk, leading to a significant reduction in query execution time and I/O operations.

3.  **Improved Index Performance:**
    Indexes on a partitioned table are also partitioned (they are created on a per-partition basis). This means that indexes are smaller and more efficient. When querying a specific partition, the database uses a smaller, more manageable index, which further speeds up data retrieval.

4.  **Maintenance Benefits:**
    Partitioning also simplifies data management. For example, if you need to archive or delete old data (e.g., all bookings from 2023), you can simply detach or drop the `booking_y2023` partition. This is an almost instantaneous metadata operation, whereas a `DELETE FROM ...` on a massive, non-partitioned table would be extremely slow and resource-intensive.

**Conclusion:**
For large, growing tables like `BOOKING`, partitioning by a frequently
queried column like `start_date` is a powerful optimization technique. It
significantly improves the performance of queries that filter by that
column by drastically reducing the amount of data the database needs to
process.
