USE HotelSalesDB;

-- Question - 1] The accounts team wants to check payments made via UPI to measure digital adoption.
select * from payments
where PaymentMethod = 'UPI';

-- Question - 2] List all unique first names of customers for a duplicate check.
select distinct firstname from customers;

-- Question - 3] Delete all rooms with Capacity = 1.
select * from rooms
where capacity = 1;

set sql_safe_updates=0;

start transaction;

delete from rooms
where capacity = 1;

ROLLBACK;

-- Question - 4] Display each customer’s name and phone number together using CONCAT.
select concat( FirstName, ' ',LastName, '  - ', Phone) as Customercontact from customers;

-- Question - 5] The booking office wants to see bookings where RoomID = 10 to check utilization of a specific room.
select * from BOOKINGS
where roomid=10;

-- Question - 6] Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery)
SELECT RoomID, Capacity
FROM rooms
WHERE Capacity > (SELECT AVG(Capacity) FROM rooms);

-- Question - 7] Create a VIEW StaffContact showing Staff FirstName, LastName, Role, and Phone.
 create view Staffcontact as  
 select FirstName, LastName, Role, Phone from staff;
 
 select * from staffcontact;

-- Question - 8] The receptionist wants to offer Suite rooms under ₹7000 to business travelers.
select * from rooms
where RoomType= 'Suite' and  PricePerNight < 7000;

-- Question - 9] The admin wants to see email addresses sorted by LastName from the Customers table.
select Email,  lastname from customers
order by LastName;

-- Question - 10] Show staff full names combined into one column.
select concat(FirstName, ' ' , LastName) as staff_fullname from staff;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 11] Display all payment details in one line using CONCAT_WS.
SELECT CONCAT_WS(' | ', PaymentID, BookingID, PaymentDate, PaymentMethod,  Amount) AS PaymentDetails FROM Payments;

-- Question - 12] The hotel wants to display the 2 most expensive rooms for VIP guests.
select RoomID, RoomType, PricePerNight, Capacity from rooms
order by PricePerNight desc
limit 2;

-- Question - 13] Show each BookingID with its CheckIn and CheckOut dates combined.
select BookingID, CONCAT(CheckInDate, ' to ',  CheckOutDate) StayingPeriod from BOOKINGS;

-- Question - 14] Finance wants to calculate the average Amount per PaymentMethod.
select PaymentMethod, avg(Amount)  from payments
group by PaymentMethod;

-- Question - 15] The analytics team wants to find the city where average CustomerID is greater than 50.
select city, avg(CustomerID) from customers
group by city
having avg(CustomerID) > 50;

-- Question - 16] Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)
SELECT *
FROM Bookings
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Bookings);

-- Question - 17] Display the last 2 added rooms from the Rooms table.
select * from rooms
order by roomid desc
limit 2; 

-- Question - 18] The cashier wants a report of payments where Amount < ₹1500 for small transactions.
select * from payments
where Amount < 1500;

-- Question - 19] Management wants to list all customers who have made more than 5 bookings.
select c.CustomerID, CONCAT(FirstName, ' ', LastName) AS CustomerName, COUNT(*) AS BookingCount from BOOKINGS b
join customers c 
on b.CustomerID = c.CustomerID
group by c.CustomerID, c.FirstName, c.LastName
having count(*) > 5 ;


-- Question - 20] Identify customers who live in the same city. (Customers self join)
select c1.CustomerID, concat(c1.firstname,' ', c1.lastname) as CustomerName, c2.CustomerID, concat(c2.firstname,' ', c2.lastname) as CustomerName from customers c1
join customers c2
on c1.city = c2.city  AND c1.CustomerID < c2.CustomerID;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 21] Show the total revenue handled by each StaffID.
SELECT StaffID, SUM(TotalAmount) AS TotalRevenue
FROM Bookings
GROUP BY StaffID;

-- Question - 22] The manager wants to see all customers from Mumbai to check city-wise marketing campaigns.
select * from customers
where city = 'Mumbai';

-- Question - 23] Display the 3 lowest booking amounts.
SELECT BookingID, TotalAmount FROM Bookings
ORDER BY TotalAmount ASC
LIMIT 3;

