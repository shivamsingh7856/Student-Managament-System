# Student-Managament-System
A web-based **Student Management System** developed using Java, JSP, Servlets, MySQL, and Apache Tomcat. This project simplifies student record management, attendance tracking, and report generation through an admin dashboard.

## 🚀 Features

### 👨‍💼 Admin Dashboard

* View registered students and their details.
* Search students by name.
* Filter students by stream and batch.
* Register new students.
* Manage student records.

### 📝 Student Registration

* Register students with the following details:

  * Student name
  * Mobile number
  * Hobby
  * Address
  * Stream
  * Batch
  * Student photo
* Upload student photographs.
* Store student information in the MySQL database.

### 📊 Attendance Management

* Admin manually updates student attendance.
* Store attendance information in the database.
* Identify students whose attendance is below 70%.
* Filter attendance records for reporting purposes.

### 📄 PDF Report Generation

* Generate student reports in PDF format.
* View all student records in the report.
* Generate reports containing only students with attendance below 70%.
* Filter reports by student name, stream, and batch.
* Print or save reports for submission to the Head of Department or Principal.

### 🔐 Login System

* Admin and student login functionality.
* Role-based access to relevant dashboards.
* Session management and logout functionality.

## 🛠️ Technologies Used

| Technology       | Purpose                                     |
| ---------------- | ------------------------------------------- |
| Java             | Backend application logic                   |
| JSP              | Dynamic web pages                           |
| Jakarta Servlets | Request handling and application processing |
| JDBC             | Database connectivity                       |
| MySQL            | Student and attendance data storage         |
| Apache Tomcat 11 | Web application server                      |
| HTML5            | Web page structure                          |
| CSS3             | Styling                                     |
| Bootstrap        | Responsive user interface                   |
| OpenPDF          | PDF report generation                       |
| Eclipse IDE      | Development environment                     |

## 🔒 Security Notes
* Keep database credentials outside source code.
* Do not commit passwords, personal student data, or uploaded student photographs.
* Validate user input on the server.
* Use prepared statements for SQL queries.
* Store passwords securely using a suitable password-hashing algorithm.
* Validate uploaded file types and sizes.
* Restrict administrative functions to authenticated admins.

