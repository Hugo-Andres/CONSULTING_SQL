select * from Sales

--Veremos el promedio de ingresos por ventas por país
select Country, 
       avg(Revenue) as AVG_Revenue
from Sales
group by Country

--Veremos el promedio de ingresos por ventas por país de mayor a menor ganancias.
select Country, 
       avg(Revenue) as AVG_Revenue
from Sales
group by Country
order by avg(Revenue) desc

-- Veremos cuáles fueron los meses con mayor y menor ganancia por País
select Country,
	   max(Month) as max_month,
	   min(Month) as min_month
from Sales
group by Country

-- Veremos el mes de mayor ganancia por País y cuál fue la ganancia
select Country, 
       max(Month) as MAX_Month,
	   max(Revenue) as MAX_Revenue
from Sales
group by Country
order by max(Revenue) desc

--Veremos el mes de menor ganancia por País y cuál fue la ganancia mínima
select Country, 
       min(Month) as MIN_Month,
	   min(Revenue) as MIN_Revenue
from Sales
group by Country
order by min(Revenue) desc


-- ¿Qué Productos se venden?
select distinct(Product)
from Sales


--Veremos el mayor producto pedido y el menor producto pedido por país.
select Country,
       max(Product) as MAX_PRODUCT,
	   max(Order_Quantity) as MAX_Order,
	   min(Product) as MIN_Product,
	   min(Order_Quantity) as MIN_Order
from Sales
group by Country


--Veremos el total de ventas por Producto
select Product,
       COUNT(*) AS cantidad
from Sales
group by Product
order by cantidad desc


--Veremos la cantidad de ventas por Producto por País
select Country,
       Product,
       COUNT(*) AS cantidad,
	   AVG(Customer_Age)
from Sales
group by Country,
         Product
order by Country,
         Product desc

/* Crearemos un Store Procedure (Procedimiento Almacenado), 

el cual nos alojará es una tabla el País, Producto y Cantidad de ventas por producto */

CREATE PROCEDURE ETL_Units_For_Country
AS
CREATE TABLE ETL_Products (
Country varchar (50),
Product varchar (50),
Units int
)

INSERT INTO ETL_Products
SELECT Country,
       Product,
	   COUNT(*)
FROM Sales
GROUP BY Country,
         Product
ORDER BY Country,
         Product desc   

SELECT * FROM ETL_Products

EXEC ETL_Units_For_Country

--DROP PROCEDURE Units_For_Country
--GO