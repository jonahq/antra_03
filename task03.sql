--1
CREATE VIEW view_product_order_que AS 
SELECT p.ProductName, SUM(od.Quantity) AS count FROM Products p LEFT JOIN [Order Details] od ON od.ProductID = p.ProductID
GROUP BY od.ProductID, p.ProductName;
GO
SELECT * FROM view_product_order_que
GO

--2
CREATE PROC sp_product_order_quantity_que
@pid INT, @quan INT OUT
AS
BEGIN
SELECT @quan = SUM(od.Quantity) FROM [Order Details] od 
WHERE od.ProductID = @pid
END
GO

BEGIN
DECLARE @out2 INT
EXEC sp_product_order_quantity_que 14, @out2 OUT
SELECT @out2
END

--3
DROP PROC sp_product_order_city_que
GO
CREATE PROC sp_product_order_city_que
@pname VARCHAR(50)
AS
BEGIN
SELECT TOP 5 o.ShipCity, SUM(od.Quantity) FROM Products p JOIN [Order Details] od ON od.ProductID = p.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.ProductName = @pname
GROUP BY o.ShipCity, od.Quantity
ORDER BY SUM(od.Quantity) DESC
END

BEGIN
EXEC sp_product_order_city_que 'Sasquatch Ale'
END

--4
CREATE TABLE city_que(ID INT, City Varchar(20))
CREATE TABLE people_que(ID INT, Name Varchar(20), City INT)
INSERT INTO city_que VALUES(1, 'Seattle')
INSERT INTO city_que VALUES(2, 'Green Bay')

INSERT INTO people_que VALUES(1, 'Aaron Rodgers', 2)
INSERT INTO people_que VALUES(2, 'Russel Wilson', 1)
INSERT INTO people_que VALUES(3, 'Jody Nelson', 2)

DELETE FROM city_que WHERE City = 'Seattle' 
INSERT INTO city_que VALUES(3, 'Madison')

UPDATE people_que SET City = 3 WHERE City = 1

GO
CREATE VIEW Packers_que AS
SELECT p.Name FROM people_que p, city_que c WHERE p.City = c.ID AND c.City = 'Green Bay'
GO

SELECT * FROM Packers_que

DROP TABLE city_que
DROP TABLE people_que

DROP VIEW Packers_que

--5
GO
CREATE PROC sp_birthday
AS
BEGIN
CREATE TABLE birthday_employees_que(employeeName VarChar(30))
INSERT INTO birthday_employees_que SELECT e.FirstName + ' ' + e.LastName FROM Employees e
WHERE MONTH(e.BirthDate) = 2
END

DROP TABLE birthday_employees_que

--6
--use left outer join. If they are same, there should be no value returned from left outer join. 