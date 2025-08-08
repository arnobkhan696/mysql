create database employe;
use employe;

CREATE TABLE employe (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100) NOT NULL,
   age INT CHECK (age >= 18),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000.00
);

# 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
# => Constraints are rules applied to columns in a database table to enforce data integrity, accuracy, and reliability. They ensure that only valid data can be inserted, updated, or deleted from a database table.
# Example
#create database company_db;
#USE company_db;

#CREATE TABLE departments (
 #   dept_id INT PRIMARY KEY,
 #   dept_name VARCHAR(100) NOT NULL
#);
#CREATE TABLE employees (
#    emp_id INT PRIMARY KEY,
 #   emp_name VARCHAR(100) NOT NULL,
 #   age INT CHECK (age >= 18),
#    email VARCHAR(255) UNIQUE,
#    salary DECIMAL(10, 2) DEFAULT 30000.00,
#    dept_id INT,
#    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
#);

# 3. Why would you apply the NOT NULL constraint to a column? Justify your answer?
# => The NOT NULL constraint is used to ensure that a column cannot contain NULL values. This is important when:
# i) The data is mandatory for the application logic (e.g., name, ID, email).
# ii) You want to enforce data integrity and avoid incomplete or meaningless records. 

# Can a primary key contain NULL values?
# => No, a primary key cannot contain NULL values.

# Justify your answer?
#Definition of Primary Key:
# i) A primary key is meant to uniquely identify each row in a table.
# ii) By definition, it must always have a value (NOT NULL) and must be unique.

# 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint. 
# => Add a Constraint:
# Use ALTER TABLE followed by ADD CONSTRAINT or directly define the change.
# You must give the constraint a name (except for NOT NULL, which doesn’t require a name).
ALTER TABLE employe
ADD CONSTRAINT unique_email UNIQUE (email);

# => Remove a Constraint:
# Use ALTER TABLE followed by DROP CONSTRAINT constraint_name (or MODIFY for NOT NULL).
ALTER TABLE employe
DROP INDEX unique_email;

# 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
# => If you attempt to insert, update, or delete data in a way that violates these constraints, the database will reject the operation and return an error message.
# PRIMARY KEY Violation
# What happens: Trying to insert a duplicate or NULL in a primary key column.
# Example:
# INSERT INTO employees (emp_id, emp_name) VALUES (1, 'John');
-- Try inserting again:
# INSERT INTO employees (emp_id, emp_name) VALUES (1, 'Jane');
# Error (MySQL):
# ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'

# UNIQUE Constraint Violation
# What happens: Trying to insert/update a value that already exists in a column with a UNIQUE constraint.
# Example:
# INSERT INTO employees (emp_id, email) VALUES (2, 'john@example.com');
# Error:
# ERROR 1062 (23000): Duplicate entry 'john@example.com' for key 'unique_email'

# 6. You created a products table without constraints as follows:
#CREATE TABLE products (
#    product_id INT,
#    product_name VARCHAR(50),
#    price DECIMAL(10, 2));
#Now, you realise that?
# The product_id should be a primary keyQ
# The price should have a default value of 50.00
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00; 

# 7. You have two tables:
# Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
SELECT 
    students.student_name, 
    classes.class_name
FROM 
    students
INNER JOIN 
    classes 
ON 
    students.class_id = classes.class_id;
    
# 8. Consider the following three tables:
# Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are  listed even if they are not associated with an order  
# Hint: (use INNER JOIN and LEFT JOIN)
create database customer;
USE customer;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

-- Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- Insert data into products
INSERT INTO products (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Mouse'),
(103, 'Keyboard'),
(104, 'Monitor');

-- Insert data into orders
INSERT INTO orders (order_id, customer_id, product_id) VALUES
(1001, 1, 101),
(1002, 2, 103),
(1003, 1, 104);

# Final Query
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    products p
LEFT JOIN 
    orders o ON p.product_id = o.product_id
LEFT JOIN 
    customers c ON o.customer_id = c.customer_id;
    
# 9. Given the following tables:
# Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
SELECT 
    p.product_name,
    SUM(o.quantity * o.price_per_unit) AS total_sales
FROM 
    orders o
INNER JOIN 
    products p ON o.product_id = p.product_id
GROUP BY 
    p.product_name;
    
# 10. You are given three tables:
# Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.
SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
INNER JOIN 
    order_details od ON o.order_id = od.order_id;
    
#SQL Commands
USE MavenMovies;
# 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
# To list all PRIMARY KEYS:
SELECT 
    TABLE_NAME, 
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'mavenmovies';
    
#To list all FOREIGN KEYS:
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME IS NOT NULL
    AND TABLE_SCHEMA = 'mavenmovies';

# 2- List all details of actors
SELECT * 
FROM actor
ORDER BY last_name, first_name;
# 3 -List all customer information from DB
SELECT * FROM customer;
# 4 -List different countries
SELECT DISTINCT country 
FROM country;
# 5 -Display all active customers
SELECT * 
FROM customer
WHERE active = 1;
# 6-List of all rental IDs for customer with ID 1.
SELECT rental_id
FROM rental
WHERE customer_id = 1;
# 7 - Display all the films whose rental duration is greater than 5.
SELECT *
FROM film
WHERE rental_duration > 5;
# 8 - List the total number of films whose replacement cost is greater than $15 and less than $20. 
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20; 
# 9 - Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor; 
# 10- Display the first 10 records from the customer table.
SELECT *
FROM customer
LIMIT 10;
# 11 - Display the first 3 records from the customer table whose first name starts with 'b'
SELECT *
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;
# 12 -Display the names of the first 5 movies which are rated as 'G'
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;
# 13-Find all customers whose first name starts with "a"
SELECT *
FROM customer
WHERE first_name LIKE 'A%';
# 14- Find all customers whose first name ends with "a"
SELECT *
FROM customer
WHERE first_name LIKE '%a';
# 15- Display the list of first 4 cities which start and end with ‘a’
SELECT city
FROM city
WHERE city LIKE 'A%a'
LIMIT 4;
# 16- Find all customers whose first name have "NI" in any position
SELECT *
FROM customer
WHERE first_name LIKE '%NI%';
# 17- Find all customers whose first name have "r" in the second position
SELECT *
FROM customer
WHERE first_name LIKE '_r%';
# 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length
SELECT *
FROM customer
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;
# 19- Find all customers whose first name starts with "a" and ends with "o"
SELECT *
FROM customer
WHERE first_name LIKE 'A%o';
# 20 - Get the films with pg and pg-13 rating using IN operator
SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');
# 21 - Get the films with length between 50 to 100 using between operator
SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;
# 22 - Get the top 50 actors using limit operator
SELECT *
FROM actor
LIMIT 50;
# 23 - Get the distinct film ids from inventory table
SELECT DISTINCT film_id
FROM inventory;

# Functions
# Basic Aggregate Functions:

# Question 1:
# Retrieve the total number of rentals made in the Sakila database.
# Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals
FROM rental;

# Question 2:
# Find the average rental duration (in days) of movies rented from the Sakila database.
# Hint: Utilize the AVG() function
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

# String Functions:
# Question 3:
# Display the first name and last name of customers in uppercase.
# Hint: Use the UPPER () function.
SELECT 
    UPPER(first_name) AS first_name_upper,
    UPPER(last_name) AS last_name_upper
FROM customer;

# Question 4:
# Extract the month from the rental date and display it alongside the rental ID.
# Hint: Employ the MONTH() function.
SELECT 
    rental_id,
    MONTH(rental_date) AS rental_month
FROM rental;

# Question 5:
# Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
# Hint: Use COUNT () in conjunction with GROUP BY.
SELECT 
    customer_id,
    COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

# Question 6:
# Find the total revenue generated by each store.
# Hint: Combine SUM() and GROUP BY
SELECT 
    staff.store_id,
    SUM(payment.amount) AS total_revenue
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
GROUP BY staff.store_id;

# Question 7:
# Determine the total number of rentals for each category of movies.
# Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY
SELECT 
    category.name AS category_name,
    COUNT(rental.rental_id) AS total_rentals
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

# Question 8:
# Find the average rental rate of movies in each language.
# Hint: JOIN film and language tables, then use AVG () and GROUP BY
SELECT 
    language.name AS language_name,
    AVG(film.rental_rate) AS average_rental_rate
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;

# Questions 9 -
# Display the title of the movie, customer s first name, and last name who rented it.
# Hint: Use JOIN between the film, inventory, rental, and customer tables
SELECT 
    film.title AS movie_title,
    customer.first_name,
    customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

# Question 10:
# Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
# Hint: Use JOIN between the film actor, film, and actor tables
SELECT 
    actor.first_name,
    actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.title = 'Gone with the Wind';

# Question 11:
# Retrieve the customer names along with the total amount they've spent on rentals.
# Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY
SELECT 
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_spent
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;

# Question 12:
# List the titles of movies rented by each customer in a particular city (e.g., 'London').
# Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY
SELECT 
    customer.first_name,
    customer.last_name,
    film.title AS movie_title
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE city.city = 'London'
ORDER BY customer.last_name, customer.first_name, film.title;

# Question 13:
# Display the top 5 rented movies along with the number of times they've been rented.
# Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results
SELECT 
    film.title,
    COUNT(rental.rental_id) AS times_rented
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY times_rented DESC
LIMIT 5;

# Question 14:
# Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
# Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY. 
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT inventory.store_id) = 2;

# Windows Function:
# 1. Rank the customers based on the total amount they've spent on rentals. 
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS `rank`
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC;
# 2. Calculate the cumulative revenue generated by each film over time
SELECT
    f.film_id,
    f.title,
    p.payment_date,
    SUM(p.amount) AS revenue,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
ORDER BY 
    f.film_id, p.payment_date;
