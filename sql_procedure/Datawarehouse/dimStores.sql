use BIDW
go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));





	merge [dim].[stores] as t
	using 
	(select 
	[store_id] ,
	[store_name] ,
	[phone] ,
	[email] ,
	[street] ,
	[city] ,
	[state] ,
	[zip_code] 
	from 
[sales].[stores]
	) as s
	on s.[store_id]=t.[store_id]

	when matched  then update set 
	t.[store_name]=s.[store_name],
	t.[phone] =s.[phone],
	t.[email] =s.[email],
	t.[street] =s.[street],
	t.[city] =s.[city],
	t.[state] =s.[state],
	t.[zip_code] =s.[zip_code]

	when not matched by target 
	then insert 
	([store_id] ,
	[store_name] ,
	[phone] ,
	[email] ,
	[street] ,
	[city] ,
	[state] ,
	[zip_code] 
	)
	values 
		(s.[store_id] ,
	s.[store_name] ,
	s.[phone] ,
	s.[email] ,
	s.[street] ,
	s.[city] ,
	s.[state] ,
	s.[zip_code] 
	)

	

output $action into @SummaryOfChanges;

	
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 


	--select * from dim.stores