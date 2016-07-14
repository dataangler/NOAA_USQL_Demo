CREATE TABLE [dbo].[airport] (
    [iata_code] VARCHAR (3)  NOT NULL,
    [name]      VARCHAR (64) NULL,
    [city]      VARCHAR (64) NULL,
    [latitude]  FLOAT (53)   NOT NULL,
    [longitude] FLOAT (53)   NOT NULL,
    [geo]       AS           ([geography]::Point([latitude],[longitude],(4326))) PERSISTED,
    CONSTRAINT [PK_Airport] PRIMARY KEY CLUSTERED ([iata_code] ASC)
);



GO

CREATE SPATIAL INDEX [IX_airport_geo]
    ON [dbo].[airport] ([geo])
    USING GEOGRAPHY_GRID
    WITH  (
            GRIDS = (LEVEL_1 = LOW, LEVEL_2 = LOW, LEVEL_3 = LOW, LEVEL_4 = LOW)
          );

