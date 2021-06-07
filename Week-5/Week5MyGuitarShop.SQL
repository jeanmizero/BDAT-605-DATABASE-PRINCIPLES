/*Use the virtual desktop (launch.maryville.edu) to access SQL Server. Visit Accessing the eLumin Virtual Machine (VM)for further assistance.

Write scripts for My Guitar Shop. Be sure to submit your answers in one Notepad file with either a .txt or .sql extension. Identify each solution with part and exercise number.

Part A

Write a SELECT statement that returns these columns from the Products table:
The ListPrice column
The DiscountPercent column
A column named DiscountAmount that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result to 2 decimal places
Write a SELECT statement that returns these columns from the Orders table:
The OrderDate column
A column that returns the four-digit year that’s stored in the OrderDate column
A column that returns only the day of the month that’s stored in the OrderDate column.
A column that returns the result from adding thirty days to the OrderDate column.
Write a SELECT statement that returns these columns from the Orders table:
The CardNumber column
The length of the CardNumber column
The last four digits of the CardNumber column
When you get that working right, add the column that follows to the result set. This is more difficult because the column requires the use of functions within functions.
A column that displays the last four digits of the CardNumber column in this format: XXXX-XXXX-XXXX-1234. In other words, use Xs for the first 12 digits of the card number and actual numbers for the last four digits of the number.
 

Part B

Create a view named CustomerAddresses that shows the shipping and billing addresses for each customer in the MyGuitarShop database.
This view should return these columns from the Customers table: CustomerID, EmailAddress, LastName and FirstName.
This view should return these columns from the Addresses table: BillLine1, BillLine2, BillCity, BillState, BillZip, ShipLine1, ShipLine2, ShipCity, ShipState, and ShipZip.
Use the BillingAddressID and ShippingAddressID columns in the Customers table to determine which addresses are billing addresses and which are shipping addresses.
HINT: You can use two JOIN clauses to join the Addresses table to Customers table twice (once for each type of address).
Write a SELECT statement that returns these columns from the CustomerAddresses view that you created in exercise 1: CustomerID, LastName, FirstName, BillLine1
 

Part C

Write one Stored Procedure based on the MyGuitarShop database.
Write one function based on the MyGuitarShop database.


*/

-- Part A

-- 1
USE MyGuitarShop;

SELECT ListPrice,DiscountPercent,
ROUND(((DiscountPercent / 100) * ListPrice), 2) AS DiscountAmount
FROM Products
ORDER BY ProductName;

-- 2
USE MyGuitarShop;

SELECT OrderDate,
YEAR(OrderDate) AS OrderYear,
DAY(OrderDate) AS DayOnly,
DATEADD(DAY, 30, OrderDate) AS DueDate
FROM Orders;

-- 3
USE MyGuitarShop;

SELECT CardNumber,
LEN(CardNumber) AS CardNumberLegnth,
RIGHT(CardNumber, 4) AS LastFourDigits,
'XXXX-XXXX-XXXX-' + RIGHT(CardNumber, 4) AS FormattedNumber
FROM Orders;

-- Part B
-- 1
USE MyGuitarShop;

CREATE VIEW CustomerAddresses AS
SELECT c.CustomerID, EmailAddress, LastName, FirstName, 
    ba.Line1 AS BillLine1, ba.Line2 AS BillLine2, 
    ba.City AS BillCity, ba.State AS BillState, ba.ZipCode AS BillZip, 
    sa.Line1 AS ShipLine1, sa.Line2 AS ShipLine2, 
    sa.City AS ShipCity, sa.State AS ShipState, sa.ZipCode AS ShipZip 
FROM Customers c 
    JOIN Addresses ba ON c.BillingAddressID  = ba.AddressID
    JOIN Addresses sa ON c.ShippingAddressID = sa.AddressID;

--SELECT *FROM CustomerAddresses;

-- 2
SELECT CustomerID, LastName, FirstName, BillLine1
FROM CustomerAddresses;


-- Part C
-- 1
USE MyGuitarShop;
GO

CREATE PROC spCustomers_Addresses_GetAll AS

SELECT FirstName, LastName,Line1,Line2,City,State,ZipCode,Phone
FROM Addresses JOIN Customers
        ON Addresses.CustomerID = Customers.CustomerID
ORDER BY FirstName, LastName;

-- Test
EXEC spCustomers_Addresses_GetAll;

-- 2
USE MyGuitarShop;
GO

CREATE FUNCTION fnUpperFirstName
	(@UPPER varchar(60) )

RETURNS TABLE 
AS
RETURN 
	SELECT *
	FROM Customers
	WHERE UPPER(FirstName) = @UPPER;

GO
-- Test
SELECT * FROM dbo.fnUpperFirstName('F');