-- Question - 24] Insert 5 new room records with type, price, and capacity into the Rooms table.
INSERT INTO Rooms (RoomType, PricePerNight, Capacity) VALUES
('Double', 8745, 3),
('Suite', 9000, 1),
('Single', 2000, 4),
('Family', 4500, 2),
('Deluxe', 6000, 2);

-- Question - 25] Show all unique CustomerIDs from bookings.
select DISTINCT  CustomerID from bookings;

-- Question - 26] Create a trigger to automatically delete a payment when its corresponding booking is deleted.
DELIMITER $$

CREATE TRIGGER DeletePaymentOnBookingDelete
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN 
DELETE FROM Payments
WHERE BookingID = OLD.BookingID;

END$$

DELIMITER ;

-- Question - 27] The marketing team wants to update the FirstName of CustomerID = 30 to'Rahul'.
select Firstname from customers
where customerid = 30;

update customers
set Firstname ='Rahul'
where customerID = 30;

-- Question - 28] List all bookings ordered by CheckInDate.
select * from BOOKINGS
order by CheckInDate;

-- Question - 29] Show all rooms where capacity is greater than 2.
select * from rooms
where capacity > 2;

-- Question - 30] List staff emails ordered by their roles.
select StaffID, Email, role from staff
order by role;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 31] Display each customer’s full name and city using CONCAT_WS.
select CONCAT_WS(' | ' , Firstname, Lastname, city) as CustomerInfo from customers;

-- Question - 32] Show the first 4 customers’ full names only.
select concat(firstname, ' ' , lastname) as FullName from customers
limit 4;

-- Question - 33] Show each staff’s role with their full name.
select concat(FirstName, ' ' , LastName) as Fullname , Role from staff;

-- Question - 34] Management wants to find the average StaffID per role.
select avg(staffid), role from staff
group by role;

-- Question - 35] List all bookings handled by StaffID = 2.
select * from bookings
where staffid = 2;

-- Question - 36] Display the first 3 staff alphabetically by their first names.
select * from staff
order by FirstName
limit 3;

-- Question - 37] The front desk manager wants to see customers where FirstName = 'Amit' AND City = 'Nagpur' for personal attention.
select * from customers
where Firstname = 'Amit' and City = 'Nagpur' ;

-- Question - 38] Show all unique payment methods in descending order.
select distinct PaymentMethod from payments
order by PaymentMethod desc;

-- Question - 39] Insert 5 staff members into the Staff table with their role, phone, and email.
Insert into staff  (FirstName, LastName, Role, Phone, Email)
Values
('Rahul', 'Nagpure', 'Manager', '8380995374', 'rahulnag@arbor.org'),
('sameer', 'jivtode', 'Chef', '9156442607', 'sameerjiv@arbor.org'),
('Saurav', 'jambhulkar', 'Housekeeping', '8326542689', 'sauravjam@arbor.org'),
('Abhishek', 'Kolate', 'Waiter', '9874612862', 'abhishekkolate@arbor.org'),
('yash', 'surya', 'Receptionist', '8674953584', 'yashsurya@arbor.org')
;
select * from staff;

-- Question - 40] The hotel manager wants to review bookings where CheckInDate is after '2024-01-01' to analyze recent occupancy.
select * from bookings
where CheckInDate > '2024-01-01';

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 41] List all customers whose FirstName is 'Rahul' for a loyalty program.
select * from customers
where firstname= 'Rahul';

-- Question - 42] Show all unique room types offered by the hotel.
select distinct roomtype from rooms;

-- Question - 43] Identify customers who spent more than 50,000 in total.
select c.customerid, concat (c.firstname, ' ', c.lastname)as customername, sum(b.totalamount) as Totalspent
from customers c
join bookings b
on c.customerid = b.customerid
group by c.customerid, c.firstname, c.lastname
having sum(b.totalamount) > 50000;

-- Question - 44] Delete all customers from the city 'TestCity'.
select city from customers
where city = 'TestCity';

start transaction;

delete from customers
where city = 'TestCity';

rollback;


