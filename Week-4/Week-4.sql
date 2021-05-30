/*
1.Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. Instead, use a subquery in a WHERE clause that uses the IN keyword.
SELECT DISTINCT CategoryName
FROM Categories c JOIN Products p
ON c.CategoryID = p.CategoryID
ORDER BY CategoryName

2.Write a SELECT statement that answers this question: Which products have a list price that’s greater than the average list price for all products?
Return the ProductName and ListPrice columns for each product.
Sort the results by the ListPrice column in descending sequence.

3.Write a SELECT statement that returns the CategoryName column from the Categories table.
Return one row for each category that has never been assigned to any product in the Products table. 
To do that, use a subquery introduced with the NOT EXISTS operator.
 
1.Write an INSERT statement that adds this row to the Categories table:
CategoryName:   Brass
Code the INSERT statement so SQL Server automatically generates the value for the CategoryID column.

2.Write an UPDATE statement that modifies the row you just added to the Categories table. This statement should change the CategoryName column to “Woodwinds”, and it should use the CategoryID column to identify the row.
3.Write a DELETE statement that deletes the row you added to the Categories table in exercise 1. This statement should use the CategoryID column to identify the row.
 

1.Write a SELECT statement that returns these columns from the Products table:
The ListPrice column
A column that uses the CAST function to return the ListPrice column with 1 digit to the right of the decimal point
A column that uses the CONVERT function to return the ListPrice column as an integer
A column that uses the CAST function to return the ListPrice column as an integer

2. Write a SELECT statement that returns these columns from the Products table:
The DateAdded column
A column that uses the CAST function to return the DateAdded column with its date only (year, month, and day)
A column that uses the CAST function to return the DateAdded column with its full time only (hour, minutes, seconds, and milliseconds)
A column that uses the CAST function to return the DateAdded column with just the month and day-- 
*/
USE MyGuitarShop;
-- 1
SELECT DISTINCT CategoryName 
FROM Categories
WHERE CategoryID 
IN (SELECT CategoryID FROM Products)
ORDER BY CategoryName ;
-- 2
SELECT ProductName, ListPrice 
FROM Products
WHERE ListPrice >
    (SELECT AVG(ListPrice)
	 FROM Products
	 WHERE ListPrice <> 0)
ORDER BY ListPrice DESC;
--3

SELECT CategoryName 
FROM Categories 
WHERE NOT EXISTS 
    (SELECT *
	 FROM Products
     WHERE Products.CategoryID = Categories.CategoryID);

-- ******************************************************************************** 
-- 1
INSERT INTO Categories (CategoryName)
VALUES ('Brass');

--2
UPDATE Categories
SET CategoryName = 'Woodwinds'
WHERE CategoryID = 5;
--3 
DELEte FROM Categories
WHERE CategoryID = 5;

-- ******************************************************************************
-- 1
SELECT ListPrice,
	CAST(ListPrice AS decimal(18, 1)) AS PriceFormat,
	CONVERT(int, ListPrice) AS PriceConvert,
	CAST(ListPrice AS int) AS PriceCast
FROM Products;

-- 2
SELECT  DateAdded,
	FORMAT(CAST(DateAdded AS date), 'mm/dd/yyyy') AS AddedDate,
	CAST(DateAdded AS time(0)) AS AddedTime,
	FORMAT(CAST(DateAdded AS date), 'M') AS AddedChar
FROM Products;

