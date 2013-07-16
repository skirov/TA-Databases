CREATE PROC usp_GetTotalIncome(@supplierName nvarchar, @startDate date, @endDate date)
AS
	SELECT SUM(od.UnitPrice) FROM [Order Details] od
		JOIN Orders o ON od.OrderID = o.OrderID
		JOIN Products p ON od.ProductID = p.ProductID
		JOIN Suppliers s ON p.SupplierID = s.SupplierID
	WHERE (o.ShippedDate BETWEEN @startDate AND @endDate) AND s.CompanyName = @supplierName
GO