-- Question - 45] Find rooms that have the same PricePerNight. (Rooms self join)
select r1.roomid, r1.RoomType, r1.PricePerNight, r2.roomid, r2.RoomType from rooms r1
join rooms r2
on r1.PricePerNight = r2.PricePerNight
and r1.roomid < r2.roomid;

-- Question - 46] The manager wants to see staff whose Email ends with '@tcs.in' for corporate tieups.
select StaffID, Email from staff
where Email LIKE '%@tcs.in';
-- Question - 47] The analytics team wants to list all cities where maximum CustomerID is more than 100.
select max(CustomerID), City from customers
group by city
having max(customerid)>100;

-- Question - 48] Show all unique capacities in descending order.
select distinct Capacity from rooms
order by capacity desc;

-- Question - 49] List staff working as Managers
select * from staff
where Role = 'Manager';

-- Question - 50] Display each payment’s ID, Method, Amount in one line.
select concat(PaymentID,' ', PaymentMethod, ' ', Amount) from payments;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


-- Question - 51] Show the first 4 payments only.
select * from payments
limit 4;

-- Question - 52] The hotel manager wants to review rooms where PricePerNight is between ₹2000 and ₹4000 to offer discounts.
select * from rooms
where PricePerNight between 2000 and 4000;

-- Question - 53] List all bookings ordered by CheckInDate.
select * from bookings
order by CheckInDate;

-- Question - 54] Display all unique CustomerIDs from bookings.
select distinct CustomerID from bookings;

-- Question - 55] The hotel manager wants to add new customer details. Insert 5 records with full details into the Customers table.
Insert into customers (FirstName, LastName, Email, Phone, City)
Values
('Prajwal', 'Nannaware', 'prajwalNana@gmail.com', '9897525234', 'mumbai'),
('suhas', 'ghonmode', 'suhasgh@yahoo.in', '9875655244', 'pune'),
('Saurav', 'nikahde', 'sauravnikha@tcs.in', '9897894974', 'nagpur'),
('aniket', 'Katare', 'aniketkata@infosys.com', '8979497455', 'hyderabad'),
('chirag', 'chafle', 'chiragchafle@gmail.com', '8769458954', 'delhi');

select * from customers
order by customerid desc;

-- Question - 56] Show the last 2 staff hired.
select * from staff
order by staffid  desc
limit 2;


-- Question - 57] Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)
select * from rooms
where PricePerNight > (select max(PricePerNight) from rooms 
													where capacity = 2);


-- Question - 58] The HR team wants to see staff whose Role is not 'Chef' for role reallocation.
select * from staff
where Role <> 'Chef';

-- Question - 59] Show all unique cities in descending order from the Customers table.
select distinct city from customers
order by city desc;

-- Question - 60] Display the phone number of the Waiter only.
select StaffID, Phone from staff
where role = 'waiter';

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


-- Question - 61] Display the last 2 bookings in the table.
select * from bookings
order by bookingid desc
limit 2;

-- Question - 62] The marketing team wants to see customers living in Delhi or Chennai for targeted promotions.
select * from customers
where city = 'delhi' or city =  'chennai';

-- Question - 63] Show all rooms where RoomType != 'Family' to plan renovations.
select * from rooms
where roomtype  != 'Family';

-- Question - 64] List staff emails ordered by their roles.
 select StaffID, Role, Email from  staff
 order by role;

-- Question - 65] Display all unique payment methods.
select distinct PaymentMethod from payments;

-- Question - 66] The receptionist wants a list of customers whose Phone starts with '98' for mobile offers.
select * from customers
where Phone like '98%';

-- Question - 67] Show the 3 cheapest rooms available for budget travelers.
select * from rooms
order by PricePerNight 
limit 3;

-- Question - 68] Display the last 2 payments.
select * from payments
order by  PaymentDate desc  
limit 2;

-- Question - 69] Management wants to know which unique cities customers come from.
select distinct city from customers;

-- Question - 70] List all bookings where TotalAmount > 5000.
select * from bookings
where totalamount > 5000;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


-- Question - 71] Display each staff’s Role with their Email in one column.
select concat(Role, '- ', Email) as StaffRoleWithEmail from staff;

-- Question - 72] Show the first 4 staff full names.
select concat(firstname, " ", lastname) AS fullname from staff
limit 4;

