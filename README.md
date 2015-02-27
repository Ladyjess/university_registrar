#University Registrar

(Incomplete) This app will allow the user to enter names of students and names of courses.

You can add a course to a student and add a student to a course.

Database will be a many to many relationship


#Author

Jessica Hori

#Install

Clone repository and run bundle in order to use required gem dependencies.

#Database Setup

This app uses Postgres, but you should be able to use it with all relational databases with the current set up.

Step one:  ```CREATE DATABASE university_registrar```

Enter database with ```\c university_registrar```

Step two: ```CREATE TABLE students (id serial PRIMARY KEY, name VARCHAR, date_of_enrollment DATE);```

Step three: ```CREATE TABLE courses (id serial PRIMARY KEY, name VARCHAR, course_number VARCHAR);```



Next will have to make our join table. This will provide the many-to-many relationship between
courses and students. A student can have many courses.  A course can have many students.

Step four: ```CREATE TABLE courses_students (id serial PRIMARY KEY, student_id int, course_id int);```
