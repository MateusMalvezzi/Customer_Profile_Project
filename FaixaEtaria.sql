-- Faixa etária dos leads
-- Colunas: faixa etária, leads (%)

SELECT
	CASE
		WHEN datediff('years', birth_date, current_date) < 20 THEN '0-20'
		WHEN datediff('years', birth_date, current_date) < 40 then '20-40'
		WHEN datediff('years', birth_date, current_date) < 60 then '40-60'
		WHEN datediff('years', birth_date, current_date) < 80 then '60-80'
		ELSE '80+' END "faixa etária",
		count(*)::FLOAT/(SELECT count(*) FROM sales.customers) AS "leads (%)"

FROM sales.customers
GROUP BY "faixa etária"
ORDER BY "faixa etária" DESC