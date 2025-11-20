--bài 1--
create database ss8;
use ss8;
create table products(
products_id int primary key,
products_name varchar(200),
price decimal,
stock_quantity int
); 
create table customers(
customer_id int primary key,
customer_name varchar(200),
city varchar(150)
);
create table orders( 
orders_id int primary key,
customer_id int,
foreign key(orders_id) references products(products_id),
orders_date date,
total_amount decimal
);
select count(*) as total_products
from Products;
select sum(total_amount) as total_revenue
from orders;
select avg(price) as average_price
from products;
select max(total_amount) as max_order_amount
from orders;
select min(total_amount) as min_order_amount
from orders;
select count(*) as hanoi_customers_count
from customers
where city = 'Hanoi';

--bài 2--
create database nhansu;
use nhansu;
create table employees( 
employee_id int primary key,
full_name varchar(200),
department varchar(150),
salary decimal,
hire_date date
);
select count(*) as number_of_employees
from employees;
select sum(salary) as total_monthly_salary
from employees;
select avg(salary) as average_salary
from employees;
select max(salary) as highest_salary
from employees;
select min(salary) as lowest_salary
from employees;
select min(hire_date) as earliest_hire_date
from employees;
select sum(salary) as it_department_salary
from employees
where department = 'IT';

--bài 3--
create database thuvien;
use thuvien;
create table books(
book_id int primary key,
title varchar(200),
author varchar(200),
publication_year int,
pages int
);
create table BorrowingRecords(
record_id int primary key,
book_id int,
foreign key(record_id) references books(book_id),
brrow_date date
);
select count(*) as total_books
from books;
select sum(pages) as total_pages_in_library
from books;
select avg(pages) as average_pages_per_book
from books;
select min(publication_year) as oldest_book_year
from books;
select max(publication_year) as newest_book_year
from books;
select min(borrow_date) as first_borrow_date
from borrowingrecords;
select count(*) as books_after_2000
from books
where publication_year > 2000;