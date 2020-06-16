use BIDW
go  

create table  dim.[stocks]
(stocks_dimKey int identity (1,1) not null,
category_id int not null,
category_name varchar (255)
) 
go 



DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

Merge 

output $action into @SummaryOfChanges;

	
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 
