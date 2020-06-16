
use BIDW
go 



DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

Merge [dim].[customers] as t
using 
(select [customer_id],
	[first_name],
	[last_name] ,
	[phone] ,
	[email],
	[street] ,
	[city] ,
	[state] ,
	[zip_code] from [sales].[customers]
	) as s 
	on s.[customer_id]=t.[customer_id]

	when matched 
	then update set
	t.[first_name]=s.[first_name],
	t.[last_name] =s.[last_name],
	t.[phone] =s.[phone],
	t.[email]=s.[email],
	t.[street]= s.[street],
	t.[city] =s.[city],
	t.[state] =s.[state],
	t.[zip_code] =s.[zip_code]

	when not matched by target
	then insert 
	([customer_id],[first_name],
	[last_name] ,
	[phone] ,
	[email],
	[street] ,
	[city] ,
	[state] ,
	[zip_code] 
	)
	values 
	(s.[customer_id],
	s.[first_name],
	s.[last_name] ,
	s.[phone] ,
	s.[email],
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


	--select count(*) from dim.customers

	--select count(*)  from sales.customers