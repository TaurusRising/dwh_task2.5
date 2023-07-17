
WITH sales_fact AS
(SELECT SUM
        (CASE WHEN sh.shop_name = 'dns' THEN (SELECT SUM(sales_cnt) FROM shop_dns)
              WHEN sh.shop_name = 'mvideo' THEN (SELECT SUM(sales_cnt) FROM shop_mvideo)
              WHEN sh.shop_name = 'sitilink' THEN (SELECT SUM(sales_cnt) FROM shop_sitilink)
              END) 
        AS sum_fact_shops
FROM shops AS sh INNER JOIN shop_dns ON sh.shop_id = shop_dns.shop_id
                 INNER JOIN shop_mvideo ON sh.shop_id = shop_mvideo.shop_id
                 INNER JOIN shop_sitilink ON sh.shop_id = shop_sitilink_id
)

WITH sales_plan AS 
(SELECT SUM
        (CASE WHEN sh.shop_name = 'dns' THEN (SELECT SUM(plant_cnt) FROM plan AS p WHERE p.shop_name = 'dns')
              WHEN sh.shop_name = 'mvideo' THEN (SELECT SUM(plant_cnt) FROM p WHERE p.shop_name = 'mvideo')
              WHEN sh.shop_name = 'sitilink' THEN (SELECT SUM(plan_cnt) FROM p WHERE p.shop_name = 'sitilink'
              END)
        AS sum_plan_shops
        )
)

SELECT sh.shop_name AS shop, p.product_name AS product, sales_fact, sales_plan, sales_fact/sales_plan, p.price * sales_fact AS income_fact, p.price * sales_plan AS income_plan, income_fact/income_plan
FROM sales AS s  
INNER JOIN shops AS sh ON plan AS pl ON sh.shop_name = pl.shop_name
INNER JOIN products AS pr ON pl.product_id = pr.product_id


