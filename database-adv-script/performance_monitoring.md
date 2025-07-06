# Monitoring Performance

### Analysis of EXPLAIN ANALYZE Output

* For Query A (Property Reviews):
  - Bottleneck: The initial `EXPLAIN` (before adding indexes from the
    previous step) would likely show a "Sequential Scan" on the `REVIEW`
    table. Even with an index on `property_id`, the database still has to
    fetch user details, which involves another lookup.
  - Suggestion: The existing indexes `idx_review_property_id` and
    `idx_review_user_id` are good. No major changes are needed here if
    they are already in place. The join is on a UUID which is efficient.
* For Query B (User's Bookings):
  - Bottleneck: The query filters by `user_id` and `status`, and then sorts
    by `start_date`. An index on `user_id` (`idx_booking_user_id`) will
    help find the initial set of bookings for the user quickly. However,
    the database then has to:
      1. Filter these results further by `status = 'confirmed'`.
      2. Sort the remaining results by `start_date DESC`.
    This sorting step can be slow if the user has many bookings, as it
    might require an "in-memory sort" or even a temporary file on disk
    ("external merge"), which is very slow.
  - Suggestion: Create a **composite index** on the `BOOKING` table. A
    composite index includes multiple columns and can optimize queries
    that filter and sort on those specific columns. The ideal index
    would be on `(user_id, status, start_date)`.


### Implement the Changes

Based on the analysis of Query B, we will create a new composite index
to optimize filtering by user and status, and sorting by date.

```sql
CREATE INDEX idx_booking_user_status_date ON BOOKING(user_id, status, start_date DESC);
```

### Report the Improvements

Report on Performance Improvements
After creating the composite index `idx_booking_user_status_date`, we
would re-run the `EXPLAIN ANALYZE` for Query B.

**Expected Improvements for Query B:**
1.  **Elimination of Sort Step:**
    The primary improvement is that the database can now read the data
    directly from the index in the correctly sorted order (`start_date DESC`).
    The `EXPLAIN` plan will no longer show a separate `Sort` node. Instead,
    it will likely show an "Index Scan" using our new composite index.
    This avoids the costly in-memory or on-disk sorting operation.

2.  **Faster Filtering:**
    The index allows the database to instantly locate the rows matching
    both `user_id` and `status = 'confirmed'` without having to scan
    a large number of rows belonging to the user that might have a
    different status.

3.  **Reduced Execution Time:**
    The combination of faster filtering and eliminating the sort operation
    will lead to a dramatic reduction in the query's total execution time,
    especially for users with a long history of bookings. The query will
    feel much more responsive to the end-user.

**Conclusion:**
Proactive monitoring with tools like `EXPLAIN ANALYZE` is crucial for
identifying performance bottlenecks. In this case, a simple query for a
user's booking history was significantly optimized by adding a single,
well-designed composite index. This demonstrates that schema refinement
based on real-world query patterns is a powerful and necessary practice
for database management.
