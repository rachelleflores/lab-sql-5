# Unit 2 Lab 5
USE sakila;

# 1. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

SELECT *
FROM staff
LIMIT 5;

# 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT *
FROM customer
WHERE first_name = 'tammy' AND last_name = 'sanders';

INSERT INTO staff values (3,'Tammy','Sanders',79, 'Tammy.Sanders@sakilastaff.com',2,1,'Tammy','', current_timestamp());

SELECT *
FROM staff;

# 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
SELECT *
FROM film
WHERE title = "Academy Dinosaur";

SELECT *
FROM inventory
WHERE film_id = 1;

SELECT *
FROM rental;

SELECT customer_id FROM customer WHERE first_name = 'CHARLOTTE' and last_name = 'HUNTER';

INSERT INTO rental values (16050, current_timestamp(), 1, 130, DATE_ADD(current_date(), INTERVAL 6 DAY), 1, current_timestamp());

SELECT *
FROM rental
WHERE rental_id = 16050;

# 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
SELECT *
FROM customer
WHERE active = 0;

-- Create a table backup table as suggested / Insert the non active users in the table backup table
CREATE TABLE deleted_users
	AS (SELECT *
		FROM customer
		WHERE active = 0);

SELECT *
FROM deleted_users;        

-- Delete the non active users from the table customer

# Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`payment`, CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE)
SET FOREIGN_KEY_CHECKS=0;

DELETE FROM customer
WHERE active = 0;

SET FOREIGN_KEY_CHECKS=1;

SELECT *
FROM customer
WHERE active = 0;

SELECT * 
FROM rental as r
INNER JOIN deleted_users as d
ON r.customer_id = d.customer_id;

SELECT *
FROM deleted_users;

-- just inserting the deleted inactive users back to the customer table :)

INSERT INTO customer
SELECT * FROM deleted_users;

SELECT *
FROM customer
WHERE active = 0;