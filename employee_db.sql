---1. Fetch all employees and display name in uppercase

SELECT UPPER(EmpFName) AS EmpName
FROM [dbo].['Employee Info$']

---2. Fetch the number of employees working in the HR department

SELECT COUNT(EmpID) AS DeptCount
FROM [dbo].['Employee Info$']
WHERE Department = 'HR'

---3. Get the current date

SELECT GETDATE()

SELECT CONVERT(VARCHAR(10), GETDATE(), 103) AS [Today's Date]

---4. Fetch first 4 characters from EmpLName

SELECT LEFT(EmpLname, 4) AS EmpName
FROM [dbo].['Employee Info$']

---5. Fetch strings before brackets from Address

SELECT LEFT(Address, CHARINDEX('(', Address) - 1) AS PlaceName
FROM [dbo].['Employee Info$']

---6. Create new table from another one

SELECT *
INTO [New Employee Info Table]
FROM [dbo].['Employee Info$']

SELECT *
FROM [dbo].[New Employee Info Table]

---7. Find all employees who earn between 50000 and 100000

SELECT EmpFname, EmpLname, Salary
FROM [dbo].[New Employee Info Table] AS EI
JOIN [dbo].['Employee position$'] AS EP
 ON EI.EmpID = EP.EmpID
WHERE Salary BETWEEN 50000 AND 100000

---8. Find Employees with names starting with 'S'

SELECT EmpFname, EmpLname
FROM [dbo].[New Employee Info Table]
WHERE EmpFname LIKE 'S%'

---9. Fetch Top N records

SELECT TOP 3 *
FROM [dbo].[New Employee Info Table]

---10. Retrieve Firstname and Lastname as one record

SELECT EmpFname || ' ' || EmpLname AS Fullname
FROM [dbo].[New Employee Info Table]

---11. Find the grouped number of employees within a date range

SELECT COUNT(EmpID) AS MillenialCount, Gender
FROM [dbo].['Employee Info$']
WHERE DOB BETWEEN '1970-05-02' AND '1995-12-31'
GROUP BY Gender

---12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

SELECT *
FROM [dbo].[New Employee Info Table]
ORDER BY [EmpLname] DESC, [Department] ASC

---13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

SELECT *
FROM [dbo].[New Employee Info Table]
WHERE [EmpLname] LIKE '____A'

---14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

SELECT *
FROM [dbo].[New Employee Info Table]
WHERE [EmpFname] NOT IN ('Sanjay', 'Sonia')

---15. Write a query to fetch details of employees with the address as “DELHI(DEL)”

SELECT *
FROM [dbo].[New Employee Info Table]
WHERE [Address] = 'DELHI(DEL)'

---16. Write a query to fetch all employees who also hold the managerial position.

SELECT *
FROM [dbo].[New Employee Info Table] AS ET
JOIN [dbo].['Employee position$'] AS EP
  ON ET.EmpID = EP.EmpID
WHERE [EmpPosition] = 'Manager'

---17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order

SELECT [Department], COUNT([Department]) AS DepartmentCount
FROM [dbo].[New Employee Info Table]
GROUP BY [Department]
ORDER BY DepartmentCount ASC

---18. Write a query to fecth Male employees in HR department

SELECT *
FROM [dbo].[New Employee Info Table]
WHERE [Gender] = 'M' AND [Department] = 'HR'

---19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table

SELECT *
FROM [dbo].[New Employee Info Table] AS ET
JOIN [dbo].['Employee position$'] AS EP
  ON ET.EmpID = EP.EmpID
WHERE EP.[DateOfJoining] IS NOT NULL

---20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table

;WITH Temporary_Table AS (
    SELECT
        ET.EmpID,
        ET.EmpFname,
        EP.Salary,
        RANK() OVER (ORDER BY EP.Salary DESC) AS Desc_Rank,
        RANK() OVER (ORDER BY EP.Salary ASC) AS Asc_Rank
    FROM [dbo].[New Employee Info Table] AS ET
    JOIN [dbo].['Employee position$'] AS EP
        ON ET.EmpID = EP.EmpID
)

SELECT *
FROM Temporary_Table
WHERE Desc_Rank <= 2 OR Asc_Rank <= 2;
