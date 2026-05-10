SELECT a.nom, a.cognom1
from alumne as a
WHERE LOWER(a.cognom1) LIKE 'l%';

SELECT a.nom, a.cognom1
from alumne as a
where a.codi_postal = 8042;

SELECT a.nom
from alumne as a
where to_char(a.codi_postal, '99999999') LIKE '%4';


SELECT a.nom
from alumne as a
where a.codi_postal::text LIKE '%4';


select a.nom, b.nom, a.codi_postal
from alumne as a, alumne as b
where a.codi_postal = b.codi_postal AND a.nom NOT LIKE b.nom;


select e.grup, sum(e.horessetmana)
from ensenya as e
group by grup;


select d.nom, d.cognom1
from docent d, ensenya e, modul m
where d.codi = e.codi_docent AND m.codi = e.codi_modul AND Lower(m.nom) LIKE '%marques%';


select a.nom, count(r.*) as vegades
from realitza as r join activitat as a
on r.codi_act = a.codi
group by (a.nom)
order by vegades desc
limit 2;