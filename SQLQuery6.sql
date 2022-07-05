/*SELECT DISTINCT Title, CompanyName, AddressType, City, StateProvince, CountryRegion, OrderQty, UnitPrice, UnitPriceDiscount
INTO Sales_Area_orders
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.Address cd ON cd.AddressID = ca.AddressID
INNER JOIN SalesLT.SalesOrderHeader sh ON c.CustomerID = sh.CustomerID
INNER JOIN SalesLT.SalesOrderDetail sd ON sh.SalesOrderID = sd.SalesOrderID */


/* add new column with the total price*/
--ALTER TABLE dbo.Sales_Area_orders ADD TotalPrice AS (OrderQty * UnitPrice) *(1-UnitPriceDiscount);

/* The mean, minimum, maximum and total sales orders by country*/
SELECT DISTINCT CountryRegion, 
       AVG(TotalPrice) OVER(PARTITION BY CountryRegion) AS AvgOrderAmount, 
       MIN(TotalPrice) OVER(PARTITION BY CountryRegion) AS MinOrderAmount,
	   MAX(TotalPrice) OVER(PARTITION BY CountryRegion) AS MaxOrderAmount,
       SUM(TotalPrice) OVER(PARTITION BY CountryRegion) TotalOrderAmount
FROM dbo.Sales_Area_orders

/* The mean, minimum, maximum and total sales orders by State*/
SELECT DISTINCT StateProvince, 
       AVG(TotalPrice) OVER(PARTITION BY StateProvince) AS AvgOrderAmount, 
       MIN(TotalPrice) OVER(PARTITION BY StateProvince) AS MinOrderAmount,
	   MAX(TotalPrice) OVER(PARTITION BY StateProvince) AS MaxOrderAmount,
       SUM(TotalPrice) OVER(PARTITION BY StateProvince) TotalOrderAmount
FROM dbo.Sales_Area_orders

/* The mean, minimum, maximum and total sales orders by city name */
SELECT DISTINCT City, 
       AVG(TotalPrice) OVER(PARTITION BY City) AS AvgOrderAmount, 
       MIN(TotalPrice) OVER(PARTITION BY City) AS MinOrderAmount,
	   MAX(TotalPrice) OVER(PARTITION BY City) AS MaxOrderAmount,
       SUM(TotalPrice) OVER(PARTITION BY City) TotalOrderAmount
FROM dbo.Sales_Area_orders

/* The mean, minimum, maximum and total sales orders by company */
SELECT DISTINCT CompanyName, 
       AVG(TotalPrice) OVER(PARTITION BY CompanyName) AS AvgOrderAmount, 
       MIN(TotalPrice) OVER(PARTITION BY CompanyName) AS MinOrderAmount,
	   MAX(TotalPrice) OVER(PARTITION BY CompanyName) AS MaxOrderAmount,
       SUM(TotalPrice) OVER(PARTITION BY CompanyName) TotalOrderAmount
FROM dbo.Sales_Area_orders
