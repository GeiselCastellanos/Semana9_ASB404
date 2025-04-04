Guia 7 ASB 404

EJERCICIO 1. Uso del INNER JOIN:
SELECT f.film_id, f.title, c.category_id, c.name AS category_name
FROM sakila.film f
INNER JOIN sakila.film_category fc ON f.film_id = fc.film_id
INNER JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY f.film_id;

Consulta con ALIAS:
SELECT film.film_id, film.title, cat.category_id, cat.name AS category_name
FROM sakila.film AS film
INNER JOIN sakila.film_category AS fc ON film.film_id = fc.film_id
INNER JOIN sakila.category AS cat ON fc.category_id = cat.category_id
ORDER BY film.film_id;

Ejercicio 2: Uso del RIGHT JOIN:
SELECT f.film_id, f.title, c.category_id, c.name AS category_name
FROM sakila.film f
RIGHT JOIN sakila.film_category fc ON f.film_id = fc.film_id
RIGHT JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY c.category_id;

Consulta con ALIAS:
SELECT film.film_id, film.title, cat.category_id, cat.name AS category_name
FROM sakila.film AS film
RIGHT JOIN sakila.film_category AS fc ON film.film_id = fc.film_id
RIGHT JOIN sakila.category AS cat ON fc.category_id = cat.category_id
ORDER BY cat.category_id;

Ejercicio 4: Uso del LEFT JOIN:
SELECT f.film_id, f.title, c.category_id, c.name AS category_name
FROM sakila.film f
LEFT JOIN sakila.film_category fc ON f.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
ORDER BY f.film_id;

Consulta con ALIAS:
SELECT film.film_id, film.title, cat.category_id, cat.name AS category_name
FROM sakila.film AS film
LEFT JOIN sakila.film_category AS fc ON film.film_id = fc.film_id
LEFT JOIN sakila.category AS cat ON fc.category_id = cat.category_id
ORDER BY film.film_id;

Ejercicio 9: Uso de Subconsultas
SELECT customer_id, first_name, last_name
FROM sakila.customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM sakila.rental
    WHERE rental_date >= '1998-01-01'
);

Subconsultas con WHERE usando NOT IN:
SELECT customer_id, first_name, last_name
FROM sakila.customer
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM sakila.rental
    WHERE rental_date >= '1998-01-01'
);

Subconsultas con EXISTS:
SELECT customer_id, first_name, last_name
FROM sakila.customer
WHERE EXISTS (
    SELECT *
    FROM sakila.rental
    WHERE customer_id = sakila.customer.customer_id
    AND rental_date >= '1998-01-01'
);

Subconsultas con NOT EXISTS:
SELECT customer_id, first_name, last_name
FROM sakila.customer
WHERE NOT EXISTS (
    SELECT *
    FROM sakila.rental
    WHERE customer_id = sakila.customer.customer_id
    AND rental_date >= '1998-01-01'
);

Subconsulta en SELECT:
SELECT o.order_id, o.order_date,
       (SELECT MAX(unit_price)
        FROM order_details
        WHERE order_details.order_id = o.order_id) AS max_unit_price
FROM orders AS o;


Ejercicios Complementarios

Ejercicio Complementario 1:
SELECT c.first_name AS customer_name, f.title AS film_title, r.return_date
FROM sakila.customer AS c
JOIN sakila.rental AS r ON c.customer_id = r.customer_id
JOIN sakila.inventory AS i ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f ON i.film_id = f.film_id;

Ejercicio Complementario 2:
SELECT c.first_name AS customer_name, f.title AS film_title, r.return_date, p.amount
FROM sakila.customer AS c
JOIN sakila.rental AS r ON c.customer_id = r.customer_id
JOIN sakila.inventory AS i ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f ON i.film_id = f.film_id
JOIN sakila.payment AS p ON r.rental_id = p.rental_id
ORDER BY p.amount DESC;

Ejercicio Complementario 3:
SELECT c.first_name AS customer_name, f.title AS film_title, r.return_date, p.amount,
       cat.name AS category_name, lang.name AS original_language
FROM sakila.customer AS c
JOIN sakila.rental AS r ON c.customer_id = r.customer_id
JOIN sakila.inventory AS i ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f ON i.film_id = f.film_id
JOIN sakila.payment AS p ON r.rental_id = p.rental_id
JOIN sakila.film_category AS fc ON f.film_id = fc.film_id
JOIN sakila.category AS cat ON fc.category_id = cat.category_id
JOIN sakila.language AS lang ON f.original_language_id = lang.language_id
ORDER BY p.amount DESC;

