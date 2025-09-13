# sql-library-db
Kutubxona uchun yaratilgan SQL ma’lumotlar bazasi va oddiy analytics loyihasi
About the Project

Ushbu loyiha **Turon Kutubxonasi** uchun boshlang‘ich platforma sifatida ishlab chiqilgan.
Ma’lumotlar bazasi kutubxona a’zolari, kitoblari va ularning ijaralarini boshqarish uchun yaratilgan.

##Loyiha orqali quyidagilar amalda ko‘rsatildi:

**SQL’da CRUD amallari** (Create, Read, Update, Delete)

**Constraints**: PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, DEFAULT

**JOIN query’lari orqali jadvallarni bog‘lash**

-------------------------------------------------------------------


Oddiy analytics savollari (eng ko‘p kitob o‘qigan a’zo, eng mashhur kitob, qarzdorlar ro‘yxati
**Data Model (ER Diagram)**
## ER Diagram

![ER Diagram](turon_library_er.png)


   **Database Schema (DDL)**
  ```sql
  CREATE TABLE members (
  mem_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  phone_num VARCHAR(20),
  email_address VARCHAR(50) UNIQUE,
  join_date DATE DEFAULT (CURRENT_DATE)
);
  ```sql
CREATE TABLE books (
  book_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(150) NOT NULL,
  author VARCHAR(100),
  genre VARCHAR(50),
  published_year INT
);
  ```sql
CREATE TABLE loans (
  loan_id INT PRIMARY KEY AUTO_INCREMENT,
  mem_id INT,
  book_id INT,
  loan_date DATE DEFAULT (CURRENT_DATE),
  return_date DATE,
  FOREIGN KEY (mem_id) REFERENCES members(mem_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);

Example Queries (CRUD + Analytics)
1. CRUD misollari
   -- Yangi a’zo qo‘shish

  ```sql
INSERT INTO members (name, phone_num, email_address) 
VALUES ('Ali Karimov', '+998901234567', 'ali@example.com');

-- A’zo telefon raqamini yangilash
  ```sql
UPDATE members 
SET phone_num = '+998998765432'
WHERE mem_id = 1;

-- Kitobni o‘chirish
  ```sql
DELETE FROM books 
WHERE book_id = 10;

2. Analytics query’lar
  ```sql
-- Eng ko‘p kitob o‘qigan 3 a’zo
SELECT m.name, COUNT(*) AS total_loans
FROM members m
JOIN loans l ON m.mem_id = l.mem_id
GROUP BY m.name
ORDER BY total_loans DESC
LIMIT 3;

-- Eng mashhur 5 ta kitob
  ```sql
SELECT b.title, COUNT(*) AS borrow_count
FROM books b
JOIN loans l ON b.book_id = l.book_id
GROUP BY b.title
ORDER BY borrow_count DESC
LIMIT 5;

-- 10 kundan oshib ketgan qarzdorlar
  ```sql
SELECT m.name, b.title, l.loan_date
FROM loans l
JOIN members m ON l.mem_id = m.mem_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL
  AND l.loan_date < (CURRENT_DATE - INTERVAL 10 DAY);
🔹 Insights

**Top readers**: eng ko‘p kitob olgan a’zolarni aniqlash

**Popular books**: eng ko‘p o‘qilgan kitoblarni ko‘rish

**Overdue members**: muddatidan oshgan qarzdorlarni kuzatish

**Active vs Inactive users**: kim kutubxonadan muntazam foydalanmoqda?
**Future Improvements**

Jarima tizimi qo‘shish

Hodimlar jadvali va ularning faoliyatini kuzatish

Dashboard (Power BI / Tableau) orqali vizual tahlil

Real-time notification (email yoki SMS)
**How to Run**
git clone https://github.com/USERNAME/sql-library-db.git
library.sql faylini MySQL/MariaDB’da import qiling.

SQL query’larni ishlatib natijalarni ko‘ring.

