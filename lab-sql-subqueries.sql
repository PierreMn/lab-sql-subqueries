use sakila;
-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select title, count(*)
from film
left join inventory
using (film_id)
group by title
having title = "Hunchback Impossible";

-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.
Select title , length
from film
where length > (select avg(length) FROM film);


-- 3. set a subquery to display all actors who appear in the film "Alone Trip".
select concat(first_name, " ", last_name) as "Full Name"
from actor
left join film_actor
using (actor_id)
left join film
using (film_id)
where film.title = 'Alone Trip';

-- attempt with subquery: 
"select concat(first_name, " ", last_name) as "Full Name"
from actor
where actor.actor_id = (select film_actor.actor_id from film_actor 
	where  film_actor.film_id = (select film.film_id from film 
		where film.title = 'Alone Trip'));";

-- code sent to chatgpt;

-- code debugged with ChatGPT (non functional)

SELECT CONCAT(first_name, " ", last_name) AS 'Full Name'
FROM actor
WHERE actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id IN (
        SELECT f.film_id
        FROM film f
        WHERE f.title = 'Alone Trip'
    )
);
        