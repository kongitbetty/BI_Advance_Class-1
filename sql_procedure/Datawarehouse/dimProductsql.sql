use BIDW
go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));


	

	merge [dim].[products] as t
	using 
	( select [product_id] ,
	[product_name] ,
	[brand_id] ,
	[category_id],
	[model_year],
	[list_price] from [production].[products]
	) as s
	on s.[product_id]=t.[product_id]
	when matched Then 
	update set 
	t.[product_name] =s.[product_name],
	t.[brand_id] =s.[brand_id],
	t.[category_id]=s.[category_id],
	t.[model_year]=s.[model_year],
	t.[list_price]=s.[list_price]


	when not matched by target 
	then insert ([product_id] ,
	[product_name] ,
	[brand_id] ,
	[category_id],
	[model_year],
	[list_price])
	values 
	(
	s.[product_id] ,
	s.[product_name] ,
	s.[brand_id] ,
	s.[category_id],
	s.[model_year],
	s.[list_price])

output $action into @SummaryOfChanges;

	
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 





	