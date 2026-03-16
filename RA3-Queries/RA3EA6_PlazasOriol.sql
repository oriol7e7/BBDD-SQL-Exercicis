--ex1
SELECT r.nombre as "Nom venedor", p.clie as "Codi client"
FROM pedidos p
    INNER JOIN repventas r
    ON p.rep = r.num_empl;