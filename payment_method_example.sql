/*
THE MOST POPULAR PAYMENT METHOD PER USER

For each user with at least 3 transactions with a single payment method, what's the most popular payment method used? 
If payment methods have the same count, return the first payment method used. Output the email, payment_method, 
and count sorted by payment count desc and email asc.

===========
TABLES
===========
amazon_users | user_id, email
amazon_transactions | transaction_id, user_id, product_id, payment_method
*/

WITH
  DATA_TABLE AS (
    SELECT 
      amazon_users.email
      ,amazon_transactions.payment_method
      ,COUNT(*) payment_counts
    FROM amazon_transactions
      JOIN amazon_users
        ON amazon_users.user_id = amazon_transactions.user_id
    GROUP BY
      amazon_users.email
      ,amazon_transactions.payment_method
    HAVING
      COUNT(*) >= 3
  )
  ,DATA_TABLE_TWO AS(
    SELECT
      DATA_TABLE.*
      ,LAST_VALUE(DATA_TABLE.payment_method) OVER (PARTITION BY DATA_TABLE.email) first_method
    FROM
      DATA_TABLE
  )
SELECT
  DATA_TABLE_TWO.email
  ,DATA_TABLE_TWO.payment_method
  ,DATA_TABLE_TWO.payment_counts
FROM
  DATA_TABLE_TWO
WHERE
  DATA_TABLE_TWO.payment_method = DATA_TABLE_TWO.first_method
ORDER BY 
  DATA_TABLE_TWO.payment_counts DESC
  ,DATA_TABLE_TWO.email ASC;

-- ==============
-- Query Output
-- ==============

-- email	                  payment_method	payment_counts
-- -------------------------------------------------------
-- CHernandez8@hotmail.com	credit	        4
-- MRobinson8@yahoo.com	    gift card	      4
-- CJohnston9@hotmail.com	  credit	        3
-- EKhan2@gmail.com	        credit	        3
-- JPearson3@yahoo.com	    credit	        3
-- LTaylor9@hotmail.com	    debit	          3
-- MJohnson7@gmail.com	    credit	        3
-- VLiu0@yahoo.com	        gift card	      3