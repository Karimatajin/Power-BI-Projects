select * from product_data; 
select * from product_sales;
select * from discount_data; 

--developing our SQL query that we gonna import into Power Bi
with cte as (
select 
a.[Product],
a.[Category],
a.[Cost_Price],
a.[Sale_Price],
a.[Brand],
a.[Description],
a.[Image_url],
p.[Date],
p.[Customer_Type],
p.[Country],
p.[Discount_Band],
p.[Units_Sold],
(sale_price*Units_Sold) as revenue, 
(cost_price*Units_Sold) as total_cost, 
format(date, 'MMMMM') as month, 
format(date, 'yyyy') as year 
from Product_data a 
inner join product_sales p 
on a.Product_ID = p.Product)

select * ,
(1-discount*1.0/100)* revenue as discount_revenue 
from cte 
inner join [dbo].[discount_data] d
on cte.month = d.Month