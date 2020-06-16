USE [BIDW]
GO



--Truncate Table  [dim].[brands]
	
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

----Load production brand to dim brand 

	merge [dim].[brands] as t
	using  
	(select brand_id,brand_name from [production].[brands])
	as s
	on (t.brand_id=t.brand_id )
	when matched 
	then  update set t.brand_name=s.brand_name
	when not matched by target 
	then insert (brand_id,brand_name)  values(s.brand_id,brand_name) 



       output $action into @SummaryOfChanges;

	
	--log 

	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 


	

