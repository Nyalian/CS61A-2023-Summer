.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color='blue' AND pet='dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color='blue' AND pet='dog';


CREATE TABLE matchmaker AS
  SELECT t1.pet, t1.song, t1.color, t2.color 
    FROM students AS t1, students AS t2 
      WHERE t1.pet=t2.pet AND t1.song=t2.song AND t1.time<t2.time;


CREATE TABLE sevens AS
  SELECT stu.seven 
    FROM students AS stu, numbers AS num
      WHERE stu.number=7 AND num.'7'='True' and stu.time=num.time;


CREATE TABLE smallest_int_having AS
  SELECT time, min(smallest) 
    FROM students 
      GROUP BY smallest HAVING count(smallest)=1;

