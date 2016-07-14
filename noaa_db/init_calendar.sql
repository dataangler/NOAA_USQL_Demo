/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

---------------------------------------------------------------------------------
-- Pre-load station and airport tables using SSIS
-- Then, run (or re-run) this init script.
---------------------------------------------------------------------------------


begin tran;

	truncate table dbo.calendar;

	with cte ([date])
	as (
		select DATEFROMPARTS(2010,1,1)
		union all
		select dateadd(day,1,[date])
		from cte
		where [date] < DATEFROMPARTS(2018,1,1)
	)

	insert dbo.calendar (
		 [datekey]
		,[date]
		,[year]
		,[month]
		,[day]
		,[day_of_year]
		,[day_of_week]
		,[quarter]
		,[week]
		,[month_name]
		,[weekday]
	)
	select 
		 convert(int, convert(varchar(8), [date], 112)) as [datekey]
		,[date]
		,datepart(year, [date]) as [year]
		,datepart(month, [date]) as [month]
		,datepart(day, [date]) as [day]
		,dateparT(dayofyear, [date]) as [day_of_year]
		,datepart(weekday, [date]) as [day_of_week]
		,datepart(quarter, [date]) as [quarter]
		,datepart(week, [date]) as [week]
		,datename(month, [date]) as [month_name]
		,datename(weekday, [date]) as [weekday]
	from cte
	option (maxrecursion 32767)

commit tran;
