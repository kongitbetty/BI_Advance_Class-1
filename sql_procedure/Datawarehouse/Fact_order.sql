use BIDW
go 





with cte_fact 
as 
(select 
ord.[order_id],
ord.[customer_id],
ord.[order_status],
ord.[store_id],
ord.[staff_id],
oi.[item_id],
oi.[product_id],
oi.[quantity],
oi.[list_price],
oi.[discount],
ord.[order_date],
ord.[required_date],
ord.[shipped_date]
from 
[sales].[orders] ord
inner join [sales].[order_items] oi on ord.order_id=oi.order_id
) 

insert into fact.fact_order 


( [order_id]  ,
customers_dimkey  ,
products_dimkey ,
stores_dimKey ,
staffs_dimkey ,
[order_status] ,
[item_id] ,
[quantity] ,
[list_price] ,
[discount] ,
[order_date] ,
[required_date] ,
[shipped_date] 
)

select 
f.[order_id],
cust.customers_dimkey,
dp.products_dimkey,
st.stores_dimKey,
staf.staffs_dimkey,
f.[order_status],
f.[item_id],
f.[quantity],
f.[list_price],
f.[discount],
f.[order_date],
f.[required_date],
f.[shipped_date]

from cte_fact f
inner join [dim].[products] dp on dp.product_id=f.product_id
inner join [dim].[brands] db on db.brand_id=dp.brand_id
inner join [dim].[categories] dc on dc.category_id=dp.category_id
inner join [dim].[customers] cust on cust.customer_id=f.customer_id
inner join [dim].[staffs] staf on staf.staff_id=f.staff_id
inner join [dim].[stores] st on st.store_id=f.store_id




