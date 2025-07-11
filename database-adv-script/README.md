# Documentation: 

## File 1: joins_queries.sql

This file contains SQL queries based on the AirBnB database schema.

* Query 1: INNER JOIN
Retrieve all bookings and the respective users who made them. This query will only return bookings that have an associated user.

* Query 2: LEFT JOIN
Retrieve all properties and their reviews, including properties that have no reviews. For properties without reviews, the review columns will be NULL.

* Query 3: FULL OUTER JOIN
Retrieve all users and all bookings, showing all users even if they have no bookings, and all bookings even if they are not linked to a user.

## File 2: subqueries.sql

This file contains SQL queries using subqueries for the AirBnB database schema.

* Query 1: Subquery
Find all properties where the average rating is greater than 4.0. This uses a subquery to first find the property_ids that meet the average rating criteria from the Review table.

* Query 2: Correlated Subquery
Find all users who have made more than 3 bookings. This uses a correlated subquery that executes once for each row processed by the outer query to count the number of bookings for that user.

## File 3: aggregations_and_window_functions.sql

This file contains SQL queries using grouping and window functions for the AirBnB database schema.

* Query 1: GROUP BY
Find the total number of bookings made by each user. This uses the COUNT function with a GROUP BY clause to aggregate bookings for each user.

* Query 2: Window Functions
Rank properties based on the total number of bookings they have received. This uses the RANK() and ROW_NUMBER() window functions to assign corresponding rank and row number to each property based on its booking count.

## File 4: index_performance.md

This file contains information about index performance measurements for optimizing queries.

## File 5:  database_index.sql

This file contains relevant queries and commands mentionned in "File 4"

## File 6:

