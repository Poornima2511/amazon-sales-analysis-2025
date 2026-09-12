-- =========================================================
-- Amazon Sales Analysis 2025 — SQL
-- Run against the cleaned dataset produced by
-- notebooks/02_data_cleaning.ipynb (loaded into a table
-- named `amazon_products`).
-- =========================================================

-- 1. Quick look at the data
SELECT *
FROM amazon_products
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM amazon_products;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'amazon_products'
ORDER BY ordinal_position;

-- 2. Overall summary statistics
SELECT
    COUNT(*) AS total_products,
    ROUND(AVG(final_price), 2) AS avg_price,
    ROUND(AVG(monthly_purchases), 2) AS avg_monthly_purchases,
    ROUND(AVG(number_of_reviews), 2) AS avg_reviews
FROM amazon_products;

-- 3. Best Seller status vs average monthly purchases
SELECT
    best_seller_status,
    COUNT(*) AS product_count,
    ROUND(AVG(monthly_purchases), 2) AS avg_monthly_purchases
FROM amazon_products
GROUP BY best_seller_status
ORDER BY avg_monthly_purchases DESC;

-- 4. Discount range vs average monthly purchases
SELECT
    CASE
        WHEN discount_percentage < 10 THEN '0–10%'
        WHEN discount_percentage < 20 THEN '10–20%'
        WHEN discount_percentage < 30 THEN '20–30%'
        WHEN discount_percentage < 40 THEN '30–40%'
        ELSE '40%+'
    END AS discount_range,
    COUNT(*) AS product_count,
    ROUND(AVG(monthly_purchases), 2) AS avg_monthly_purchases
FROM amazon_products
WHERE discount_percentage IS NOT NULL
GROUP BY discount_range
ORDER BY avg_monthly_purchases DESC;

-- 5. Sponsored vs organic products
SELECT
    is_sponsored,
    COUNT(*) AS product_count,
    ROUND(AVG(monthly_purchases), 2) AS avg_monthly_purchases
FROM amazon_products
GROUP BY is_sponsored
ORDER BY avg_monthly_purchases DESC;

-- 6. Coupon status vs average monthly purchases
SELECT
    coupon_status,
    COUNT(*) AS product_count,
    ROUND(AVG(monthly_purchases), 2) AS avg_monthly_purchases
FROM amazon_products
GROUP BY coupon_status
ORDER BY avg_monthly_purchases DESC;

-- 7. Delivery speed vs average monthly purchases
SELECT
    delivery_speed,
    COUNT(*) AS product_count,
    ROUND(AVG(monthly_purchases), 2) AS avg_monthly_purchases
FROM amazon_products
GROUP BY delivery_speed
ORDER BY avg_monthly_purchases DESC;

-- 8. Top 10 best-selling products, with the key attributes side by side
SELECT
    final_price,
    monthly_purchases,
    number_of_reviews,
    discount_percentage,
    best_seller_status,
    is_sponsored,
    coupon_status,
    delivery_speed
FROM amazon_products
WHERE monthly_purchases IS NOT NULL
ORDER BY monthly_purchases DESC
LIMIT 10;

-- 9. Best Seller status: mean vs median monthly purchases
-- (checks whether the average is being skewed by a handful of
-- very popular products)
SELECT
    best_seller_status,
    COUNT(*) AS product_count,
    ROUND(AVG(monthly_purchases), 2) AS avg_purchases,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY monthly_purchases) AS median_purchases
FROM amazon_products
WHERE monthly_purchases IS NOT NULL
GROUP BY best_seller_status
ORDER BY avg_purchases DESC;
