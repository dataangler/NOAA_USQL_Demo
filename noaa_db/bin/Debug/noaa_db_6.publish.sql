﻿/*
Deployment script for tpa

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "tpa"
:setvar DefaultFilePrefix "tpa"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The type for column gsn_flag in table [dbo].[station] is currently  NVARCHAR (3) NULL but is being changed to  VARCHAR (3) NULL. Data loss could occur.

The type for column hcn_crn_flag in table [dbo].[station] is currently  NVARCHAR (3) NULL but is being changed to  VARCHAR (3) NULL. Data loss could occur.

The type for column id in table [dbo].[station] is currently  NVARCHAR (11) NOT NULL but is being changed to  VARCHAR (11) NOT NULL. Data loss could occur.

The type for column name in table [dbo].[station] is currently  NVARCHAR (30) NULL but is being changed to  VARCHAR (30) NULL. Data loss could occur.

The type for column state in table [dbo].[station] is currently  NVARCHAR (2) NULL but is being changed to  VARCHAR (2) NULL. Data loss could occur.

The type for column wmo_id in table [dbo].[station] is currently  NVARCHAR (5) NULL but is being changed to  VARCHAR (5) NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[station])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Starting rebuilding table [dbo].[station]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_station] (
    [id]           VARCHAR (11) NOT NULL,
    [latitude]     FLOAT (53)   NULL,
    [longitude]    FLOAT (53)   NULL,
    [elevation]    FLOAT (53)   NULL,
    [state]        VARCHAR (2)  NULL,
    [name]         VARCHAR (30) NULL,
    [gsn_flag]     VARCHAR (3)  NULL,
    [hcn_crn_flag] VARCHAR (3)  NULL,
    [wmo_id]       VARCHAR (5)  NULL,
    [geo]          AS           ([geography]::Point(latitude, longitude, 4326)) PERSISTED,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Station1] PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[station])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_station] ([id], [latitude], [longitude], [elevation], [state], [name], [gsn_flag], [hcn_crn_flag], [wmo_id])
        SELECT   [id],
                 [latitude],
                 [longitude],
                 [elevation],
                 [state],
                 [name],
                 [gsn_flag],
                 [hcn_crn_flag],
                 [wmo_id]
        FROM     [dbo].[station]
        ORDER BY [id] ASC;
    END

DROP TABLE [dbo].[station];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_station]', N'station';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Station1]', N'PK_Station', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[station].[IX_geo]...';


GO
CREATE SPATIAL INDEX [IX_geo]
    ON [dbo].[station] ([geo]);


GO
PRINT N'Update complete.';


GO
