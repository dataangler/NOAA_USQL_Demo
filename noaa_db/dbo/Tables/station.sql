CREATE TABLE [dbo].[station] (
    [id]           VARCHAR (11) NOT NULL,
    [latitude]     FLOAT (53)   NULL,
    [longitude]    FLOAT (53)   NULL,
    [elevation]    FLOAT (53)   NULL,
    [state]        VARCHAR (2)  NULL,
    [name]         VARCHAR (30) NULL,
    [gsn_flag]     VARCHAR (3)  NULL,
    [hcn_crn_flag] VARCHAR (3)  NULL,
    [wmo_id]       VARCHAR (5)  NULL,
    [geo]          AS           ([geography]::Point([latitude],[longitude],(4326))) PERSISTED,
    CONSTRAINT [PK_Station] PRIMARY KEY CLUSTERED ([id] ASC)
);




GO
CREATE SPATIAL INDEX [IX_geo]
    ON [dbo].[station] ([geo])
    USING GEOGRAPHY_GRID
    WITH  (
            GRIDS = (LEVEL_1 = LOW, LEVEL_2 = LOW, LEVEL_3 = LOW, LEVEL_4 = LOW)
          );



