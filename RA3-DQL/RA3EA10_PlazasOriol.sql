--ex1
SELECT r.nombre, r.cuota
FROM repventas r
WHERE r.cuota >= (
        SELECT o.objetivo
        FROM oficinas o
        WHERE r.oficina_rep = o.oficina
    );


--ex2
SELECT o.oficina, o.ciudad
FROM oficinas o
WHERE o.objetivo > (
    SELECT SUM(r.cuota)
    FROM repventas r
    WHERE o.oficina = r.oficina_rep
    );

--ex3
SELECT r.nombre, r.edad
FROM repventas r
WHERE NOT EXISTS (
    SELECT dir
    FROM oficinas o
    WHERE o.dir = r.num_empl
);

--ex4
SELECT p.id_fab as Fabricant, p.id_producto as "codi producte", p.descripcion, p.existencias
FROM productos p
WHERE  p.id_fab LIKE 'aci' AND p.existencias > (
        SELECT p2.existencias
        FROM productos p2
        WHERE p2.id_producto = '41004'
    );

--ex5
SELECT c.num_clie, c.empresa
FROM clientes c
WHERE c.num_clie = ANY (
    SELECT p.clie
    FROM pedidos p
    WHERE p.rep = ANY (
        SELECT r.num_empl
        FROM repventas r
        WHERE r.nombre = 'Bill Adams'
        )
    );

--ex6
SELECT r.num_empl, r.nombre
FROM repventas r
JOIN pedidos p
    ON p.rep = r.num_empl
WHERE p.importe > (r.cuota * 0.10);