-- Question - 73] Find bookings where TotalAmount is greater than all bookings made by CustomerID = 10. (Bookings subquery)
select * from bookings
where totalamount > all (select max(totalamount) from bookings where customerid = 10);

-- Question - 74] List rooms with capacity >= 3 for family bookings.
select * from rooms
where capacity >= 3;

-- Question - 75] Display the RoomType and Price of only Suite rooms.
select RoomID, RoomType, PricePerNight from rooms
where roomtype = 'Suite';

-- Question - 76] The cashier wants to see payments with Amount between ₹2000 and ₹7000 for mid-range billing checks.
select * from payments
where Amount between 2000 and 7000;

-- Question - 77] Insert 5 booking records into the Bookings table with all details.
insert into bookings (CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount )
values
(27, 15, 8, '2025-03-05', '2025-03-07', 5200),
(14, 65, 6, '2025-03-08', '2025-03-11', 8900),
(33, 54, 4, '2025-03-12', '2025-03-13', 3100),
(19, 26, 7, '2025-03-15', '2025-03-18', 11400),
(41, 64, 5, '2025-03-20', '2025-03-22', 7600)
;
select * from bookings
order by bookingid desc;


-- Question - 78] Display the 3 lowest payments made by customers.
select * from payments
order by Amount 
limit 3;

-- Question - 79] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat(BookingID,' ', TotalAmount) as BookingInfo  from bookings;

-- Question - 80] Show all unique RoomIDs in descending order.
select distinct roomid from rooms
order by roomid desc;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 81] Display each room’s RoomType and Price using CONCAT_WS.
select CONCAT_WS( ' | ', roomtype, PricePerNight) as Room_Price from rooms;

-- Question - 82] The admin wants to delete all bookings handled by StaffID = 3.
select * from bookings
where staffid = 3;
start transaction;

delete from bookings
where staffid = 3;

rollback;

-- Question - 83] Show customers whose FirstName length > 5 characters for a name-patternstudy.
select Firstname from customers
where firstname like '______%';

SELECT FirstName
FROM Customers
WHERE CHAR_LENGTH(FirstName) > 5;

-- Question - 84] Show all unique roles available in the hotel.
select distinct role from staff;

-- Question - 85] List all rooms where capacity is greater than 2.
select * from rooms
where capacity > 2;

-- Question - 86] Display each payment’s ID with Amount using CONCAT.
select concat(PaymentID, ' ',Amount ) as IDswithAmount from payments;

-- Question - 87] List all Card payments from the Payments table.
select * from payments
where PaymentMethod = 'card';

-- Question - 88] Delete all customers whose Email ends with '@test.com' as invalid.
select Email from customers
where Email like '%@test.com' ;

start transaction;

delete from customers
where Email like '%test.com';

Rollback;

-- Question - 89] The hotel manager wants to review bookings where CheckOutDate before '2023-12-31' to measure old occupancy.
select * from bookings
where CheckOutDate < '2023-12-31';

-- Question - 90] The front office manager needs to list rooms with capacity = 2 for couples.
select * from rooms
where capacity = 2;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


-- Question - 91] Show all unique capacities in descending order.
select distinct capacity from rooms
order by capacity desc;

-- Question - 92] The operations team wants to find the minimum TotalAmount in bookings.
select min(TotalAmount) from bookings;

-- Question - 93] Display all rooms by capacity in ascending order.
select * from rooms
order by capacity asc;

-- Question - 94] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat(BookingID, ' ', TotalAmount) as BookingAmountbyID from bookings;

-- Question - 95] The operations head wants to see rooms with Capacity = 4 AND PricePerNight >₹6000 for premium family packages.
select * from rooms
where capacity = 4 and PricePerNight > 6000;

-- Question - 96] Show staff full names combined into one column.
select concat(FirstName, ' ', LastName) as Staff_FullName from staff;

-- Question - 97] The accounts team wants to see bookings where the TotalAmount is greater than ₹10,000 to track high-value customers.
select * from bookings
where TotalAmount > 10000;

-- Question - 98] Show all unique payment methods in descending order.
select distinct PaymentMethod from payments
order by PaymentMethod desc;

