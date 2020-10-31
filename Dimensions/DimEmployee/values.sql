-- insertar valores desde NorthwindDB
insert into DimEmployee
   select 
		e.EmployeeID, 
		e.FirstName + ' ' + e.LastName, 
		e.City, 
		e.Country, 
		e.Region,
		e.HireDate
   from Northwind.dbo.Employees e;