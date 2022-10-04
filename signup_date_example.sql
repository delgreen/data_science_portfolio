-- AMAZON PRIME USERS WITH CLOTHING AND JEWELRY PRODUCTS

-- Among prime users who purchased products in the
--   cloting or jewelry categories, output the email
--   address in the ascending order of their prime
--   sign_up date

-- =========
-- TABLES
-- =========
-- amazon_users | user_id, prime_joined_dt, email
-- amazon_products | product_id, category
-- amazon_transactions | product_id, transation_id, user_id

SELECT DISTINCT
  amazon_users.email
  ,DATE_FORMAT(amazon_users.prime_joined_dt, '%Y-%m-%d') prime_joined_dt
FROM
  amazon_transactions
    JOIN amazon_products
      ON amazon_products.product_id = amazon_transactions.product_id
    JOIN amazon_users
      ON amazon_users.user_id = amazon_transactions.user_id
WHERE
  amazon_users.prime_joined_dt > 0
  AND amazon_products.category IN ('jewelry', 'clothing')
ORDER BY
  DATE_FORMAT(amazon_users.prime_joined_dt, '%Y-%m-%d');

-- =========
-- QUERY OUTPUT
-- =========
-- email	                prime_joined_dt
-- -----------------------------------------
-- RCaldwell9@yahoo.com	    2022-01-07
-- KPerez4@hotmail.com	    2022-01-09
-- FSmith3@yahoo.com	    2022-01-12
-- VReynolds0@hotmail.com	2022-01-13
-- MWhite2@gmail.com	    2022-01-14
-- AElliott4@gmail.com	    2022-01-15
-- JJordan4@yahoo.com	    2022-01-16
-- MRobinson8@yahoo.com	    2022-01-17
-- JWalker3@hotmail.com	    2022-01-21
-- SMcdonald7@yahoo.com	    2022-01-22
-- MRuiz8@hotmail.com	    2022-01-22
-- EKhan2@gmail.com	        2022-01-23