mysql> -- =====================================
mysql> -- E-COMMERCE DATA ANALYSIS PROJECT
mysql> -- =====================================
mysql>
mysql> -- Create Database
mysql> CREATE DATABASE IF NOT EXISTS ecommerce_project;
Query OK, 1 row affected (0.07 sec)

mysql> USE ecommerce_project;
Database changed
mysql>
mysql> -- Drop table if exists
mysql> DROP TABLE IF EXISTS sales;
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql>
mysql> -- Create Table
mysql> CREATE TABLE sales (
    ->     order_id INT,
    ->     customer_id INT,
    ->     product_name VARCHAR(50),
    ->     category VARCHAR(50),
    ->     order_date DATE,
    ->     quantity INT,
    ->     price INT
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql>
mysql> -- =====================================
mysql> -- INSERT DATA
mysql> -- =====================================
mysql>
mysql> INSERT INTO sales VALUES
    -> (1,101,'Mobile','Electronics','2024-01-05',2,15000),
    -> (2,102,'Shoes','Fashion','2024-01-06',1,2000),
    -> (3,101,'Laptop','Electronics','2024-01-07',1,50000),
    -> (4,103,'T-shirt','Fashion','2024-01-07',3,500),
    -> (5,104,'Headphones','Electronics','2024-01-08',2,3000),
    -> (6,105,'Watch','Accessories','2024-02-01',1,2500),
    -> (7,106,'Bag','Accessories','2024-02-03',2,1500),
    -> (8,101,'Tablet','Electronics','2024-02-05',1,20000),
    -> (9,102,'Jeans','Fashion','2024-02-06',2,1800),
    -> (10,103,'Shoes','Fashion','2024-02-08',1,2200);
Query OK, 10 rows affected (0.03 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql>
mysql> -- =====================================
mysql> -- DATA CLEANING
mysql> -- =====================================
mysql>
mysql> -- Check NULL values
mysql> SELECT * FROM sales
    -> WHERE order_id IS NULL OR customer_id IS NULL;
Empty set (0.01 sec)

mysql>
mysql> -- Check duplicates
mysql> SELECT order_id, COUNT(*)
    -> FROM sales
    -> GROUP BY order_id
    -> HAVING COUNT(*) > 1;
Empty set (0.01 sec)

mysql>
mysql> -- =====================================
mysql> -- DATA ANALYSIS
mysql> -- =====================================
mysql>
mysql> -- 1. Total Revenue
mysql> SELECT SUM(quantity * price) AS total_revenue FROM sales;
+---------------+
| total_revenue |
+---------------+
|        120800 |
+---------------+
1 row in set (0.00 sec)

mysql>
mysql> -- 2. Top Selling Products
mysql> SELECT product_name, SUM(quantity) AS total_sold
    -> FROM sales
    -> GROUP BY product_name
    -> ORDER BY total_sold DESC;
+--------------+------------+
| product_name | total_sold |
+--------------+------------+
| T-shirt      |          3 |
| Mobile       |          2 |
| Shoes        |          2 |
| Headphones   |          2 |
| Bag          |          2 |
| Jeans        |          2 |
| Laptop       |          1 |
| Watch        |          1 |
| Tablet       |          1 |
+--------------+------------+
9 rows in set (0.00 sec)

mysql>
mysql> -- 3. Revenue by Category
mysql> SELECT category, SUM(quantity * price) AS revenue
    -> FROM sales
    -> GROUP BY category;
+-------------+---------+
| category    | revenue |
+-------------+---------+
| Electronics |  106000 |
| Fashion     |    9300 |
| Accessories |    5500 |
+-------------+---------+
3 rows in set (0.00 sec)

mysql>
mysql> -- 4. Monthly Sales Trend
mysql> SELECT
    ->     MONTH(order_date) AS month,
    ->     SUM(quantity * price) AS revenue
    -> FROM sales
    -> GROUP BY month
    -> ORDER BY month;
+-------+---------+
| month | revenue |
+-------+---------+
|     1 |   89500 |
|     2 |   31300 |
+-------+---------+
2 rows in set (0.00 sec)

mysql>
mysql> -- 5. Top Customers
mysql> SELECT customer_id, SUM(quantity * price) AS total_spent
    -> FROM sales
    -> GROUP BY customer_id
    -> ORDER BY total_spent DESC;
+-------------+-------------+
| customer_id | total_spent |
+-------------+-------------+
|         101 |      100000 |
|         104 |        6000 |
|         102 |        5600 |
|         103 |        3700 |
|         106 |        3000 |
|         105 |        2500 |
+-------------+-------------+
6 rows in set (0.00 sec)

mysql> --- =============================================================================
    -> --  HEALTHCARE DATA ANALYTICS — END-TO-END MySQL PROJECT
    -> --  Dialect : MySQL 8.0+
    -> --  Author  : Generated Project
    -> -- =============================================================================
    ->
    -> -- =============================================================================
    -> -- SECTION 1: SCHEMA DESIGN & DDL
    -> -- =============================================================================
    ->
    -> DROP DATABASE IF EXISTS healthcare_analytics;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-









DROP DATABASE IF EXISTS healthcare_analytics' at line 1
mysql> CREATE DATABASE healthcare_analytics CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
Query OK, 1 row affected (0.12 sec)

mysql> USE healthcare_analytics;
Database changed
mysql>
mysql> -- ── Departments ──────────────────────────────────────────────────────────────
mysql> CREATE TABLE departments (
    ->     department_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     dept_name       VARCHAR(100) NOT NULL,
    ->     dept_head       VARCHAR(100),
    ->     location        VARCHAR(100),
    ->     created_at      DATETIME DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.13 sec)

mysql>
mysql> -- ── Doctors ───────────────────────────────────────────────────────────────────
mysql> CREATE TABLE doctors (
    ->     doctor_id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     first_name      VARCHAR(60)  NOT NULL,
    ->     last_name       VARCHAR(60)  NOT NULL,
    ->     specialization  VARCHAR(100) NOT NULL,
    ->     department_id   INT UNSIGNED NOT NULL,
    ->     experience_yrs  TINYINT UNSIGNED DEFAULT 0,
    ->     email           VARCHAR(150) UNIQUE,
    ->     phone           VARCHAR(20),
    ->     joining_date    DATE,
    ->     CONSTRAINT fk_doctor_dept FOREIGN KEY (department_id) REFERENCES departments(department_id)
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql>
mysql> -- ── Patients ──────────────────────────────────────────────────────────────────
mysql> CREATE TABLE patients (
    ->     patient_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     first_name      VARCHAR(60)  NOT NULL,
    ->     last_name       VARCHAR(60)  NOT NULL,
    ->     dob             DATE         NOT NULL,
    ->     gender          ENUM('Male','Female','Other') NOT NULL,
    ->     blood_group     ENUM('A+','A-','B+','B-','O+','O-','AB+','AB-'),
    ->     phone           VARCHAR(20),
    ->     email           VARCHAR(150),
    ->     city            VARCHAR(80),
    ->     state           VARCHAR(80),
    ->     registered_on   DATE DEFAULT (CURRENT_DATE)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql>
mysql> -- ── Appointments ──────────────────────────────────────────────────────────────
mysql> CREATE TABLE appointments (
    ->     appointment_id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     patient_id      INT UNSIGNED NOT NULL,
    ->     doctor_id       INT UNSIGNED NOT NULL,
    ->     appointment_dt  DATETIME     NOT NULL,
    ->     status          ENUM('Scheduled','Completed','Cancelled','No-Show') DEFAULT 'Scheduled',
    ->     reason          VARCHAR(255),
    ->     notes           TEXT,
    ->     created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    ->     CONSTRAINT fk_appt_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    ->     CONSTRAINT fk_appt_doctor  FOREIGN KEY (doctor_id)  REFERENCES doctors(doctor_id)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql>
mysql> -- ── Diagnoses ─────────────────────────────────────────────────────────────────
mysql> CREATE TABLE diagnoses (
    ->     diagnosis_id    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     appointment_id  INT UNSIGNED NOT NULL,
    ->     icd10_code      VARCHAR(10)  NOT NULL,
    ->     description     VARCHAR(255) NOT NULL,
    ->     severity        ENUM('Mild','Moderate','Severe') DEFAULT 'Mild',
    ->     CONSTRAINT fk_diag_appt FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql>
mysql> -- ── Medications ───────────────────────────────────────────────────────────────
mysql> CREATE TABLE medications (
    ->     medication_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     med_name        VARCHAR(150) NOT NULL,
    ->     category        VARCHAR(100),
    ->     unit_cost       DECIMAL(8,2) NOT NULL DEFAULT 0.00
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql>
mysql> -- ── Prescriptions ─────────────────────────────────────────────────────────────
mysql> CREATE TABLE prescriptions (
    ->     prescription_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     appointment_id  INT UNSIGNED NOT NULL,
    ->     medication_id   INT UNSIGNED NOT NULL,
    ->     dosage          VARCHAR(80),
    ->     duration_days   TINYINT UNSIGNED,
    ->     qty             SMALLINT UNSIGNED DEFAULT 1,
    ->     CONSTRAINT fk_rx_appt FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    ->     CONSTRAINT fk_rx_med  FOREIGN KEY (medication_id)  REFERENCES medications(medication_id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql>
mysql> -- ── Billing ───────────────────────────────────────────────────────────────────
mysql> CREATE TABLE billing (
    ->     bill_id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     patient_id      INT UNSIGNED NOT NULL,
    ->     appointment_id  INT UNSIGNED NOT NULL,
    ->     consultation_fee DECIMAL(10,2) DEFAULT 0.00,
    ->     medication_cost  DECIMAL(10,2) DEFAULT 0.00,
    ->     lab_charges      DECIMAL(10,2) DEFAULT 0.00,
    ->     total_amount     DECIMAL(10,2) GENERATED ALWAYS AS
    ->                        (consultation_fee + medication_cost + lab_charges) STORED,
    ->     payment_status  ENUM('Pending','Paid','Partial','Waived') DEFAULT 'Pending',
    ->     payment_date    DATE,
    ->     CONSTRAINT fk_bill_patient FOREIGN KEY (patient_id)     REFERENCES patients(patient_id),
    ->     CONSTRAINT fk_bill_appt   FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql>
mysql> -- ── Lab Tests ─────────────────────────────────────────────────────────────────
mysql> CREATE TABLE lab_tests (
    ->     lab_id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ->     appointment_id  INT UNSIGNED NOT NULL,
    ->     test_name       VARCHAR(150) NOT NULL,
    ->     result          VARCHAR(255),
    ->     is_abnormal     TINYINT(1) DEFAULT 0,
    ->     tested_on       DATE,
    ->     CONSTRAINT fk_lab_appt FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
    -> );
Query OK, 0 rows affected, 1 warning (0.09 sec)

mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 2: INDEXES
mysql> -- =============================================================================
mysql>
mysql> -- Covering index for appointment lookups by doctor + date
mysql> CREATE INDEX idx_appt_doctor_date   ON appointments(doctor_id, appointment_dt);
Query OK, 0 rows affected (0.24 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> -- Covering index for appointment lookups by patient
mysql> CREATE INDEX idx_appt_patient       ON appointments(patient_id, status);
Query OK, 0 rows affected (0.17 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> -- Billing lookup by status & patient
mysql> CREATE INDEX idx_billing_status     ON billing(payment_status, patient_id);
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> -- Diagnosis ICD code search
mysql> CREATE INDEX idx_diag_icd           ON diagnoses(icd10_code);
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> -- Lab abnormal flag
mysql> CREATE INDEX idx_lab_abnormal       ON lab_tests(is_abnormal, appointment_id);
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 3: SAMPLE DATA INSERTION
mysql> -- =============================================================================
mysql>
mysql> -- Departments
mysql> INSERT INTO departments (dept_name, dept_head, location) VALUES
    -> ('Cardiology',      'Dr. R. Sharma',   'Block A – Floor 2'),
    -> ('Neurology',       'Dr. P. Mehta',    'Block B – Floor 1'),
    -> ('Orthopedics',     'Dr. S. Iyer',     'Block A – Floor 3'),
    -> ('Pediatrics',      'Dr. A. Khan',     'Block C – Floor 1'),
    -> ('General Medicine','Dr. N. Verma',    'Block C – Floor 2'),
    -> ('Oncology',        'Dr. V. Reddy',    'Block D – Floor 1'),
    -> ('Dermatology',     'Dr. M. Patel',    'Block B – Floor 2');
Query OK, 7 rows affected (0.02 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Doctors
mysql> INSERT INTO doctors (first_name, last_name, specialization, department_id, experience_yrs, email, joining_date) VALUES
    -> ('Rajesh',   'Sharma',  'Interventional Cardiologist', 1, 18, 'r.sharma@hospital.in',  '2006-03-15'),
    -> ('Priya',    'Mehta',   'Neurologist',                 2, 12, 'p.mehta@hospital.in',   '2012-07-01'),
    -> ('Suresh',   'Iyer',    'Orthopedic Surgeon',          3, 20, 's.iyer@hospital.in',    '2004-01-10'),
    -> ('Ayesha',   'Khan',    'Pediatrician',                4,  8, 'a.khan@hospital.in',    '2016-09-20'),
    -> ('Neeraj',   'Verma',   'General Physician',           5, 15, 'n.verma@hospital.in',   '2009-05-05'),
    -> ('Vikram',   'Reddy',   'Oncologist',                  6, 22, 'v.reddy@hospital.in',   '2002-11-22'),
    -> ('Meera',    'Patel',   'Dermatologist',               7,  6, 'm.patel@hospital.in',   '2018-03-14'),
    -> ('Arjun',    'Singh',   'Cardiologist',                1, 10, 'a.singh@hospital.in',   '2014-06-30'),
    -> ('Sunita',   'Desai',   'Neurologist',                 2,  9, 's.desai@hospital.in',   '2015-02-18'),
    -> ('Karthik',  'Nair',    'General Physician',           5, 11, 'k.nair@hospital.in',    '2013-08-25');
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Patients (30 sample patients)
mysql> INSERT INTO patients (first_name, last_name, dob, gender, blood_group, phone, email, city, state) VALUES
    -> ('Amit',      'Joshi',      '1980-04-12', 'Male',   'B+',  '9876543210', 'amit.j@mail.com',    'Udaipur',   'Rajasthan'),
    -> ('Sunita',    'Kapoor',     '1975-08-22', 'Female', 'O+',  '9865432109', 'sunita.k@mail.com',  'Jaipur',    'Rajasthan'),
    -> ('Ravi',      'Gupta',      '1990-01-05', 'Male',   'A-',  '9854321098', 'ravi.g@mail.com',    'Udaipur',   'Rajasthan'),
    -> ('Pooja',     'Sharma',     '1985-11-30', 'Female', 'AB+', '9843210987', 'pooja.s@mail.com',   'Kota',      'Rajasthan'),
    -> ('Deepak',    'Malhotra',   '1970-06-15', 'Male',   'O-',  '9832109876', 'deepak.m@mail.com',  'Mumbai',    'Maharashtra'),
    -> ('Kavita',    'Singh',      '1993-03-28', 'Female', 'B-',  '9821098765', 'kavita.si@mail.com', 'Delhi',     'Delhi'),
    -> ('Manish',    'Tiwari',     '1965-09-09', 'Male',   'A+',  '9810987654', 'manish.t@mail.com',  'Varanasi',  'UP'),
    -> ('Ananya',    'Roy',        '2000-12-01', 'Female', 'O+',  '9809876543', 'ananya.r@mail.com',  'Kolkata',   'West Bengal'),
    -> ('Sanjay',    'Mehta',      '1958-07-14', 'Male',   'B+',  '9898765432', 'sanjay.m@mail.com',  'Ahmedabad', 'Gujarat'),
    -> ('Nisha',     'Pillai',     '1988-02-19', 'Female', 'AB-', '9887654321', 'nisha.p@mail.com',   'Kochi',     'Kerala'),
    -> ('Rahul',     'Bajaj',      '1995-05-23', 'Male',   'A+',  '9876543211', 'rahul.b@mail.com',   'Pune',      'Maharashtra'),
    -> ('Sneha',     'Bose',       '1982-10-10', 'Female', 'O+',  '9865432110', 'sneha.b@mail.com',   'Chennai',   'Tamil Nadu'),
    -> ('Vijay',     'Nair',       '1978-08-08', 'Male',   'B+',  '9854321109', 'vijay.n@mail.com',   'Bengaluru', 'Karnataka'),
    -> ('Rekha',     'Iyer',       '1969-04-25', 'Female', 'A-',  '9843210988', 'rekha.i@mail.com',   'Mysuru',    'Karnataka'),
    -> ('Arun',      'Pandey',     '1991-07-17', 'Male',   'O+',  '9832109877', 'arun.p@mail.com',    'Lucknow',   'UP'),
    -> ('Geeta',     'Jain',       '1976-01-29', 'Female', 'AB+', '9821098766', 'geeta.j@mail.com',   'Indore',    'MP'),
    -> ('Pradeep',   'Rao',        '1963-11-11', 'Male',   'B-',  '9810987655', 'pradeep.r@mail.com', 'Hyderabad', 'Telangana'),
    -> ('Meena',     'Tripathi',   '1999-03-05', 'Female', 'O-',  '9809876544', 'meena.t@mail.com',   'Agra',      'UP'),
    -> ('Suresh',    'Kumar',      '1987-06-20', 'Male',   'A+',  '9898765433', 'suresh.ku@mail.com', 'Patna',     'Bihar'),
    -> ('Lata',      'Mishra',     '1972-09-03', 'Female', 'B+',  '9887654322', 'lata.m@mail.com',    'Bhopal',    'MP'),
    -> ('Harish',    'Choudhary',  '1984-12-15', 'Male',   'O+',  '9876543212', 'harish.c@mail.com',  'Jodhpur',   'Rajasthan'),
    -> ('Poonam',    'Dixit',      '1994-08-08', 'Female', 'A-',  '9865432111', 'poonam.d@mail.com',  'Ajmer',     'Rajasthan'),
    -> ('Ramesh',    'Yadav',      '1955-05-01', 'Male',   'AB+', '9854321110', 'ramesh.y@mail.com',  'Bikaner',   'Rajasthan'),
    -> ('Sunanda',   'Ghosh',      '1989-02-14', 'Female', 'O+',  '9843210989', 'sunanda.g@mail.com', 'Kolkata',   'West Bengal'),
    -> ('Tarun',     'Saxena',     '1997-10-30', 'Male',   'B+',  '9832109878', 'tarun.s@mail.com',   'Gwalior',   'MP'),
    -> ('Ritu',      'Agarwal',    '1981-04-18', 'Female', 'O-',  '9821098767', 'ritu.a@mail.com',    'Jaipur',    'Rajasthan'),
    -> ('Naresh',    'Bhatt',      '1973-07-22', 'Male',   'A+',  '9810987656', 'naresh.bh@mail.com', 'Surat',     'Gujarat'),
    -> ('Divya',     'Kulkarni',   '2002-01-10', 'Female', 'B-',  '9809876545', 'divya.k@mail.com',   'Nagpur',    'Maharashtra'),
    -> ('Mukesh',    'Verma',      '1960-03-27', 'Male',   'AB-', '9898765434', 'mukesh.v@mail.com',  'Vadodara',  'Gujarat'),
    -> ('Anita',     'Pandya',     '1986-06-06', 'Female', 'O+',  '9887654323', 'anita.py@mail.com',  'Udaipur',   'Rajasthan');
Query OK, 30 rows affected (0.02 sec)
Records: 30  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Medications
mysql> INSERT INTO medications (med_name, category, unit_cost) VALUES
    -> ('Metformin 500mg',      'Antidiabetic',      4.50),
    -> ('Atorvastatin 10mg',    'Statin',           12.00),
    -> ('Amlodipine 5mg',       'Antihypertensive',  8.75),
    -> ('Aspirin 75mg',         'Antiplatelet',      2.50),
    -> ('Paracetamol 500mg',    'Analgesic',         1.80),
    -> ('Amoxicillin 500mg',    'Antibiotic',       15.00),
    -> ('Omeprazole 20mg',      'PPI',               6.50),
    -> ('Cetirizine 10mg',      'Antihistamine',     5.00),
    -> ('Ibuprofen 400mg',      'NSAID',             4.25),
    -> ('Levothyroxine 50mcg',  'Thyroid Hormone',  22.00),
    -> ('Diclofenac 50mg',      'NSAID',             6.00),
    -> ('Lisinopril 5mg',       'ACE Inhibitor',    10.50),
    -> ('Insulin Glargine',     'Antidiabetic',      85.00),
    -> ('Clopidogrel 75mg',     'Antiplatelet',      18.00),
    -> ('Ondansetron 4mg',      'Antiemetic',        9.00);
Query OK, 15 rows affected (0.01 sec)
Records: 15  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Appointments (40 records spanning ~18 months)
mysql> INSERT INTO appointments (patient_id, doctor_id, appointment_dt, status, reason) VALUES
    -> (1,  1, '2024-01-10 09:00:00', 'Completed',  'Chest pain evaluation'),
    -> (2,  5, '2024-01-12 10:30:00', 'Completed',  'Routine check-up'),
    -> (3,  2, '2024-01-15 11:00:00', 'Completed',  'Persistent headache'),
    -> (4,  7, '2024-01-18 14:00:00', 'Completed',  'Skin rash'),
    -> (5,  1, '2024-02-02 09:30:00', 'Completed',  'Hypertension follow-up'),
    -> (6,  4, '2024-02-05 10:00:00', 'Completed',  'Child fever'),
    -> (7,  3, '2024-02-10 11:30:00', 'Completed',  'Knee pain'),
    -> (8,  5, '2024-02-14 09:00:00', 'Completed',  'Fatigue and weakness'),
    -> (9,  6, '2024-02-20 14:30:00', 'Completed',  'Cancer screening'),
    -> (10, 2, '2024-03-01 10:00:00', 'Completed',  'Migraine'),
    -> (11, 1, '2024-03-05 09:00:00', 'Completed',  'Palpitations'),
    -> (12, 7, '2024-03-08 11:00:00', 'Completed',  'Acne treatment'),
    -> (13, 5, '2024-03-12 10:30:00', 'Completed',  'Diabetes management'),
    -> (14, 3, '2024-03-18 14:00:00', 'Completed',  'Back pain'),
    -> (15, 9, '2024-03-22 09:30:00', 'Completed',  'Seizure history'),
    -> (16, 4, '2024-04-02 10:00:00', 'Completed',  'Vaccination'),
    -> (17, 6, '2024-04-07 14:30:00', 'Completed',  'Oncology follow-up'),
    -> (18, 5, '2024-04-10 09:00:00', 'Completed',  'Thyroid check'),
    -> (19, 1, '2024-04-15 11:00:00', 'Completed',  'ECG review'),
    -> (20, 2, '2024-04-20 10:30:00', 'Completed',  'Stroke prevention'),
    -> (21, 8, '2024-05-03 09:00:00', 'Completed',  'Arrhythmia'),
    -> (22, 7, '2024-05-07 11:30:00', 'Completed',  'Eczema'),
    -> (23, 5, '2024-05-10 10:00:00', 'Completed',  'Diabetes annual review'),
    -> (24, 9, '2024-05-15 14:00:00', 'Completed',  'Neuropathy'),
    -> (25, 4, '2024-05-20 09:30:00', 'Completed',  'Growth assessment'),
    -> (26, 3, '2024-06-01 10:00:00', 'Completed',  'Shoulder injury'),
    -> (27, 6, '2024-06-05 11:00:00', 'Completed',  'Chemo follow-up'),
    -> (28, 10,'2024-06-10 09:00:00', 'Completed',  'Cough and cold'),
    -> (29, 1, '2024-06-15 14:30:00', 'Cancelled',  'Chest tightness'),
    -> (30, 5, '2024-06-20 10:00:00', 'No-Show',    'Routine check-up'),
    -> (1,  8, '2024-07-05 09:00:00', 'Completed',  'Cardiac follow-up'),
    -> (3,  9, '2024-07-10 10:30:00', 'Completed',  'Headache follow-up'),
    -> (5,  1, '2024-07-15 11:00:00', 'Completed',  'Blood pressure review'),
    -> (13, 10,'2024-07-20 09:30:00', 'Completed',  'Sugar level check'),
    -> (7,  3, '2024-08-01 10:00:00', 'Completed',  'Post-surgery review'),
    -> (9,  6, '2024-08-05 14:00:00', 'Completed',  'Oncology review'),
    -> (11, 8, '2024-08-10 09:00:00', 'Scheduled',  'Heart check'),
    -> (2,  5, '2024-08-15 10:30:00', 'Scheduled',  'Annual physical'),
    -> (15, 2, '2024-08-20 11:00:00', 'Scheduled',  'EEG results'),
    -> (20, 9, '2024-08-25 14:30:00', 'Scheduled',  'Neurology review');
Query OK, 40 rows affected (0.01 sec)
Records: 40  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Diagnoses
mysql> INSERT INTO diagnoses (appointment_id, icd10_code, description, severity) VALUES
    -> (1,  'I20.9',  'Unstable Angina',            'Severe'),
    -> (2,  'Z00.0',  'General Medical Examination', 'Mild'),
    -> (3,  'G43.9',  'Migraine, Unspecified',       'Moderate'),
    -> (4,  'L30.9',  'Dermatitis, Unspecified',     'Mild'),
    -> (5,  'I10',    'Essential Hypertension',      'Moderate'),
    -> (6,  'R50.9',  'Fever, Unspecified',          'Mild'),
    -> (7,  'M17.9',  'Osteoarthritis of Knee',      'Moderate'),
    -> (8,  'R53.83', 'Fatigue',                     'Mild'),
    -> (9,  'Z12.11', 'Cancer Screening',            'Mild'),
    -> (10, 'G43.1',  'Migraine with Aura',          'Moderate'),
    -> (11, 'I47.9',  'Paroxysmal Tachycardia',      'Moderate'),
    -> (12, 'L70.0',  'Acne Vulgaris',               'Mild'),
    -> (13, 'E11.9',  'Type 2 Diabetes Mellitus',    'Moderate'),
    -> (14, 'M54.5',  'Low Back Pain',               'Moderate'),
    -> (15, 'G40.9',  'Epilepsy, Unspecified',       'Severe'),
    -> (16, 'Z23',    'Immunisation',                'Mild'),
    -> (17, 'C80.1',  'Malignant Neoplasm',          'Severe'),
    -> (18, 'E03.9',  'Hypothyroidism',              'Mild'),
    -> (19, 'I25.1',  'Coronary Artery Disease',     'Severe'),
    -> (20, 'I63.9',  'Cerebral Infarction',         'Severe'),
    -> (21, 'I48.91', 'Atrial Fibrillation',         'Moderate'),
    -> (22, 'L20.9',  'Atopic Dermatitis',           'Mild'),
    -> (23, 'E11.9',  'Type 2 Diabetes Mellitus',    'Moderate'),
    -> (24, 'G60.9',  'Peripheral Neuropathy',       'Moderate'),
    -> (25, 'Z00.129','Routine Child Health Exam',   'Mild'),
    -> (26, 'M75.1',  'Rotator Cuff Syndrome',       'Moderate'),
    -> (27, 'Z51.11', 'Chemotherapy Session',        'Severe'),
    -> (28, 'J06.9',  'Acute Upper Respiratory Infection','Mild'),
    -> (31, 'I25.1',  'Coronary Artery Disease',     'Severe'),
    -> (32, 'G43.9',  'Migraine, Unspecified',       'Mild'),
    -> (33, 'I10',    'Essential Hypertension',      'Moderate'),
    -> (34, 'E11.9',  'Type 2 Diabetes Mellitus',    'Moderate'),
    -> (35, 'M17.9',  'Osteoarthritis of Knee',      'Moderate'),
    -> (36, 'C80.1',  'Malignant Neoplasm',          'Severe');
Query OK, 34 rows affected (0.02 sec)
Records: 34  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Prescriptions
mysql> INSERT INTO prescriptions (appointment_id, medication_id, dosage, duration_days, qty) VALUES
    -> (1,  3,  '5mg once daily',    30, 30),
    -> (1,  4,  '75mg once daily',   30, 30),
    -> (2,  5,  '500mg as needed',    7, 10),
    -> (3,  5,  '500mg twice daily', 10, 20),
    -> (4,  8,  '10mg once daily',   14, 14),
    -> (5,  3,  '10mg once daily',   60, 60),
    -> (5,  2,  '10mg once daily',   60, 60),
    -> (6,  5,  '250mg thrice daily', 5, 15),
    -> (6,  6,  '125mg thrice daily', 5, 15),
    -> (7,  11, '50mg twice daily',  10, 20),
    -> (8,  5,  '500mg as needed',    7,  7),
    -> (10, 5,  '500mg twice daily',  5, 10),
    -> (11, 3,  '5mg once daily',    30, 30),
    -> (12, 8,  '10mg once daily',   30, 30),
    -> (13, 1,  '500mg twice daily', 90, 180),
    -> (14, 11, '50mg twice daily',  14, 28),
    -> (15, 9,  '400mg thrice daily', 5, 15),
    -> (18, 10, '50mcg once daily',  90, 90),
    -> (19, 4,  '75mg once daily',   90, 90),
    -> (19, 2,  '10mg once daily',   90, 90),
    -> (21, 14, '75mg once daily',   90, 90),
    -> (23, 13, '10 units at bedtime',90, 3),
    -> (24, 5,  '500mg as needed',   14, 10),
    -> (26, 11, '50mg twice daily',  10, 20),
    -> (27, 5,  '500mg as needed',   30, 30),
    -> (28, 6,  '500mg thrice daily', 7, 21),
    -> (28, 7,  '20mg once daily',    7,  7),
    -> (31, 4,  '75mg once daily',   90, 90),
    -> (33, 3,  '10mg once daily',   60, 60),
    -> (34, 1,  '500mg twice daily', 90, 180);
Query OK, 30 rows affected (0.01 sec)
Records: 30  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Billing
mysql> INSERT INTO billing (patient_id, appointment_id, consultation_fee, medication_cost, lab_charges, payment_status, payment_date) VALUES
    -> (1,  1,  800, 680,  1200, 'Paid',    '2024-01-10'),
    -> (2,  2,  500,  50,     0, 'Paid',    '2024-01-12'),
    -> (3,  3,  700, 200,   600, 'Paid',    '2024-01-15'),
    -> (4,  4,  600, 150,     0, 'Paid',    '2024-01-18'),
    -> (5,  5,  800, 450,   800, 'Paid',    '2024-02-02'),
    -> (6,  6,  500, 300,   400, 'Paid',    '2024-02-05'),
    -> (7,  7,  900, 240,   700, 'Paid',    '2024-02-10'),
    -> (8,  8,  500,  50,   500, 'Pending', NULL),
    -> (9,  9, 1200,   0,  2500, 'Paid',    '2024-02-20'),
    -> (10, 10, 700, 100,   600, 'Paid',    '2024-03-01'),
    -> (11, 11, 800, 360,   900, 'Partial', '2024-03-05'),
    -> (12, 12, 600, 150,     0, 'Paid',    '2024-03-08'),
    -> (13, 13, 700, 810,   800, 'Paid',    '2024-03-12'),
    -> (14, 14, 900, 168,   600, 'Paid',    '2024-03-18'),
    -> (15, 15, 700, 127,  1200, 'Paid',    '2024-03-22'),
    -> (16, 16, 400,   0,   300, 'Paid',    '2024-04-02'),
    -> (17, 17,1500,   0,  3000, 'Pending', NULL),
    -> (18, 18, 600,1980,   700, 'Paid',    '2024-04-10'),
    -> (19, 19, 900, 585,  1500, 'Paid',    '2024-04-15'),
    -> (20, 20, 900, 630,  2000, 'Partial', '2024-04-20'),
    -> (21, 21, 850, 540,  1000, 'Paid',    '2024-05-03'),
    -> (22, 22, 600, 150,     0, 'Paid',    '2024-05-07'),
    -> (23, 23,1000,4590,   800, 'Paid',    '2024-05-10'),
    -> (24, 24, 700, 200,  1200, 'Paid',    '2024-05-15'),
    -> (25, 25, 400,   0,   250, 'Paid',    '2024-05-20'),
    -> (26, 26, 900, 240,   600, 'Paid',    '2024-06-01'),
    -> (27, 27,1500,   0,  3500, 'Pending', NULL),
    -> (28, 28, 500, 507,     0, 'Paid',    '2024-06-10'),
    -> (1,  31, 850, 630,  1500, 'Paid',    '2024-07-05'),
    -> (5,  33, 800, 540,   900, 'Paid',    '2024-07-15'),
    -> (13, 34,1000,4590,   800, 'Partial', '2024-07-20'),
    -> (7,  35, 900, 240,   700, 'Paid',    '2024-08-01'),
    -> (9,  36,1500,   0,  3000, 'Pending', NULL);
Query OK, 33 rows affected (0.01 sec)
Records: 33  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Lab Tests
mysql> INSERT INTO lab_tests (appointment_id, test_name, result, is_abnormal, tested_on) VALUES
    -> (1,  'ECG',                 'ST depression noted',         1, '2024-01-10'),
    -> (1,  'Troponin',            '0.08 ng/mL (elevated)',       1, '2024-01-10'),
    -> (3,  'CT Brain',            'No abnormality detected',     0, '2024-01-15'),
    -> (5,  'Blood Pressure',      '148/96 mmHg',                 1, '2024-02-02'),
    -> (5,  'Lipid Profile',       'LDL 145 mg/dL (high)',        1, '2024-02-02'),
    -> (7,  'X-Ray Knee',          'Moderate joint space narrowing',1,'2024-02-10'),
    -> (9,  'PSA',                 '5.8 ng/mL (elevated)',        1, '2024-02-20'),
    -> (9,  'CT Abdomen',          'No mass identified',          0, '2024-02-20'),
    -> (10, 'MRI Brain',           'Normal findings',             0, '2024-03-01'),
    -> (11, 'Holter Monitor 24hr', 'PACs noted; no sustained VT', 1, '2024-03-05'),
    -> (13, 'HbA1c',              '8.2% (above target)',          1, '2024-03-12'),
    -> (13, 'Fasting Blood Sugar', '168 mg/dL',                   1, '2024-03-12'),
    -> (15, 'EEG',                'Focal epileptiform discharges',1, '2024-03-22'),
    -> (17, 'PET Scan',           'Increased FDG uptake noted',   1, '2024-04-07'),
    -> (18, 'TSH',                '6.4 mIU/L (elevated)',         1, '2024-04-10'),
    -> (18, 'Free T4',            '0.8 ng/dL (low)',              1, '2024-04-10'),
    -> (19, 'Angiography',        '70% LAD stenosis',             1, '2024-04-15'),
    -> (20, 'MRI Brain',          'Left MCA territory infarct',   1, '2024-04-20'),
    -> (21, 'ECG',                'Atrial fibrillation pattern',  1, '2024-05-03'),
    -> (23, 'HbA1c',              '9.1% (poorly controlled)',     1, '2024-05-10'),
    -> (27, 'Tumour Markers',     'CA-125 elevated',              1, '2024-06-05'),
    -> (31, 'Stress Test',        'Positive ischemia at 7 METs',  1, '2024-07-05'),
    -> (35, 'X-Ray Knee',         'Moderate joint space narrowing',1,'2024-08-01'),
    -> (36, 'Biopsy Result',      'Malignant cells confirmed',    1, '2024-08-05');
Query OK, 24 rows affected (0.01 sec)
Records: 24  Duplicates: 0  Warnings: 0

mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 4: VIEWS
mysql> -- =============================================================================
mysql>
mysql> -- ── View 1: Patient Master Summary ───────────────────────────────────────────
mysql> CREATE OR REPLACE VIEW vw_patient_summary AS
    -> SELECT
    ->     p.patient_id,
    ->     CONCAT(p.first_name,' ',p.last_name)  AS patient_name,
    ->     p.gender,
    ->     TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) AS age,
    ->     p.blood_group,
    ->     p.city,
    ->     p.state,
    ->     COUNT(DISTINCT a.appointment_id)       AS total_visits,
    ->     SUM(b.total_amount)                    AS total_billed,
    ->     SUM(CASE WHEN b.payment_status = 'Paid'    THEN b.total_amount ELSE 0 END) AS total_paid,
    ->     SUM(CASE WHEN b.payment_status = 'Pending' THEN b.total_amount ELSE 0 END) AS total_pending
    -> FROM patients p
    -> LEFT JOIN appointments a ON p.patient_id = a.patient_id AND a.status = 'Completed'
    -> LEFT JOIN billing b      ON a.appointment_id = b.appointment_id
    -> GROUP BY p.patient_id;
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> -- ── View 2: Doctor Workload ───────────────────────────────────────────────────
mysql> CREATE OR REPLACE VIEW vw_doctor_workload AS
    -> SELECT
    ->     d.doctor_id,
    ->     CONCAT(d.first_name,' ',d.last_name)  AS doctor_name,
    ->     d.specialization,
    ->     dep.dept_name,
    ->     COUNT(a.appointment_id)               AS total_appointments,
    ->     SUM(a.status = 'Completed')           AS completed,
    ->     SUM(a.status = 'Cancelled')           AS cancelled,
    ->     SUM(a.status = 'No-Show')             AS no_show,
    ->     ROUND(SUM(a.status = 'Completed') * 100.0 / COUNT(*), 1) AS completion_pct
    -> FROM doctors d
    -> JOIN departments dep  ON d.department_id = dep.department_id
    -> LEFT JOIN appointments a ON d.doctor_id  = a.doctor_id
    -> GROUP BY d.doctor_id;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- ── View 3: Monthly Revenue ───────────────────────────────────────────────────
mysql> CREATE OR REPLACE VIEW vw_monthly_revenue AS
    -> SELECT
    ->     DATE_FORMAT(b.payment_date, '%Y-%m')   AS month_year,
    ->     COUNT(DISTINCT b.bill_id)              AS bills_count,
    ->     SUM(b.consultation_fee)                AS consultation_revenue,
    ->     SUM(b.medication_cost)                 AS medication_revenue,
    ->     SUM(b.lab_charges)                     AS lab_revenue,
    ->     SUM(b.total_amount)                    AS total_revenue,
    ->     SUM(CASE WHEN b.payment_status = 'Paid' THEN b.total_amount ELSE 0 END) AS collected
    -> FROM billing b
    -> WHERE b.payment_date IS NOT NULL
    -> GROUP BY month_year
    -> ORDER BY month_year;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- ── View 4: High-Risk Patients ────────────────────────────────────────────────
mysql> CREATE OR REPLACE VIEW vw_high_risk_patients AS
    -> SELECT
    ->     p.patient_id,
    ->     CONCAT(p.first_name,' ',p.last_name) AS patient_name,
    ->     p.gender,
    ->     TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) AS age,
    ->     d.description                          AS primary_diagnosis,
    ->     d.severity,
    ->     SUM(l.is_abnormal)                     AS abnormal_tests,
    ->     CONCAT(doc.first_name,' ',doc.last_name) AS treating_doctor
    -> FROM patients p
    -> JOIN appointments a  ON p.patient_id = a.patient_id
    -> JOIN diagnoses d     ON a.appointment_id = d.appointment_id
    -> JOIN doctors doc     ON a.doctor_id = doc.doctor_id
    -> LEFT JOIN lab_tests l ON a.appointment_id = l.appointment_id
    -> WHERE d.severity = 'Severe'
    -> GROUP BY p.patient_id, d.diagnosis_id, doc.doctor_id
    -> ORDER BY abnormal_tests DESC;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 5: CTEs & WINDOW FUNCTIONS
mysql> -- =============================================================================
mysql>
mysql> -- ── Q1: Patient Visit Frequency Ranking ──────────────────────────────────────
mysql> -- Rank patients by number of visits; show running total and dense rank
mysql> WITH visit_counts AS (
    ->     SELECT
    ->         p.patient_id,
    ->         CONCAT(p.first_name,' ',p.last_name) AS patient_name,
    ->         COUNT(a.appointment_id)               AS visits
    ->     FROM patients p
    ->     LEFT JOIN appointments a ON p.patient_id = a.patient_id
    ->                              AND a.status = 'Completed'
    ->     GROUP BY p.patient_id
    -> )
    -> SELECT
    ->     patient_name,
    ->     visits,
    ->     DENSE_RANK()  OVER (ORDER BY visits DESC)                  AS visit_rank,
    ->     SUM(visits)   OVER (ORDER BY visits DESC ROWS UNBOUNDED PRECEDING) AS running_total
    -> FROM visit_counts
    -> ORDER BY visit_rank;
+------------------+--------+------------+---------------+
| patient_name     | visits | visit_rank | running_total |
+------------------+--------+------------+---------------+
| Amit Joshi       |      2 |          1 |             2 |
| Ravi Gupta       |      2 |          1 |             4 |
| Deepak Malhotra  |      2 |          1 |             6 |
| Manish Tiwari    |      2 |          1 |             8 |
| Sanjay Mehta     |      2 |          1 |            10 |
| Vijay Nair       |      2 |          1 |            12 |
| Sunita Kapoor    |      1 |          2 |            13 |
| Pooja Sharma     |      1 |          2 |            14 |
| Kavita Singh     |      1 |          2 |            15 |
| Ananya Roy       |      1 |          2 |            16 |
| Nisha Pillai     |      1 |          2 |            17 |
| Rahul Bajaj      |      1 |          2 |            18 |
| Sneha Bose       |      1 |          2 |            19 |
| Rekha Iyer       |      1 |          2 |            20 |
| Arun Pandey      |      1 |          2 |            21 |
| Geeta Jain       |      1 |          2 |            22 |
| Pradeep Rao      |      1 |          2 |            23 |
| Meena Tripathi   |      1 |          2 |            24 |
| Suresh Kumar     |      1 |          2 |            25 |
| Lata Mishra      |      1 |          2 |            26 |
| Harish Choudhary |      1 |          2 |            27 |
| Poonam Dixit     |      1 |          2 |            28 |
| Ramesh Yadav     |      1 |          2 |            29 |
| Sunanda Ghosh    |      1 |          2 |            30 |
| Tarun Saxena     |      1 |          2 |            31 |
| Ritu Agarwal     |      1 |          2 |            32 |
| Naresh Bhatt     |      1 |          2 |            33 |
| Divya Kulkarni   |      1 |          2 |            34 |
| Mukesh Verma     |      0 |          3 |            34 |
| Anita Pandya     |      0 |          3 |            34 |
+------------------+--------+------------+---------------+
30 rows in set (0.01 sec)

mysql>
mysql>
mysql> -- ── Q2: Month-over-Month Revenue Growth ──────────────────────────────────────
mysql> WITH monthly AS (
    ->     SELECT
    ->         DATE_FORMAT(payment_date,'%Y-%m')   AS mth,
    ->         SUM(total_amount)                   AS revenue
    ->     FROM billing
    ->     WHERE payment_date IS NOT NULL
    ->     GROUP BY mth
    -> )
    -> SELECT
    ->     mth,
    ->     revenue,
    ->     LAG(revenue)  OVER (ORDER BY mth)                  AS prev_revenue,
    ->     ROUND((revenue - LAG(revenue) OVER (ORDER BY mth))
    ->           / NULLIF(LAG(revenue) OVER (ORDER BY mth),0) * 100, 1) AS growth_pct
    -> FROM monthly
    -> ORDER BY mth;
+---------+----------+--------------+------------+
| mth     | revenue  | prev_revenue | growth_pct |
+---------+----------+--------------+------------+
| 2024-01 |  5480.00 |         NULL |       NULL |
| 2024-02 |  8790.00 |      5480.00 |       60.4 |
| 2024-03 | 10215.00 |      8790.00 |       16.2 |
| 2024-04 | 10495.00 |     10215.00 |        2.7 |
| 2024-05 | 12280.00 |     10495.00 |       17.0 |
| 2024-06 |  2747.00 |     12280.00 |      -77.6 |
| 2024-07 | 11610.00 |      2747.00 |      322.6 |
| 2024-08 |  1840.00 |     11610.00 |      -84.2 |
+---------+----------+--------------+------------+
8 rows in set (0.01 sec)

mysql>
mysql>
mysql> -- ── Q3: Doctor's Patient Revenue Percentile ──────────────────────────────────
mysql> WITH doctor_revenue AS (
    ->     SELECT
    ->         d.doctor_id,
    ->         CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    ->         d.specialization,
    ->         SUM(b.total_amount)                   AS total_revenue
    ->     FROM doctors d
    ->     JOIN appointments a ON d.doctor_id = a.doctor_id
    ->     JOIN billing b      ON a.appointment_id = b.appointment_id
    ->     GROUP BY d.doctor_id
    -> )
    -> SELECT
    ->     doctor_name,
    ->     specialization,
    ->     total_revenue,
    ->     ROUND(PERCENT_RANK() OVER (ORDER BY total_revenue) * 100, 1) AS revenue_percentile
    -> FROM doctor_revenue
    -> ORDER BY total_revenue DESC;
+---------------+-----------------------------+---------------+--------------------+
| doctor_name   | specialization              | total_revenue | revenue_percentile |
+---------------+-----------------------------+---------------+--------------------+
| Vikram Reddy  | Oncologist                  |      17700.00 |                100 |
| Neeraj Verma  | General Physician           |      13580.00 |               88.9 |
| Rajesh Sharma | Interventional Cardiologist |      12015.00 |               77.8 |
| Karthik Nair  | General Physician           |       7397.00 |               66.7 |
| Suresh Iyer   | Orthopedic Surgeon          |       7088.00 |               55.6 |
| Priya Mehta   | Neurologist                 |       6430.00 |               44.4 |
| Arjun Singh   | Cardiologist                |       5370.00 |               33.3 |
| Sunita Desai  | Neurologist                 |       4127.00 |               22.2 |
| Ayesha Khan   | Pediatrician                |       2550.00 |               11.1 |
| Meera Patel   | Dermatologist               |       2250.00 |                  0 |
+---------------+-----------------------------+---------------+--------------------+
10 rows in set (0.01 sec)

mysql>
mysql>
mysql> -- ── Q4: Rolling 3-Month Patient Acquisition ──────────────────────────────────
mysql> WITH monthly_reg AS (
    ->     SELECT
    ->         DATE_FORMAT(registered_on,'%Y-%m')   AS mth,
    ->         COUNT(*)                              AS new_patients
    ->     FROM patients
    ->     GROUP BY mth
    -> )
    -> SELECT
    ->     mth,
    ->     new_patients,
    ->     AVG(new_patients) OVER (
    ->         ORDER BY mth
    ->         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ->     ) AS rolling_3m_avg
    -> FROM monthly_reg
    -> ORDER BY mth;
+---------+--------------+----------------+
| mth     | new_patients | rolling_3m_avg |
+---------+--------------+----------------+
| 2026-05 |           30 |        30.0000 |
+---------+--------------+----------------+
1 row in set (0.00 sec)

mysql>
mysql>
mysql> -- ── Q5: Top Diagnosis per Department ─────────────────────────────────────────
mysql> WITH dept_diag AS (
    ->     SELECT
    ->         dep.dept_name,
    ->         diag.description,
    ->         COUNT(*) AS diag_count,
    ->         ROW_NUMBER() OVER (
    ->             PARTITION BY dep.dept_name
    ->             ORDER BY COUNT(*) DESC
    ->         ) AS rn
    ->     FROM diagnoses diag
    ->     JOIN appointments a ON diag.appointment_id = a.appointment_id
    ->     JOIN doctors doc    ON a.doctor_id = doc.doctor_id
    ->     JOIN departments dep ON doc.department_id = dep.department_id
    ->     GROUP BY dep.dept_name, diag.description
    -> )
    -> SELECT dept_name, description AS top_diagnosis, diag_count
    -> FROM dept_diag
    -> WHERE rn = 1
    -> ORDER BY diag_count DESC;
+------------------+--------------------------+------------+
| dept_name        | top_diagnosis            | diag_count |
+------------------+--------------------------+------------+
| General Medicine | Type 2 Diabetes Mellitus |          3 |
| Cardiology       | Essential Hypertension   |          2 |
| Neurology        | Migraine, Unspecified    |          2 |
| Oncology         | Malignant Neoplasm       |          2 |
| Orthopedics      | Osteoarthritis of Knee   |          2 |
| Dermatology      | Dermatitis, Unspecified  |          1 |
| Pediatrics       | Fever, Unspecified       |          1 |
+------------------+--------------------------+------------+
7 rows in set (0.00 sec)

mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 6: ANALYTICAL QUERIES & KPIs
mysql> -- =============================================================================
mysql>
mysql> -- ── KPI 1: Overall Hospital KPIs ─────────────────────────────────────────────
mysql> SELECT
    ->     COUNT(DISTINCT p.patient_id)                                   AS total_patients,
    ->     COUNT(DISTINCT a.appointment_id)                               AS total_appointments,
    ->     SUM(a.status = 'Completed')                                    AS completed_visits,
    ->     ROUND(SUM(a.status = 'Completed') * 100.0 / COUNT(*), 1)      AS completion_rate_pct,
    ->     SUM(a.status = 'No-Show')                                      AS no_shows,
    ->     COUNT(DISTINCT doc.doctor_id)                                  AS active_doctors,
    ->     ROUND(SUM(b.total_amount), 2)                                  AS gross_revenue,
    ->     ROUND(SUM(CASE WHEN b.payment_status='Paid' THEN b.total_amount ELSE 0 END), 2) AS collected_revenue,
    ->     ROUND(SUM(CASE WHEN b.payment_status IN ('Pending','Partial') THEN b.total_amount ELSE 0 END), 2) AS outstanding_ar
    -> FROM patients p
    -> LEFT JOIN appointments a ON p.patient_id = a.patient_id
    -> LEFT JOIN doctors doc    ON a.doctor_id  = doc.doctor_id
    -> LEFT JOIN billing b      ON a.appointment_id = b.appointment_id;
+----------------+--------------------+------------------+---------------------+----------+----------------+---------------+-------------------+----------------+
| total_patients | total_appointments | completed_visits | completion_rate_pct | no_shows | active_doctors | gross_revenue | collected_revenue | outstanding_ar |
+----------------+--------------------+------------------+---------------------+----------+----------------+---------------+-------------------+----------------+
|             30 |                 40 |               34 |                85.0 |        1 |             10 |      78507.00 |          51477.00 |       27030.00 |
+----------------+--------------------+------------------+---------------------+----------+----------------+---------------+-------------------+----------------+
1 row in set (0.00 sec)

mysql>
mysql>
mysql> -- ── KPI 2: Average Revenue per Visit & per Patient ───────────────────────────
mysql> SELECT
    ->     ROUND(AVG(b.total_amount), 2)                  AS avg_revenue_per_visit,
    ->     ROUND(SUM(b.total_amount) / COUNT(DISTINCT b.patient_id), 2) AS avg_revenue_per_patient,
    ->     ROUND(AVG(b.consultation_fee), 2)              AS avg_consultation_fee,
    ->     ROUND(AVG(b.lab_charges), 2)                   AS avg_lab_charges
    -> FROM billing b;
+-----------------------+-------------------------+----------------------+-----------------+
| avg_revenue_per_visit | avg_revenue_per_patient | avg_consultation_fee | avg_lab_charges |
+-----------------------+-------------------------+----------------------+-----------------+
|               2379.00 |                 2803.82 |               809.09 |          986.36 |
+-----------------------+-------------------------+----------------------+-----------------+
1 row in set (0.00 sec)

mysql>
mysql>
mysql> -- ── KPI 3: Department-wise Appointment & Revenue Analysis ────────────────────
mysql> SELECT
    ->     dep.dept_name,
    ->     COUNT(a.appointment_id)          AS total_appointments,
    ->     SUM(a.status = 'Completed')      AS completed,
    ->     ROUND(SUM(b.total_amount), 2)    AS dept_revenue,
    ->     ROUND(AVG(b.total_amount), 2)    AS avg_bill
    -> FROM departments dep
    -> JOIN doctors doc     ON dep.department_id = doc.department_id
    -> LEFT JOIN appointments a ON doc.doctor_id = a.doctor_id
    -> LEFT JOIN billing b  ON a.appointment_id  = b.appointment_id
    -> GROUP BY dep.dept_name
    -> ORDER BY dept_revenue DESC;
+------------------+--------------------+-----------+--------------+----------+
| dept_name        | total_appointments | completed | dept_revenue | avg_bill |
+------------------+--------------------+-----------+--------------+----------+
| General Medicine |                  9 |         7 |     20977.00 |  2996.71 |
| Oncology         |                  4 |         4 |     17700.00 |  4425.00 |
| Cardiology       |                  9 |         7 |     17385.00 |  2483.57 |
| Neurology        |                  8 |         6 |     10557.00 |  2111.40 |
| Orthopedics      |                  4 |         4 |      7088.00 |  1772.00 |
| Pediatrics       |                  3 |         3 |      2550.00 |   850.00 |
| Dermatology      |                  3 |         3 |      2250.00 |   750.00 |
+------------------+--------------------+-----------+--------------+----------+
7 rows in set (0.00 sec)

mysql>
mysql>
mysql> -- ── KPI 4: Top 5 Most Prescribed Medications ─────────────────────────────────
mysql> SELECT
    ->     m.med_name,
    ->     m.category,
    ->     COUNT(rx.prescription_id)          AS times_prescribed,
    ->     SUM(rx.qty)                        AS total_units,
    ->     ROUND(SUM(rx.qty * m.unit_cost),2) AS revenue_generated
    -> FROM prescriptions rx
    -> JOIN medications m ON rx.medication_id = m.medication_id
    -> GROUP BY m.medication_id
    -> ORDER BY times_prescribed DESC
    -> LIMIT 5;
+-------------------+------------------+------------------+-------------+-------------------+
| med_name          | category         | times_prescribed | total_units | revenue_generated |
+-------------------+------------------+------------------+-------------+-------------------+
| Paracetamol 500mg | Analgesic        |                7 |         102 |            183.60 |
| Amlodipine 5mg    | Antihypertensive |                4 |         180 |           1575.00 |
| Aspirin 75mg      | Antiplatelet     |                3 |         210 |            525.00 |
| Diclofenac 50mg   | NSAID            |                3 |          68 |            408.00 |
| Metformin 500mg   | Antidiabetic     |                2 |         360 |           1620.00 |
+-------------------+------------------+------------------+-------------+-------------------+
5 rows in set (0.00 sec)

mysql>
mysql>
mysql> -- ── KPI 5: Patient Age Distribution ──────────────────────────────────────────
mysql> SELECT
    ->     CASE
    ->         WHEN TIMESTAMPDIFF(YEAR,dob,CURDATE()) < 18  THEN '0-17 (Pediatric)'
    ->         WHEN TIMESTAMPDIFF(YEAR,dob,CURDATE()) < 40  THEN '18-39 (Young Adult)'
    ->         WHEN TIMESTAMPDIFF(YEAR,dob,CURDATE()) < 60  THEN '40-59 (Middle Age)'
    ->         ELSE '60+ (Senior)'
    ->     END                         AS age_group,
    ->     COUNT(*)                    AS patient_count,
    ->     ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patients), 1) AS pct
    -> FROM patients
    -> GROUP BY age_group
    -> ORDER BY MIN(TIMESTAMPDIFF(YEAR,dob,CURDATE()));
+---------------------+---------------+------+
| age_group           | patient_count | pct  |
+---------------------+---------------+------+
| 18-39 (Young Adult) |            13 | 43.3 |
| 40-59 (Middle Age)  |            12 | 40.0 |
| 60+ (Senior)        |             5 | 16.7 |
+---------------------+---------------+------+
3 rows in set (0.01 sec)

mysql>
mysql>
mysql> -- ── KPI 6: Disease Burden — Top 10 Diagnoses ─────────────────────────────────
mysql> SELECT
    ->     icd10_code,
    ->     description,
    ->     COUNT(*)                            AS case_count,
    ->     SUM(severity = 'Severe')            AS severe_cases,
    ->     ROUND(SUM(severity='Severe') * 100.0 / COUNT(*), 1) AS severe_pct
    -> FROM diagnoses
    -> GROUP BY icd10_code, description
    -> ORDER BY case_count DESC
    -> LIMIT 10;
+------------+-----------------------------------+------------+--------------+------------+
| icd10_code | description                       | case_count | severe_cases | severe_pct |
+------------+-----------------------------------+------------+--------------+------------+
| E11.9      | Type 2 Diabetes Mellitus          |          3 |            0 |        0.0 |
| G43.9      | Migraine, Unspecified             |          2 |            0 |        0.0 |
| I10        | Essential Hypertension            |          2 |            0 |        0.0 |
| I25.1      | Coronary Artery Disease           |          2 |            2 |      100.0 |
| M17.9      | Osteoarthritis of Knee            |          2 |            0 |        0.0 |
| C80.1      | Malignant Neoplasm                |          2 |            2 |      100.0 |
| J06.9      | Acute Upper Respiratory Infection |          1 |            0 |        0.0 |
| Z00.0      | General Medical Examination       |          1 |            0 |        0.0 |
| L30.9      | Dermatitis, Unspecified           |          1 |            0 |        0.0 |
| R53.83     | Fatigue                           |          1 |            0 |        0.0 |
+------------+-----------------------------------+------------+--------------+------------+
10 rows in set (0.00 sec)

mysql>
mysql>
mysql> -- ── KPI 7: Accounts Receivable Aging ─────────────────────────────────────────
mysql> SELECT
    ->     CASE
    ->         WHEN DATEDIFF(CURDATE(), a.appointment_dt) <= 30  THEN '0–30 days'
    ->         WHEN DATEDIFF(CURDATE(), a.appointment_dt) <= 60  THEN '31–60 days'
    ->         WHEN DATEDIFF(CURDATE(), a.appointment_dt) <= 90  THEN '61–90 days'
    ->         ELSE '90+ days'
    ->     END                                     AS aging_bucket,
    ->     COUNT(b.bill_id)                        AS invoices,
    ->     ROUND(SUM(b.total_amount), 2)           AS outstanding_amount
    -> FROM billing b
    -> JOIN appointments a ON b.appointment_id = a.appointment_id
    -> WHERE b.payment_status IN ('Pending','Partial')
    -> GROUP BY aging_bucket
    -> ORDER BY MIN(DATEDIFF(CURDATE(), a.appointment_dt));
+--------------+----------+--------------------+
| aging_bucket | invoices | outstanding_amount |
+--------------+----------+--------------------+
| 90+ days     |        7 |           27030.00 |
+--------------+----------+--------------------+
1 row in set (0.00 sec)

mysql>
mysql>
mysql> -- ── KPI 8: Abnormal Lab Test Rate by Doctor ───────────────────────────────────
mysql> SELECT
    ->     CONCAT(doc.first_name,' ',doc.last_name) AS doctor_name,
    ->     doc.specialization,
    ->     COUNT(l.lab_id)                          AS tests_ordered,
    ->     SUM(l.is_abnormal)                       AS abnormal_count,
    ->     ROUND(SUM(l.is_abnormal)*100.0/COUNT(*), 1) AS abnormal_rate_pct
    -> FROM doctors doc
    -> JOIN appointments a ON doc.doctor_id = a.doctor_id
    -> JOIN lab_tests l    ON a.appointment_id = l.appointment_id
    -> GROUP BY doc.doctor_id
    -> ORDER BY abnormal_rate_pct DESC;
+---------------+-----------------------------+---------------+----------------+-------------------+
| doctor_name   | specialization              | tests_ordered | abnormal_count | abnormal_rate_pct |
+---------------+-----------------------------+---------------+----------------+-------------------+
| Rajesh Sharma | Interventional Cardiologist |             6 |              6 |             100.0 |
| Suresh Iyer   | Orthopedic Surgeon          |             2 |              2 |             100.0 |
| Neeraj Verma  | General Physician           |             5 |              5 |             100.0 |
| Arjun Singh   | Cardiologist                |             2 |              2 |             100.0 |
| Sunita Desai  | Neurologist                 |             1 |              1 |             100.0 |
| Vikram Reddy  | Oncologist                  |             5 |              4 |              80.0 |
| Priya Mehta   | Neurologist                 |             3 |              1 |              33.3 |
+---------------+-----------------------------+---------------+----------------+-------------------+
7 rows in set (0.00 sec)

mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 7: STORED PROCEDURES
mysql> -- =============================================================================
mysql>
mysql> DELIMITER $$
mysql>
mysql> -- ── SP 1: Book Appointment ───────────────────────────────────────────────────
mysql> CREATE PROCEDURE sp_book_appointment (
    ->     IN  p_patient_id  INT UNSIGNED,
    ->     IN  p_doctor_id   INT UNSIGNED,
    ->     IN  p_datetime    DATETIME,
    ->     IN  p_reason      VARCHAR(255),
    ->     OUT p_appt_id     INT UNSIGNED,
    ->     OUT p_message     VARCHAR(200)
    -> )
    -> BEGIN
    ->     DECLARE v_conflict INT DEFAULT 0;
    ->
    ->     -- Check doctor availability (no completed/scheduled appointment within 30 min)
    ->     SELECT COUNT(*) INTO v_conflict
    ->     FROM appointments
    ->     WHERE doctor_id = p_doctor_id
    ->       AND status IN ('Scheduled','Completed')
    ->       AND ABS(TIMESTAMPDIFF(MINUTE, appointment_dt, p_datetime)) < 30;
    ->
    ->     IF v_conflict > 0 THEN
    ->         SET p_appt_id = 0;
    ->         SET p_message = 'Doctor not available at the requested time.';
    ->     ELSE
    ->         INSERT INTO appointments (patient_id, doctor_id, appointment_dt, status, reason)
    ->         VALUES (p_patient_id, p_doctor_id, p_datetime, 'Scheduled', p_reason);
    ->
    ->         SET p_appt_id = LAST_INSERT_ID();
    ->         SET p_message = CONCAT('Appointment booked successfully. ID: ', p_appt_id);
    ->     END IF;
    -> END$$
Query OK, 0 rows affected (0.05 sec)

mysql>
mysql>
mysql> -- ── SP 2: Complete Visit & Generate Bill ──────────────────────────────────────
mysql> CREATE PROCEDURE sp_complete_visit (
    ->     IN  p_appointment_id   INT UNSIGNED,
    ->     IN  p_consultation_fee DECIMAL(10,2),
    ->     IN  p_lab_charges      DECIMAL(10,2),
    ->     IN  p_notes            TEXT
    -> )
    -> BEGIN
    ->     DECLARE v_patient_id  INT UNSIGNED;
    ->     DECLARE v_med_cost    DECIMAL(10,2) DEFAULT 0;
    ->
    ->     -- Get patient
    ->     SELECT patient_id INTO v_patient_id
    ->     FROM appointments WHERE appointment_id = p_appointment_id;
    ->
    ->     -- Calculate medication cost from prescriptions
    ->     SELECT COALESCE(SUM(rx.qty * m.unit_cost), 0) INTO v_med_cost
    ->     FROM prescriptions rx
    ->     JOIN medications m ON rx.medication_id = m.medication_id
    ->     WHERE rx.appointment_id = p_appointment_id;
    ->
    ->     -- Update appointment status
    ->     UPDATE appointments
    ->     SET status = 'Completed', notes = p_notes
    ->     WHERE appointment_id = p_appointment_id;
    ->
    ->     -- Insert or update billing record
    ->     INSERT INTO billing (patient_id, appointment_id, consultation_fee, medication_cost, lab_charges, payment_status)
    ->     VALUES (v_patient_id, p_appointment_id, p_consultation_fee, v_med_cost, p_lab_charges, 'Pending')
    ->     ON DUPLICATE KEY UPDATE
    ->         consultation_fee = p_consultation_fee,
    ->         medication_cost  = v_med_cost,
    ->         lab_charges      = p_lab_charges;
    ->
    ->     SELECT CONCAT('Visit completed. Bill generated for patient ID: ', v_patient_id) AS result;
    -> END$$
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql>
mysql> -- ── SP 3: Patient History Report ─────────────────────────────────────────────
mysql> CREATE PROCEDURE sp_patient_history (IN p_patient_id INT UNSIGNED)
    -> BEGIN
    ->     -- Patient details
    ->     SELECT patient_id,
    ->            CONCAT(first_name,' ',last_name)          AS patient_name,
    ->            TIMESTAMPDIFF(YEAR, dob, CURDATE())        AS age,
    ->            gender, blood_group, city, state
    ->     FROM patients
    ->     WHERE patient_id = p_patient_id;
    ->
    ->     -- Visit history
    ->     SELECT
    ->         a.appointment_id,
    ->         a.appointment_dt,
    ->         CONCAT(doc.first_name,' ',doc.last_name)     AS doctor,
    ->         doc.specialization,
    ->         dep.dept_name,
    ->         a.status,
    ->         a.reason,
    ->         d.description   AS diagnosis,
    ->         d.severity,
    ->         b.total_amount,
    ->         b.payment_status
    ->     FROM appointments a
    ->     JOIN doctors doc      ON a.doctor_id       = doc.doctor_id
    ->     JOIN departments dep  ON doc.department_id  = dep.department_id
    ->     LEFT JOIN diagnoses d ON a.appointment_id   = d.appointment_id
    ->     LEFT JOIN billing b   ON a.appointment_id   = b.appointment_id
    ->     WHERE a.patient_id = p_patient_id
    ->     ORDER BY a.appointment_dt DESC;
    ->
    ->     -- Outstanding balance
    ->     SELECT ROUND(SUM(b.total_amount),2)       AS gross_total,
    ->            ROUND(SUM(CASE WHEN b.payment_status='Paid' THEN b.total_amount ELSE 0 END),2)    AS paid,
    ->            ROUND(SUM(CASE WHEN b.payment_status!='Paid' THEN b.total_amount ELSE 0 END),2)   AS balance_due
    ->     FROM billing b
    ->     JOIN appointments a ON b.appointment_id = a.appointment_id
    ->     WHERE a.patient_id = p_patient_id;
    -> END$$
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql>
mysql> -- ── SP 4: Department Revenue Summary ─────────────────────────────────────────
mysql> CREATE PROCEDURE sp_dept_revenue_summary (
    ->     IN p_start_date DATE,
    ->     IN p_end_date   DATE
    -> )
    -> BEGIN
    ->     SELECT
    ->         dep.dept_name,
    ->         COUNT(DISTINCT a.appointment_id)        AS visits,
    ->         COUNT(DISTINCT a.patient_id)            AS unique_patients,
    ->         ROUND(SUM(b.consultation_fee), 2)       AS consultation_revenue,
    ->         ROUND(SUM(b.medication_cost), 2)        AS medication_revenue,
    ->         ROUND(SUM(b.lab_charges), 2)            AS lab_revenue,
    ->         ROUND(SUM(b.total_amount), 2)           AS total_revenue,
    ->         ROUND(AVG(b.total_amount), 2)           AS avg_bill_per_visit
    ->     FROM departments dep
    ->     JOIN doctors doc      ON dep.department_id = doc.department_id
    ->     LEFT JOIN appointments a ON doc.doctor_id  = a.doctor_id
    ->               AND DATE(a.appointment_dt) BETWEEN p_start_date AND p_end_date
    ->     LEFT JOIN billing b   ON a.appointment_id  = b.appointment_id
    ->     GROUP BY dep.dept_name
    ->     ORDER BY total_revenue DESC;
    -> END$$
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> DELIMITER ;
mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 8: SAMPLE PROCEDURE CALLS (uncomment to run)
mysql> -- =============================================================================
mysql>
mysql> -- CALL sp_book_appointment(5, 2, '2024-09-01 10:00:00', 'Follow-up migraine', @id, @msg);
mysql> -- SELECT @id AS appointment_id, @msg AS message;
mysql>
mysql> -- CALL sp_complete_visit(37, 700.00, 600.00, 'Patient responded well to treatment.');
mysql>
mysql> -- CALL sp_patient_history(1);
mysql>
mysql> -- CALL sp_dept_revenue_summary('2024-01-01', '2024-12-31');
mysql>
mysql>
mysql> -- =============================================================================
mysql> -- SECTION 9: QUICK VALIDATION QUERIES
mysql> -- =============================================================================
mysql>
mysql> SELECT 'Patients'     AS entity, COUNT(*) AS total FROM patients
    -> UNION ALL
    -> SELECT 'Doctors',       COUNT(*) FROM doctors
    -> UNION ALL
    -> SELECT 'Appointments',  COUNT(*) FROM appointments
    -> UNION ALL
    -> SELECT 'Diagnoses',     COUNT(*) FROM diagnoses
    -> UNION ALL
    -> SELECT 'Prescriptions', COUNT(*) FROM prescriptions
    -> UNION ALL
    -> SELECT 'Billing Records',COUNT(*) FROM billing
    -> UNION ALL
    -> SELECT 'Lab Tests',     COUNT(*) FROM lab_tests;
+-----------------+-------+
| entity          | total |
+-----------------+-------+
| Patients        |    30 |
| Doctors         |    10 |
| Appointments    |    40 |
| Diagnoses       |    34 |
| Prescriptions   |    30 |
| Billing Records |    33 |
| Lab Tests       |    24 |
+-----------------+-------+
7 rows in set (0.00 sec)

mysql>
mysql> -- =============================================================================
mysql> -- END OF PROJECT
mysql> -- =======================