-- Question - 99] List staff members who share the same Role. (Staff self join)
select s1.StaffID, concat(s1.FirstName, s1.LastName) as Full_Name, s1.Role, s2.StaffID, concat(s2.FirstName, s2.LastName) as Full_Name, s2.Role  from staff s1
join staff s2
on s1.staffid < s2.staffid and s1.role = s2.role;

-- Question - 100] Show customer first name, last name, and TotalAmount of their bookings using JOIN between Customers and Bookings
select  c.FirstName, c.LastName, b.TotalAmount from customers c
join bookings b
on c.CustomerID = b.CustomerID;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 101] Display the first 4 bookings only.
select * from bookings
limit 4;

-- Question - 102] Show all unique staff first names.
select distinct firstname from staff;

-- Question - 103] Insert 5 new room records with type, price, and capacity into the Rooms table.
insert into rooms ( RoomType, PricePerNight, Capacity)
values
('Single', 2500, 7),
('Double', 4000, 6),
('Deluxe', 6000, 2),
('Suite', 9000, 4),
('Family', 3000, 5)
;
select * from rooms
order by roomid desc;

-- Question - 104] Display each customer’s full name and city using CONCAT_WS.
select concat_ws(' | ', Firstname, Lastname, city) as Full_Namecity from customers;

-- Question - 105] Show all unique cities in descending order from the Customers table.
select distinct city from customers
order by city desc;

-- Question - 106] The analytics team wants to list all cities where maximum CustomerID is more than 100.
select max(customerid), city from customers
group by city
having max(customerid) > 100;

-- Question - 107] The HR team wants to see staff whose FirstName is 'Priya' for employee recognition.
select * from staff
where Firstname = 'Priya';

-- Question - 108] Display the last 2 staff members from the Staff table.
select * from staff
order by staffid desc
limit 2;

-- Question - 109] Create a VIEW BookingSummary showing BookingID, CustomerID, RoomID, and TotalAmount.
create view  BookingSummary as
select BookingID, CustomerID, RoomID,  TotalAmount from bookings;

select * from BookingSummary;

-- Question - 110] Show all unique RoomIDs in descending order.
select distinct roomid from rooms
order by roomid desc;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 111] Display each staff’s role with their full name.
select concat(Firstname, ' ', lastname) as fullName , role from staff;

-- Question - 112] The receptionist wants to offer Suite rooms under ₹7000 to business travelers.
select * from rooms
where roomtype = 'suite' and PricePerNight < 7000;

-- Question - 113] Display the first 3 staff alphabetically by their first names.
select firstname from staff
order by firstname 
limit 3;

-- Question - 114] List all bookings ordered by CheckInDate.
select * from bookings
order by CheckInDate;

-- Question - 115] Show all unique StaffIDs from the bookings.
select distinct staffid from bookings;

-- Question - 116] Display the first 4 customers’ full names only.
select concat(firstname , ' ',  lastname) as fullname from customers
limit 4;
-- Question - 117] Show all unique room types offered by the hotel.
select distinct roomtype from rooms;

-- Question - 118] Display the phone number of the Waiter only.
select  Phone  from staff
where role ='waiter';

-- Question - 119] Show all bookings where TotalAmount > 5000.
select * from bookings
where totalamount > 5000;

-- Question - 120] The HR team wants to update Role = 'Senior Manager' where StaffID = 12.
select * from staff;

update staff
set role = 'Senior Manager'
where StaffID = 12;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 121] List all staff working as Managers.
select * from staff
where role = 'Manager';

-- Question - 122] Show the last 2 registered customers for follow-up.
select * from customers
order by customerid desc
limit 2;

-- Question - 123] Display each booking’s BookingID with TotalAmount using CONCAT.
select concat(Bookingid, ' ', Totalamount) as BIDTA from bookings;

-- Question - 124] Insert 5 staff members into the Staff table with their role, phone, and email.
insert into staff (FirstName, LastName, Role, Phone, Email)
values
('pankaj', 'Kho', 'Waiter', 898325956, 'pankajkho@gmail.in'),
('mayur', 'yen', 'Manager', 789899656, 'mayuryen@tcs.in'),
('rahul', 'sharma', 'Housekeeping', 8787878458, 'rahulsharma@infosys.in'),
('parag', 'Tiwari', 'Chef', 898325956, 'paragTiwa@yahoo.in'),
('rohit', 'kohli', 'Security', 7478794615, 'rohitkohli@gmail.in')
;

