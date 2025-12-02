-- 1. We need a complete list of our suppliers to update our contact records.
--  Can you pull all the information from the suppliers' table?

select * from suppliers;



-- 2. Our London sales team wants to run a local promotion. Could you get a list of all customers based in London?

select * from customers
where city = 'london';



-- 3. For our new 'Luxury Items' marketing campaign, I need to know our top 5 most expensive products.

select * from products;

select productid,productname,price from products 
order by price desc 
limit 5; 



-- 4. HR is planning a professional development program for our younger employees. 
-- Can you provide a list of all employees born after 1965?

SELECT * FROM EMPLOYEES;

select * from employees 
where year(birthdate) > 1965;



-- 5. A customer is asking about our 'Chef' products but can't remember the full name.
--  Can you search for all products that have 'Chef' in their title?

SELECT * FROM PRODUCTS;

select productid,productname from products 
where productname like '%chef%';




-- 6. We need a report that shows every order and which customer placed it. 
-- Can you combine the order information with the customer's name?

select * from customers;
select * from orders;

select o.orderid,o.orderdate,c.customername,c.customerid from orders o
join customers c
on c.customerid = o.customerid;



-- 7. To organize our inventory, 
-- please create a list that shows each product and the name of the category it belongs to.

select * from products;
select * from categories;

select p.productid,p.productname,c.categoryname from products p 
join categories c
on p.categoryid = c.categoryid;



-- 8. We want to promote products sourced from the USA.
--  Can you list all products provided by suppliers located in the USA?

SELECT * FROM SUPPLIERS;
select * from products;

SELECT p.productid,p.productname,s.supplierid,s.suppliername,s.country
FROM products p
JOIN suppliers s 
    ON p.supplierid = s.supplierid
WHERE s.country = 'USA';




-- 9. A customer has a query about their order. We need to know which employee was responsible for it. 
-- Can you create a list of orders with the corresponding employee's first and last name?

SELECT * FROM ORDERS;
SELECT * FROM EMPLOYEES;

SELECT O.ORDERDATE,o.orderid,concat(e.firstname,' ',e.lastname) as full_name_emp from employees e 
join orders o 
on o.EmployeeID = e.employeeid
ORDER BY O.ORDERDATE DESC;



-- 10. To help with our international marketing strategy, 
-- I need a count of how many customers we have in each country, 
-- sorted from most to least.

select * from customers;

select count(customerid) as total_count,country from customers 
group by country 
order by total_count desc ;



-- 11. Let's analyze our pricing. What is the average product price within each product category?

select * from products;

select round(AVG(price),2) as avg_price,categoryid from products 
group by categoryid
ORDER BY avg_price DESC;



-- 12. For our annual performance review, can you show the total number of orders handled by each employee?

select * from employees;
select * from orders;

select e.employeeid,concat(firstname,' ',lastname) as full_name, count(o.orderid) as total_order from employees e 
join orders o 
on o.EmployeeID = e.EmployeeID
group by e.employeeid,full_name
order by count(o.orderid) desc ;



-- 13. We want to identify our key suppliers. 
-- Can you list the suppliers who provide us with more than three products?

select * from suppliers;
select * from products;

select s.supplierid,s.suppliername,count(p.productid) as total_product from products p 
join suppliers  s
on s.supplierid = p.supplierid 
group by s.supplierid,s.suppliername
having count(p.productid) > 3;



-- 14. Finance team needs to know the total revenue for order 10250.

SELECT * FROM orderdetails;
select * from products;

SELECT SUM(Od.QUANTITY*p.price) as total_revenue from products p 
join orderdetails od 
on p.ProductID = od.ProductID
where od.orderid = 10250;



-- 15. What are our most popular products? 
-- I need a list of the top 5 products based on the total quantity sold across all orders.

select * from products;
select * from orderdetails;

select p.productid,p.productname, sum(od.quantity) as total_quantity_sold from products p 
join orderdetails od 
on p.productid = od.productid 
group by p.productid,p.productname
order by sum(od.quantity) desc 
limit 5;




-- 16. To negotiate our shipping contracts, we need to know which shipping company we use the most.
--  Can you count the number of orders handled by each shipper?

select * from shippers;
select * from orders;

select s.shippername,count(o.orderid) as nuber_of_order from orders o 
join shippers s 
on s.shipperid = o.shipperid
group by s.shippername
order by count(o.orderid) desc;




-- 17. Who are our top-performing salespeople in terms of revenue? 
-- Please calculate the total sales amount for each employee.

select * from employees;
select * from orderdetails;
select * from products;

select * from orders;


select concat(e.firstname,' ',e.lastname) as full_emp_name , sum(od.quantity*p.price) as total_revenue from products p 
join orderdetails od 
on p.ProductID = od.ProductID
join orders o 
on o.orderid = od.orderid 
join employees e 
on e.employeeid = o.employeeid
group by full_emp_name 
order by total_revenue desc;





-- 18. We are running a promotion on our 'Chais' tea.
--  I need a list of all customers who have purchased this product before so we can send them a notification.

select * from customers;
select * from products;

select * from orderdetails;
select * from orders;

select distinct c.customerid,c.customername,c.contactname,p.productname from products p 
join orderdetails od 
on p.productid = od.productid 
join orders o 
on o.orderid = od.orderid 
join customers c 
on c.customerid = o.customerid 
where p.productname = 'chais';





-- 19. Which product categories are the most profitable? 
-- I need a report showing the total revenue generated by each category.

select * from categories;
select * from orderdetails;
select * from products;

select c.categoryname,sum(od.quantity*p.price) as total_revenue from products p 
join categories c
on p.CategoryID = c.CategoryID
join orderdetails od
on od.ProductID = p.ProductID
group by  c.categoryname;




-- 20. We want to start a loyalty program for our most frequent customers. 
-- Can you find all customers who have placed more than 5 orders?

select * from customers;
select * from orders;

select c.customerid,c.customername,count(o.orderid) as total_orders  from customers c 
join orders o 
on o.customerid = c.customerid
 group by c.customerid,c.customername
 having count(o.orderid) > 5
 order by count(o.orderid) desc ;
 
 