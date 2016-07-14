CREATE TABLE [dbo].[station_iata] (
    [id]           VARCHAR (11) NOT NULL,
    [latitude]     FLOAT (53)   NULL,
    [longitude]    FLOAT (53)   NULL,
    [elevation]    FLOAT (53)   NULL,
    [state]        VARCHAR (2)  NULL,
    [name]         VARCHAR (30) NULL,
    [gsn_flag]     VARCHAR (3)  NULL,
    [hcn_crn_flag] VARCHAR (3)  NULL,
    [wmo_id]       VARCHAR (5)  NULL,
    [iata_code]    VARCHAR (3)  NULL,
    [iata_city]    VARCHAR (64) NULL,
    CONSTRAINT [PK_station_iata] PRIMARY KEY CLUSTERED ([id] ASC)
);

