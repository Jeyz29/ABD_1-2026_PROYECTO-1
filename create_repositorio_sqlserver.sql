-- ============================================================
-- StreamUCV — SQL Server 2022
-- Script: create_repositorio_sqlserver.sql
-- Descripción:Este script crea la base de datos y el esquema del proyecto.



USE master;
GO

-- Eliminar BD si existe
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'StreamUCV'
)
BEGIN
    ALTER DATABASE StreamUCV
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE StreamUCV;
END
GO

-- Crear base de datos
CREATE DATABASE StreamUCV;
GO

USE StreamUCV;
GO

-- Crear esquema
IF NOT EXISTS (
    SELECT *
    FROM sys.schemas
    WHERE name = 'streaming'
)
BEGIN
    EXEC('CREATE SCHEMA streaming');
END
GO