select * from staff
order by staffid desc;

-- Question - 125] Display the RoomType and Price of only Suite rooms.
select Roomid, Roomtype, Pricepernight from rooms
where Roomtype = 'Suite';

-- Question - 126] The admin wants to delete all payments linked to BookingID = 15.
start transaction;
Delete from Payments
where bookingID = 15;
rollback;
select * from payments;

-- Question - 127] Display all unique capacities in descending order.
select distinct capacity from rooms
order by capacity desc;

-- Question - 128] Show the first 4 rooms sorted alphabetically by RoomType.
select * from rooms
order by RoomType asc
limit 4;

-- Question - 129] The cashier wants a report of payments where Amount < ₹1500 for small transactions.
select * from payments
where Amount <1500;

-- Question - 130] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat (BookingID, ' - ', TotalAmount) as Bookings from bookings;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 131] Display the last 2 added rooms from the Rooms table.
select * from rooms
order by roomid desc
limit 2;

-- Question - 132] List all customers whose FirstName = 'Amit' AND City = 'Nagpur' for personal attention.
select FirstName , City from customers
where FirstName = 'Amit' and City = 'Nagpur';

-- Question - 133] Insert 5 new customer details into the Customers table.
Insert into Customers (FirstName, LastName, Email, Phone, City)
Values 
('Amit', 'Wagh', 'amitwagh@gmail.com', 9988478158, 'Pune'),
('Aarif', 'Khan', 'aarifkhan@yahoo.com',7897744552, 'Hyderbad'),
('Sanesh', 'Gawade', 'saneshgawade@gmail.com', 8794856565, 'Kolhapur'),
('Pranay', 'Patil', 'pranaypatil@infosys.com', 8965483565, 'Chandrapur'),
('Rakesh', 'wankhede', 'Rakeshwan@tcs.in', 9895894835, 'Delhi')
;
select * from customers
order by customerid desc;

-- Question - 134] Show staff full names combined into one column.
select concat(FIRSTNAME, ' ', LASTNAME )AS STAFFNAME FROM STAFF;

-- Question - 135] Show all room details separated by commas using CONCAT_WS.
select concat_ws(' | ', RoomID, RoomType, PricePerNight, Capacity)  as RoomDetails from rooms;

-- Question - 136] Display each customer’s name and phone number together using CONCAT.
select concat(FirstName, ' ', LastName, ' - ', Phone)as Customerinfo from customers;

-- Question - 137] Display all payment details in one line using CONCAT_WS.
select concat_ws(' | ', PaymentID, BookingID, PaymentDate, PaymentMethod, Amount) as PaymentsInfo from payments;

-- Question - 138] Show the last 2 bookings in the table.
select * from bookings
order by bookingid desc
limit 2;

-- Question - 139] List all payments ordered by PaymentDate.
select * from payments
order by PaymentDate;

-- Question - 140] Show the 2 highest payments received.
select Amount from payments
order by Amount desc
limit 2;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 141] The marketing team wants to check customers whose FirstName is 'Rahul' for a loyalty program.
select FirstName from customers
where Firstname = 'Rahul';

-- Question - 142] Display each PaymentID with its method using CONCAT.
Select concat(PaymentID, ' ', PaymentMethod) as PaymentsIDMethod from payments;

-- Question - 143] The operations team wants to list all PaymentMethods used more than 5 times.
select paymentMethod, Count(*) as UsageCount from payments
group by paymentMethod
having count(*) > 5; 

-- Question - 144] Show the 2 most expensive rooms for VIP guests.
select * from Rooms
order by PricePerNight desc
limit 2;

-- Question - 145] Show each room’s RoomType and Price using CONCAT_WS.
select concat_ws(' | ', RoomType, PricePerNight) as RoomPrice from rooms;

-- Question - 146] Display the first 3 staff alphabetically by their first names.
select Firstname from staff
order by firstname asc
limit 3;

