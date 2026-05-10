--ex1
SELECT c.num_clie, c.empresa
FROM clientes c
WHERE c.limite_credito < (
        SELECT SUM(p.importe)
        FROM pedidos p
        WHERE c.num_clie = p.clie
    );

--ex2
SELECT *
FROM oficinas o
WHERE o.oficina NOT IN(
    SELECT r.oficina_rep
    FROM repventas r
    WHERE r.ventas <= (
        SELECT SUM(p.importe)
        FROM pedidos p
        WHERE p.rep = r.num_empl
        )
    );

--ex3
SELECT c.empresa, c.num_clie, c.rep_clie, r.oficina_rep, o.ciudad
FROM clientes c
    JOIN repventas r
    ON r.num_empl = c.rep_clie
    JOIN oficinas o
        ON o.oficina = r.oficina_rep
WHERE c.rep_clie = r.num_empl AND r.oficina_rep IS NOT NULL;

--ex4
SELECT (SELECT COUNT(*) FROM pedidos p WHERE p.clie = c.num_clie),
CASE
WHEN  10 < (SELECT COUNT(*)
                                 FROM pedidos p
                                 WHERE p.clie = c.num_clie
                                 ) THEN 'Gran Client'
WHEN 5 >= (SELECT COUNT(*)
                                 FROM pedidos p
                                 WHERE p.clie = c.num_clie
                                 ) THEN 'Client Petit'
ELSE 'Client mitja'
END as "Tipus client"
FROM clientes c
WHERE c.empresa = 'Zetacorp';