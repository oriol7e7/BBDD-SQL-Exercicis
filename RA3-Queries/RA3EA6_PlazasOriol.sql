--ex1
SELECT r.nombre as "Nom venedor", p.clie as "Codi client"
FROM pedidos p
    LEFT JOIN repventas r
    ON p.rep = r.num_empl;