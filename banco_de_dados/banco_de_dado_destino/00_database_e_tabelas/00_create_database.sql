USE [master]
GO

CREATE DATABASE [monitor_power_bi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'monitor_power_bi00', FILENAME = N'D:\SQL2016\monitor_power_bi00.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [AUDITING] 
( NAME = N'monitor_power_bi_auditing', FILENAME = N'D:\SQL2016\monitor_power_bi_auditing.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [INDEX] 
( NAME = N'monitor_power_bi_index', FILENAME = N'D:\SQL2016\monitor_power_bi_index.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [SECONDARY] 
( NAME = N'monitor_power_bi10', FILENAME = N'D:\SQL2016\monitor_power_bi10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'monitor_power_bi_log', FILENAME = N'E:\SQL2016\monitor_power_bi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [monitor_power_bi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
