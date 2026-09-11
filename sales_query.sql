WITH offline_sale AS (
    SELECT
        'offline'::text AS Sales_Channel,
        i.store_order_id AS Order_ID,
        i.product_id AS product_id,
        i.quantity AS quantity,
        o.order_date AS order_date,
        o.user_id AS user_id,
        p.payment_method,
        p.payment_status,
        u.user_city,
        u.user_age,
        u.user_gender,
        u.loyalty_status,
        pp.product_name,
        pp.product_price
    FROM project.store_order_items i
    LEFT JOIN project.store_orders o
        ON i.store_order_id = o.store_order_id
    LEFT JOIN project.store_payments p
        ON i.store_order_id = p.store_order_id
    LEFT JOIN project.users_sql_project u
        ON o.user_id = u.user_id
    LEFT JOIN project.products_sql_project pp
        ON i.product_id = pp.product_id
),
online_sale AS (
    SELECT
        'online'::text AS Sales_Channel,
        i.order_id AS Order_ID,
        i.product_id AS product_id,
        i.quantity AS quantity,
        o.order_date AS order_date,
        o.user_id AS user_id,
        p.payment_method,
        p.payment_status,
        u.user_city,
        u.user_age,
        u.user_gender,
        u.loyalty_status,
        pp.product_name,
        pp.product_price
    FROM project.order_items_sql_project i
    LEFT JOIN project.orders_sql_project o
        ON i.order_id = o.order_id
    LEFT JOIN project.payments_sql_project p
        ON i.order_id = p.order_id
    LEFT JOIN project.users_sql_project u
        ON o.user_id = u.user_id
    LEFT JOIN project.products_sql_project pp
        ON i.product_id = pp.product_id
)
SELECT * FROM offline_sale
UNION ALL
SELECT * FROM online_sale;