-- THE MOST EXPENSIVE PRODUCT PER CATEGORY

-- For each product category, which product is the most expensive? 
-- Output the category, product name and price in the alphabetical order of category. 
-- Only return one product per category.

WITH 
  RANK_TABLE AS (
    SELECT
      category
      ,product_name
      ,price
      ,ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) rank_num
    FROM
      amazon_products
  )
SELECT
  category
  ,product_name
  ,price
FROM RANK_TABLE
WHERE RANK_TABLE.rank_num = 1
ORDER BY RANK_TABLE.category

-- =================
-- Query Output
-- =================

-- category     product_name                        price
-- --------------------------------------------------------
-- book	        Practical Statistics	            16.99
-- clothing	    Pantagonia Insulated Jacket	        109.5
-- electronics	2021 Macbook 15 inch	            1599.95
-- game	        PlayStation 5	                    400
-- jewelry	    14K Gold Ring	                    289.95