-- Question - 147] List all bookings handled by StaffID = 2.
select * from bookings
where staffid =2;

-- Question - 148] The analytics team wants to find the city where average CustomerID is greater than 50.
select avg(Customerid), City from customers
group by city 
having avg(customerid) > 50;

-- Question - 149] The hotel wants to display the 2 most expensive rooms for VIP guests.
select * from rooms
order by PricePerNight  desc
limit 2;

-- Question - 150] Show all unique first names of customers for a duplicate check.
select distinct firstname from customers
order by Firstname asc;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 151] Show all unique roles in descending order.
select distinct role from staff
order by role desc;

-- Question - 152] Identify rooms whose Capacity is greater than the average Capacity of allrooms. (Rooms subquery)
select * from rooms
where capacity >   (select avg(capacity) from rooms);

-- Question - 153] Display all rooms by capacity in ascending order.
select * from rooms
order by capacity asc;

-- Question - 154] Display the first 4 payments only.
select * from payments
limit 4;

-- Question - 155] Show each payment’s ID, Method, Amount in one line.
select concat (PaymentID, ' ',  PaymentMethod, ' ', Amount )as PaymentsINFO from Payments;

-- Question - 156] List all bookings where TotalAmount > 5000.
select * from bookings
where TotalAmount > 5000;

-- Question - 157] Find all customers whose CustomerID is greater than the average CustomerID.(Customers subquery)
select * from Customers
where customerID > (select Avg(customerID) from customers);

-- Question - 158] The HR manager wants to see staff whose Role is not 'Chef' for rolereallocation.
select * from  staff
where role != 'chef' ;

-- Question - 159] The accounts team wants to check bookings where TotalAmount is greater than₹10,000.
select * from bookings
where TotalAmount > 10000;

-- Question - 160] Display each staff’s role with their full name.
select concat(FirstName, ' ', Lastname) as FullName, role from staff; 

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


-- Question - 161] List staff members who share the same Role. (Staff self join)
select s1.StaffID, concat(s1.Firstname, ' ', s1.lastname) as StaffName1, S1.Role, S2.Staffid, concat(s2.Firstname, ' ',  s2.lastname) as StaffName2, s2.Role from Staff s1
join staff s2
on S1.role = S2.role
and S1.staffid > s2.staffid;

-- Question - 162] Show Customer Name and Payment Amount by joining Customers, Bookings, and Payments.
select concat_ws(' ', c.FirstName, c.lastname) as CustomerName, P.Amount, b.bookingid from Customers c 
join  Bookings b
ON c.customerid = b.customerid 
join  Payments P
ON B.bookingid = P.bookingid;

#doubt!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-------------------------------------------------------------



-- Question - 163] Display all bookings where TotalAmount > 5000.
select * from bookings
where TotalAmount > 5000;

-- Question - 164] The front desk wants to see customers whose Phone starts with '98'.
select * from customers
where Phone like '98%';

-- Question - 165] Identify customers who live in the same city. (Customers self join)
select c1.customerID, concat_ws(' ', c1.Firstname, C1.lastname)as FullNameC1, C1.CIty, c2.customerID, concat_ws(' ', c2.Firstname, C2.lastname)as FullNameC2, c2.city from customers c1
join customers c2
on c1.city = c2.city and c1.customerId > c2.customeriD;

-- Question - 166] The operations manager wants to check bookings with CheckOutDate before '2023-12-31'.
select * from bookings
where CheckOutDate < '2023-12-31';

-- Question - 167] Display all unique StaffIDs from the bookings.
select distinct staffid from bookings;

-- Question - 168] Create a VIEW OnlinePayments showing all payments made by PaymentMethod = 'Online'.
create view OnlinePayments as
select * from Payments
where PaymentMethod = 'Online';

select * from OnlinePayments;

-- Question - 169] Display all unique payment methods in descending order.
select distinct PaymentMethod from Payments
order by PaymentMethod desc;

-- Question - 170] Display each payment’s ID with Amount using CONCAT.
select concat_ws(" , ", PaymentID, Amount) as AmountID from Payments;


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 171] Show all unique RoomIDs in descending order.
select distinct RoomID from rooms
order by roomid desc;

