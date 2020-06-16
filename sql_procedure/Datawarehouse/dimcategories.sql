
use BIDW
go  




DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

Merge dim.categories as t 
using 
( select [category_id],[category_name] from [production].[categories])  as s 
on s.[category_id]=t.[category_id]

when matched 
then update set t.[category_name]=s.[category_name]

when not matched by target 
then  insert  ([category_id],[category_name]) 
values (s.[category_id],s.[category_name]) 


output $action into @SummaryOfChanges;

	
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 

	--select * from dim.categories