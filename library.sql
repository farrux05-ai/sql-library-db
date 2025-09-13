CREATE DATABASE kutubxona;
USE kutubxona;

CREATE TABLE members (
mem_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
phone_num VARCHAR(20),
email_addres VARCHAR(50) UNIQUE,
join_date DATETIME DEFAULT current_timestamp
);

CREATE TABLE books(
book_id INT PRIMARY KEY auto_increment,
title VARCHAR(255) NOT NULL,
author VARCHAR(255),
genre VARCHAR(100),
published_year INT,
copies_available INT default 1
);

create table loans(
load_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT,
mem_id INT,
loan_date datetime default current_timestamp,
return_date date,
foreign key(book_id) references books(book_id),
foreign key(mem_id) references members(mem_id)
);
INSERT INTO books (title, author, genre, published_year, copies_available)
VALUES ('1984', 'George Orwell', 'Dystopia', 1949, 3),
       ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, 2);

INSERT INTO members (name, email_addres, phone_num)
VALUES ('Ali Karimov', 'ali@mail.com', '998901112233'),
       ('Dilnoza Azizova', 'dilnoza@mail.com', '998909887766');

INSERT INTO loans (book_id, mem_id, loan_date)
VALUES (1, 1, '2025-09-10'),
       (2, 2, '2025-09-12');
	
    
    select * from books;
        select * from members;
        select * from loans;
insert into members(name, phone_num, email_addres, join_date)
values ('Akrom', '99894785623', 'akrom@gamil.com', current_date()),
('Ikrom', '9985642314', 'ikrom@gmail.com',curdate());

insert into members(name, phone_num, email_addres, join_date)
values ('Halim', '99894785623', 'halim@gamil.com', '2025-06-14');

insert into books (title, author, genre, published_year, copies_available)
values('Abadiyat qonuni', 'Nodar Dumbadze', 'Philosofy', '20', '3');

insert into loans(book_id, mem_id, loan_date)
values(5,4, '2025-02-06' );

-- Members jadvali
INSERT INTO members (name, phone_num, email_addres, join_date)
VALUES 
('Abdulla', '998901111111', 'abdu1@gmail.com', CURDATE()),
('Vohid Karimov', '998902222222', 'vali2@gmail.com', CURDATE()),
('Gulnoza Abdullayeva', '998903333333', 'gulnoza3@gmail.com', CURDATE());

-- Books jadvali
INSERT INTO books (title, author, published_year)
VALUES
('O‘tkan Kunlar', 'Abdulla Qodiriy', 1926),
('Harry Potter va Sehrgarlar Tosh', 'J.K. Rowling', 1997),
('Jasur Yangi dunyo', 'Oldost Haksli', 1642);

-- Borrowed_books jadvali
INSERT INTO loans (book_id, mem_id, loan_date)
VALUES
(1, 2, CURDATE()),   -- Vali Karimov 1-kitobni oldi
(2, 1, CURDATE()),   -- Ali Valiyev 2-kitobni oldi
(3, 3, CURDATE());   -- Gulnoza 3-kitobni oldi

select * from books;
        select * from members;
        select * from loans;
        
# Read
#only uselful columns
select name, email_addres from members;

 -- where
select name, phone_num 
from members
where name = 'Ikrom';

-- imagine Ikrom take new number, we should change with oldest
UPDATE members
set phone_num = '+998974561235'
where mem_id = 4;
 -- update
select name, phone_num 
from members
where name = 'Ikrom';

-- if we have only 1 copy of book hw can we change?
UPDATE books
set copies_available = 1
where book_id = 3;

select * from books;

-- we had the duplicate on our book table, George Oruel 2 times copy. HOw we delete from our table?
delete from books
where book_id = 2;
select * from books;
delete from books
where book_id = 4;
 # How can we see new people in our table/
 select name 
 from members
 order by join_date desc
 limit 1;
-- DISTINC FUNCTION
use kutubxona;
select distinct name 
from members;
select distinct title
from books;

select title, count(copies_available) 
from books
where copies_available = 1
group by title;
-- count users
select count(mem_id) as foydalanuvchilar
from members;
select count(load_id) as ijara_kitoblar
from loans;

-- joins 
-- how can we see all of users who loan the book with books name
-- Barcha a’zolarni va ularning kitoblarini ko‘rsat
SELECT m.name, b.title
FROM members m
inner JOIN loans l ON m.mem_id = l.mem_id
inner JOIN books b ON l.book_id = b.book_id;

-- who take which book/
select m.name, b.title, l.loan_date
from loans l
inner join members m on m.mem_id=l.mem_id
inner join books b on l.book_id = b.book_id
order by l.loan_date desc;

-- which users read much top 5
select m.name, count(l.load_id) as top5
from members m
inner join loans l on m.mem_id = l.mem_id
group by m.name
order by top5 desc
limit 5;
-- eng ko'p o'qilgan kitoblar 
select b.title, count(l.mem_id) as times_borrowed
from books b
inner join loans l on b.book_id  = l.book_id
group by b.title
order by times_borrowed desc
limit 5;

--  who is the best writer among users/
select b.author, count(l.book_id) as top_writer
from books b
inner join loans l on b.book_id  = l.book_id
group by b.author
order by top_writer desc
limit 3;