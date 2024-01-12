-- Status profissional dos leads
-- Colunas: status profissional, leads (%)

SELECT
	CASE
		WHEN professional_status = 'freelancer' THEN 'freelancer'
		WHEN professional_status = 'retired' THEN 'aposentado'
		WHEN professional_status = 'clt' THEN 'clt'
		WHEN professional_status = 'self_employed' THEN 'autônomo'		
		WHEN professional_status = 'other' THEN 'outro'
		WHEN professional_status = 'businessman' THEN 'empresário'
		WHEN professional_status = 'civil_servant' THEN 'funcionário público'
		WHEN professional_status = 'student' THEN 'estudante'
		END AS "status profissional",
	(count(*)::FLOAT)/(SELECT count(*) FROM sales.customers) AS "leads (%)"

FROM sales.customers
GROUP BY professional_status
ORDER BY "leads (%)"