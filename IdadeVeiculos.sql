-- Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem

WITH
	faixa_de_idade_dos_veiculos AS (
	
		SELECT
			fun.visit_page_date,
			pro.model_year,
			extract('year' FROM visit_page_date) - pro.model_year::INT AS idade_veiculo,
			CASE
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=2 THEN 'até 2 anos'
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=4 THEN 'de 2 à 4 anos'
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=6 THEN 'de 4 à 6 anos'
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=8 THEN 'de 6 à 8 anos'
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=10 THEN 'de 8 à 10 anos'
				ELSE 'acima de 10 anos'
				END AS "idade do veículo",
			CASE
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=2 THEN 1
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=4 THEN 2
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=6 THEN 3
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=8 THEN 4
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=10 THEN 5
				ELSE 6
				END AS "ordem"

		FROM sales.funnel AS fun
		LEFT JOIN sales.products AS pro
			ON fun.product_id = pro.product_id	
	)

SELECT
	"idade do veículo",
	count(*)::FLOAT/(SELECT count(*) FROM sales.funnel) AS "veículos visitados (%)",
	ordem
FROM faixa_de_idade_dos_veiculos
GROUP BY "idade do veículo", ordem
ORDER BY ordem