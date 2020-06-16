


Drop table if exists [dim].[brands]
create table [dim].[brands]
( brand_dimKey int identity (1,1) not null,
[brand_id] [int]  NOT NULL,
	[brand_name] [varchar](255) NOT NULL
	)
go 


drop table if exists dim.categories
create table  dim.categories
(category_dimKey int identity (1,1) not null,
category_id int not null,
category_name varchar (255)
) 
go 


drop table if exists [dim].[customers] 
create table [dim].[customers] 

(     customers_dimkey int identity (1,1) not null, 
	[customer_id] [int]  NOT NULL,
	[first_name] [varchar](255) NOT NULL,
	[last_name] [varchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[email] [varchar](255) NOT NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](25) NULL,
	[zip_code] [varchar](5) NULL

	)
	go  


	drop table if exists [dim].[products]
CREATE TABLE [dim].[products](
	products_dimkey int identity (1,1) not null,
	[product_id] [int] NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[brand_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[model_year] [smallint] NOT NULL,
	[list_price] [decimal](10, 2) NOT NULL
	)
	go 


	drop table if exists [dim].[staffs] 
	create table [dim].[staffs] (
	staffs_dimkey int identity (1,1) not null, 
	[staff_id] [int]  NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[active] [tinyint] NOT NULL,
	[store_id] [int] NOT NULL,
	[manager_id] [int] NULL
	)



Drop table if exists [dim ].[stores] 
Create table  [dim].[stores] (
     stores_dimKey int identity (1,1) not null , 
	[store_id] [int]  NOT NULL,
	[store_name] [varchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[email] [varchar](255) NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[state] [varchar](10) NULL,
	[zip_code] [varchar](5) NULL)
	go


	drop table if exists fact.fact_order 
	create table fact.fact_order 
( [order_id] int not null ,
customers_dimkey int not null ,
products_dimkey int not null,
stores_dimKey int not null,
staffs_dimkey int not null,
[order_status] int not null,
[item_id] int not null,
[quantity] int not null,
[list_price] int not null,
[discount] int not null,
[order_date] date,
[required_date] date,
[shipped_date]  date
);