-- 1. List all customers who live in Texas (use JOINs)
select first_name, last_name, district 
from customer
join address 
on customer.address_id = address.address_id 
where address.district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's full name

select * from payment

select first_name, last_name, amount
from payment p 
join customer
on p.customer_id = customer.customer_id
where p.amount > 6.99

-- 3. Show all customer names who have made payments over $175 (use subqueries)

select customer.customer_id, first_name, last_name
from customer
where customer.customer_id in (
select customer_id 
from payment p 
where amount > 175
)

-- 4. List all customers that live in Argentina (use the city table)
select * from customer
select * from address
select * from city 
select country_id from country where country = 'Argentina'

select customer.customer_id, first_name, last_name 
from customer 
where customer.address_id in (
	select address_id 
	from address 
	where city_id in (
		select city_id
		from city 
		where country_id = (
			select country_id 
			from country 
			where country = 'Argentina'
			)
	)
)

-- 5. Which film category has the most movies in it?
-- Sports
select * from film_category
select * from category

select name 
from category 
where category_id = (
	select category_id
	from film_category
	group by category_id
	order by count(film_id) desc
	limit 1
)

-- 6. What film had the most actors in it?
-- Lambs Cincinatti
select * from film
select * from film_actor

select title
from film 
where film_id = (
	select film_id
	from film_actor
	group by film_id
	order by count(actor_id) DESC
	limit 1
	)

-- 7. Which actor has been in the least movies?
select * from actor
select * from film_actor

select first_name, last_name 
from actor
where actor_id = (
	select actor_id
	from film_actor
	group by actor_id 
	order by count(film_id) 
	limit 1
	)

-- 8. Which country has the most cities?
-- India
select * from city
select * from country

select country 
from country
where country_id in (
	select country_id
	from city 
	group by country_id
	order by count(city) desc
	limit 1
	)

-- 9. List the actors who have been in more than 3 films but less than 6.
-- Minimum movies is 14?
select * from film
select * from film_actor
select * from actor


select first_name, last_name 
from actor 
where actor_id in (
	select count(film_id) as total
	from film_actor 
	group by actor_id
--	having count(film_id) between 3 and 6
	having count(film_id) between 14 and 17
	order by count(film_id)
	)