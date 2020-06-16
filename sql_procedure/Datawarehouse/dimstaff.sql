
use BIDW
go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));




	merge [dim].[staffs] as t
	using 
	(
	select 
	[staff_id],
	[first_name] ,
	[last_name] ,
	[email] ,
	[phone],
	[active] ,
	[store_id] ,
	[manager_id] 
	
	from 
[sales].[staffs]

) as s 

on s.[staff_id]=t.[staff_id]

when matched then update set 

	t.[first_name]=s.[first_name] ,
	t.[last_name] =s.[last_name],
	t.[email] =s.[email],
	t.[phone]=s.[phone],
	t.[active] =s.[active],
	t.[store_id] =s.[store_id],
	t.[manager_id]= s.[manager_id]

when not matched by target
then insert 
(
[staff_id],
	[first_name] ,
	[last_name] ,
	[email] ,
	[phone],
	[active] ,
	[store_id] ,
	[manager_id] 

	) values 
	(
	s.[staff_id],
	s.[first_name] ,
	s.[last_name] ,
	s.[email] ,
	s.[phone],
	s.[active] ,
	s.[store_id] ,
	s.[manager_id] 
	)






output $action into @SummaryOfChanges;

	
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 

	select * from dim.staffs



