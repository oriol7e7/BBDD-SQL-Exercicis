--ex1
SELECT r.nombre as "Nom venedor", p.clie as "Codi client"
FROM pedidos p
    INNER JOIN repventas r
        ON p.rep = r.num_empl;


--ex2
SELECT r.nombre, p.clie as "codi client"
FROM pedidos p
    RIGHT JOIN repventas r 
        ON r.num_empl = p.rep; 


--ex3
SELECT r.nombre, c.empresa
FROM repventas r
    LEFT JOIN pedidos p 
        ON r.num_empl = p.rep
    LEFT JOIN clientes c 
        ON c.num_clie = p.clie;


--ex4
SELECT r.nombre, COUNT(p.num_pedido), SUM(p.importe), MIN(p.importe), MAX(p.importe), AVG(p.importe)
FROM repventas r
    LEFT JOIN pedidos p 
        ON r.num_empl = p.rep
GROUP BY r.num_empl;


--ex5
SELECT c.empresa, r.num_empl, r.nombre, o.oficina, o.ciudad
FROM repventas r
    LEFT JOIN clientes c 
        ON c.rep_clie = r.num_empl
    LEFT JOIN oficinas o 
        ON o.oficina = r.oficina_rep;