-- Question - 172] The analytics team wants to list all cities where maximum CustomerID is more than 100.
select CIty, Max(customerid) from customers
group by city
having max(customerid) > 100;

-- Question - 173] List staff emails ordered by their roles.
select Email, role from staff
order by role asc;

-- Question - 174] Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)
select * from bookings
where TotalAmount > (
					select avg(TotalAmount)	from bookings);

-- Question - 175] Show all rooms where PricePerNight > ₹5000 for premium customer recommendations.
select * from rooms
where PricePerNight > 5000;

-- Question - 176] Show all unique capacities in descending order.
select distinct capacity from rooms
order by capacity desc;

-- Question - 177] Display the first 4 rooms sorted alphabetically by RoomType.
select * from rooms
order by roomtype
limit 4;

-- Question - 178] Show all unique staff first names.
select distinct firstname from staff;

-- Question - 179] Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)
select * from rooms
where pricepernight > (
						select max(pricepernight) from rooms
									where capacity = 2);
                                    
-- Question - 180] Show all unique cities in descending order from the Customers table.
select distinct city from customers
order by city desc;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 181] List all bookings where TotalAmount > 5000.
select * from bookings
where TotalAmount > 5000;

-- Question - 182] Show PaymentID, Customer Name, and BookingID for payments made using'Credit Card'.
select p.PaymentID, Concat(c.firstname, c.lastname) as CustomerName, b.bookingID, p.PaymentMethod from payments p
join bookings b
on p.bookingID = b.bookingid
join customers c
on b.customerid = c.customerid
where p.PaymentMethod = 'Credit card';

-- Question - 183] Display each booking’s BookingID with TotalAmount using CONCAT.
select concat(Bookingid, ' ', TotalAmount) as AmountID from bookings;

-- Question - 184] Show all bookings handled by StaffID = 2.
select * from bookings
where staffid = 2;

-- Question - 185] Display the last 2 added rooms from the Rooms table.
select * from rooms
order by roomid desc
limit 2;

-- Question - 186] List all rooms where capacity is greater than 2.
select * from rooms
where capacity > 2;

-- Question - 187] Display the last 2 staff members from the Staff table.
select * from staff
order by staffid desc
limit 2;

-- Question - 188] Show all unique roles available in the hotel.
select distinct role from staff;

-- Question - 189] Display the last 2 payments.
select * from payments
order by paymentid desc
limit 2;

-- Question - 190] The manager wants to see bookings where CustomerID IN (2,4,6,8) to track repeat guests.
select * from bookings
where customerid in (2,4,6,8);

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Question - 191] Show all unique first names of customers for a duplicate check.
select distinct firstname from customers;

-- Question - 192] Display all bookings where TotalAmount > 5000.
select * from bookings
where totalamount> 5000;

-- Question - 193] The admin wants to delete all payments where Amount < 1000.
select * from payments
where amount < 1000;

set sql_safe_updates = 0;

start transaction;

delete from payments
where amount < 1000;

rollback;

-- Question - 194] Display all unique RoomIDs in descending order.
select distinct roomid from rooms
order by roomid desc;

-- Question - 195] List customers who made more than 5 bookings.
select c.customerID, concat_ws(' ', c.firstname, c.lastname) as CustomerName, COUNT(b.BookingID) AS TotalBookings from customers c
join bookings b
on c.customerid = b.customerid
group by c.customerid, c.firstname, c.lastname
having COUNT(b.BookingID) > 5;

-- Question - 196] Display all rooms by capacity in ascending order.
select * from rooms
order by capacity asc;

-- Question - 197] Show each booking’s BookingID with TotalAmount using CONCAT.
select concat_ws(' ', BookingID, Totalamount) as BookingAmount from bookings;

-- Question - 198] List all staff working as Managers.
select * from staff
where role = 'Manager';

-- Question - 199] Show customers whose FirstName length > 5 characters for a name-patternstudy.
select firstname from customers
where length(firstname) > 5;

-- Question - 200] Display all unique capacities in descending order.
select distinct capacity from rooms
order by capacity desc;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-- END;
-------------------------------------------------------------------------------------




