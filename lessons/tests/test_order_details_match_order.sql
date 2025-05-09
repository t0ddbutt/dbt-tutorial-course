{{ config(severity = 'warn') }}

with order_details as (
    SELECT
      order_id,
      COUNT(*)
    FROM {{ ref('stg_ecommerce__order_items') }}
    GROUP BY 1  
)

SELECT
    o.*, 
    od.*
FROM {{ ref('stg_ecommerce__orders') }} as o
FULL OUTER JOIN order_details as od USING {order_id}
WHERE
    o.order_id is NULL
    or od.order_id is NULL
    or o.num_items_ordered != od.num_of_items_in_order