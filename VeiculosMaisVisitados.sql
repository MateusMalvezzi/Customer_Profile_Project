-- Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)

SELECT
	pro.brand,
	pro.model,
	count(*) AS "visitas (#)"

FROM sales.funnel AS fun
LEFT JOIN sales.products AS pro
	ON fun.product_id = pro.product_id
GROUP BY pro.brand, pro.model
ORDER BY pro.brand, pro.model, "visitas (#)"