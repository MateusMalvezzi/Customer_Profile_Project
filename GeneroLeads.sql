-- Gênero dos leads
-- Colunas: gênero, leads(#)

SELECT
	CASE
		WHEN ibge.gender = 'male' THEN 'homens'
		WHEN ibge.gender = 'female' THEN 'mulheres'
		END AS "gênero",
	count(*) as "leads (#)"

FROM sales.customers AS cus
LEFT JOIN temp_tables.ibge_genders AS ibge
	ON lower(cus.first_name) = lower(ibge.first_name)
GROUP by ibge.gender