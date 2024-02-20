create database train;
use train;

-- Create the 'trains' table
CREATE TABLE trains (train_id INT PRIMARY KEY,train_name VARCHAR(100),source_station VARCHAR(100),destination_station VARCHAR(100),departure_time TIME,arrival_time TIME,total_seats INT);

-- Insert sample data into the 'trains' table
INSERT INTO trains (train_id, train_name, source_station, destination_station, departure_time, arrival_time, total_seats) VALUES
(1, 'Express 1', 'Station A', 'Station B', '08:00:00', '12:00:00', 100),
(2, 'Express 2', 'Station A', 'Station C', '10:00:00', '14:00:00', 120),
(3, 'Local 1', 'Station B', 'Station C', '09:00:00', '13:00:00', 80),
(4,'Bidar express','Station B', 'Station A','07:00:00', '15:00:00', 60),
(5,'Basava express','Station C', 'Station D','06:00:00', '16:00:00', 40),
(6,'Bangalore express','Station D', 'Station C','05:00:00', '17:00:00', 130),
(7,'Tamilnadu express','Station A', 'Station D','07:01:00', '18:00:00', 70),
(8,'solapur express','Station E', 'Station A','07:30:00', '19:00:00', 140),
(9,'Yashavantpur express','Station E', 'Station B','08:30:00', '20:00:00', 150),
(10,'Udyan express','Station E', 'Station C','10:00:00', '21:00:00', 160);
select * from trains;

-- Create the 'bookings' table
CREATE TABLE bookings (booking_id INT PRIMARY KEY,train_id INT,passenger_name VARCHAR(100),booking_date DATE,seat_number INT,FOREIGN KEY (train_id) REFERENCES trains(train_id));
-- Insert sample data into the 'bookings' table
INSERT INTO bookings (booking_id, train_id, passenger_name, booking_date, seat_number) VALUES
(101, 1, 'John Doe', '2024-02-01', 5),
(102, 2, 'Jane Smith', '2024-02-05', 10),
(103, 3, 'Alice Johnson', '2024-02-10', 15),
(104,4,'Bhavani','2024-02-11',18),
(105,5,'Maani','2024-02-12',20),
(106,6,'Vikas','2024-02-13',25),
(107,7,'Ashwini','2024-02-15',26),
(108,8,'Sharan','2024-02-16',28),
(109,9,'satish','2024-03-01',30),
(110,10,'Kavita','2024-04-11',40);
select * from bookings;

-- Query to display all bookings for a specific train (e.g., train_id = 1)
SELECT booking_id, passenger_name, booking_date, seat_number FROM bookings WHERE train_id = 1;

-- Query to check available seats for a specific train (e.g., train_id = 1)
SELECT total_seats - COUNT(bookings.booking_id) AS available_seats FROM trains LEFT JOIN bookings ON trains.train_id = bookings.train_id WHERE trains.train_id = 1;

-- Query to check train schedule between two stations
-- For example, between 'Station A' and 'Station C'
SELECT train_name, departure_time, arrival_time FROM trains WHERE source_station = 'Station A' AND destination_station = 'Station C';

-- it will give tarins_name in order
select * from trains order by train_name;

-- updating train table using case statement
SET SQL_SAFE_UPDATES=0;
update trains set total_seats = case
when train_id=1 then 200
when train_id=2 then 400
else '100'
end;
select * from trains;

-- Using aggregate functions
select count(*) from trains;         -- it caluculates no.of  counts from trains
select avg(total_seats) from trains; -- it calculates average of total seats from trains table
select sum(total_seats) from trains; -- it calculates sum of total seats from trains table

-- trigers
delimiter $$
create trigger train_insert
before insert on trains
for each row
begin
   if new.total_seats < 50 then
   signal SQLSTATE '45000' /** code word**/
         set message_text = 'not available';
   end if;
end;
$$
delimiter ;












