# Documentation: 

## File 1: joins_queries.sql

-- This file contains SQL queries based on the AirBnB database schema.

-- =================================================================
-- Query 1: INNER JOIN
-- Retrieve all bookings and the respective users who made them.
-- This query will only return bookings that have an associated user.
-- =================================================================

-- =================================================================
-- Query 2: LEFT JOIN
-- Retrieve all properties and their reviews, including properties
-- that have no reviews.
-- For properties without reviews, the review columns will be NULL.
-- =================================================================

-- =================================================================
-- Query 3: FULL OUTER JOIN
-- Retrieve all users and all bookings, showing all users even if
-- they have no bookings, and all bookings even if they are not
-- linked to a user (though the schema implies they always are).
-- Note: FULL OUTER JOIN is not supported in all SQL dialects (e.g., MySQL).
-- For MySQL, this can be simulated using a UNION of a LEFT JOIN and a RIGHT JOIN.
-- =================================================================

## File 2: 