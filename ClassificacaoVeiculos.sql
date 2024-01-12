-- Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 2 anos e seminovos acima de 2 anos

WITH
	classificacao_veiculos AS (
	
		SELECT
			fun.visit_page_date,
			pro.model_year,
			extract('year' FROM visit_page_date) - pro.model_year::INT AS idade_veiculo,
			CASE
				WHEN (extract('year' FROM visit_page_date) - pro.model_year::INT)<=2 THEN 'novo'
				ELSE 'seminovo'
				END AS "classificação do veículo"
		
		FROM sales.funnel AS fun
		LEFT JOIN sales.products AS pro
			ON fun.product_id = pro.product_id	
	)

SELECT
	"classificação do veículo",
	count(*) AS "veículos visitados (#)"
FROM classificacao_veiculos
GROUP BY "classificação do veículo"