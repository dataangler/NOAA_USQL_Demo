﻿/*
Deployment script for noaadb

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "noaadb"
:setvar DefaultFilePrefix "noaadb"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

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
PRINT N'Dropping [stg]...';


GO
DROP SCHEMA [stg];


GO
PRINT N'Creating [dbo].[station]...';


GO
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
    [geo]          AS           ([geography]::Point(latitude, longitude, 4326)) PERSISTED,
    CONSTRAINT [PK_Station] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Creating [dbo].[station].[IX_geo]...';


GO
CREATE SPATIAL INDEX [IX_geo]
    ON [dbo].[station] ([geo]);


GO
PRINT N'Update complete.';


GO
