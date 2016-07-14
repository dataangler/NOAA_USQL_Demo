CREATE TABLE [dbo].[calendar] (
    [datekey]     INT           NOT NULL,
    [date]        DATE          NOT NULL,
    [year]        INT           NOT NULL,
    [month]       INT           NOT NULL,
    [day]         INT           NOT NULL,
    [day_of_year] INT           NOT NULL,
    [day_of_week] INT           NOT NULL,
    [quarter]     INT           NOT NULL,
    [week]        INT           NOT NULL,
    [month_name]  NVARCHAR (30) NOT NULL,
    [weekday]     NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_Calendar] PRIMARY KEY CLUSTERED ([datekey] ASC)
);