# 3. Determine the average rental duration for each film, considering films with similar lengths
SELECT
    CONCAT(FLOOR(f.length / 10) * 10, '-', FLOOR(f.length / 10) * 10 + 9) AS length_range,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration_days,
    COUNT(*) AS total_rentals
FROM
    rental r
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
WHERE
    r.return_date IS NOT NULL
GROUP BY
    length_range
ORDER BY
    FLOOR(f.length / 10);
# 4. Identify the top 3 films in each category based on their rental counts
SELECT
    c.name AS category,
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY
    c.name, f.title
HAVING
    rank_in_category <= 3
ORDER BY
    c.name, rank_in_category;
# 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals  across all customers
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS total_rentals,
    ROUND(AVG(total_rentals.total) OVER (), 2) AS avg_rentals_across_all,
    COUNT(r.rental_id) - AVG(total_rentals.total) OVER () AS difference_from_avg
FROM
    customer c
LEFT JOIN
    rental r ON c.customer_id = r.customer_id
JOIN (
    SELECT customer_id, COUNT(rental_id) AS total
    FROM rental
    GROUP BY customer_id
) AS total_rentals ON total_rentals.customer_id = c.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name;
# 6. Find the monthly revenue trend for the entire rental store over time
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM
    payment
GROUP BY
    DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY
    month;
# 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers
WITH customer_spending AS (
    SELECT
        customer_id,
        CONCAT(first_name, ' ', last_name) AS customer_name,
        SUM(amount) AS total_spent,
        PERCENT_RANK() OVER (ORDER BY SUM(amount)) AS spending_percentile
    FROM
        customer
    JOIN
        payment USING (customer_id)
    GROUP BY
        customer_id, first_name, last_name
)
SELECT *
FROM customer_spending
WHERE spending_percentile >= 0.80
ORDER BY total_spent DESC;
# 8. Calculate the running total of rentals per category, ordered by rental count
WITH category_rentals AS (
    SELECT
        c.name AS category,
        COUNT(r.rental_id) AS rental_count
    FROM
        rental r
    JOIN
        inventory i ON r.inventory_id = i.inventory_id
    JOIN
        film f ON i.film_id = f.film_id
    JOIN
        film_category fc ON f.film_id = fc.film_id
    JOIN
        category c ON fc.category_id = c.category_id
    GROUP BY
        c.name
)
SELECT
    category,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM
    category_rentals
ORDER BY
    rental_count DESC;
# 9. Find the films that have been rented less than the average rental count for their respective categories
WITH film_rentals AS (
    SELECT
        f.film_id,
        f.title,
        c.name AS category,
        COUNT(r.rental_id) AS film_rental_count
    FROM
        film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, c.name
),
category_avg AS (
    SELECT
        category,
        AVG(film_rental_count) AS avg_rental_count
    FROM
        film_rentals
    GROUP BY
        category
)
SELECT
    fr.film_id,
    fr.title,
    fr.category,
    fr.film_rental_count,
    ca.avg_rental_count
FROM
    film_rentals fr
JOIN
    category_avg ca ON fr.category = ca.category
WHERE
    fr.film_rental_count < ca.avg_rental_count
ORDER BY
    fr.category, fr.film_rental_count;
# 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM
    payment
GROUP BY
    DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY
    monthly_revenue DESC
LIMIT 5;

# Normalisation & CTE
# 1. First Normal Form (1NF):
# a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF. 
# While most of the Sakila schema is well-normalized, if we imagine a poorly designed address table like this
# How to Normalize It to 1NF:
# We break out the multi-valued attribute into a new table

# 2. Second Normal Form (2NF):
# a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
# If it violates 2NF, explain the steps to 
#I chose the film_actor table from the Sakila database to check for 2NF compliance.
#This table has a composite primary key consisting of actor_id and film_id, and one non-key attribute last_update.
#I examined whether last_update is fully dependent on both parts of the primary key. Since the timestamp of when an actor was associated with a film depends on both the actor #and the film, the dependency is full.
#Therefore, film_actor is in 2NF.

#If this table had attributes like actor_name or film_title, which depend only on part of the composite key, it would violate 2NF. To normalize it, I would move those #attributes into separate actor and film tables and keep only foreign keys in film_actor.

# 3. Third Normal Form (3NF):
# a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
# present and outline the steps to normalize the table to 3NF.
#I chose the customer table from the Sakila database to evaluate for 3NF.
#In a hypothetical denormalized version of this table, suppose it includes columns like city_name and country_name directly.
#These values are not directly dependent on the primary key customer_id, but are instead dependent on address_id, which links to the city_id and then to country_id.
#This is a transitive dependency, which violates the rules of Third Normal Form.
#To normalize the table:

#Remove city_name and country_name from the customer table.

#Store them in their respective city and country tables.

#Use foreign keys (address_id → city_id → country_id) to reference this information when needed.

#This ensures that all non-key attributes in the customer table depend only on the primary key, satisfying 3NF.

