/********************************************************************************************************
Autor: José Abelardo Vicente Filho
Data criação: 15/02/2022

Objetivo: Este script extrai os diretórios do site.

Descrição do script:
    O script é divido em duas parte dentro de um loop recursivo.
    O primeiro Select retorna o pagina principal do site.
    O segundo Select retorna todos os outros objetos abaixo do site principal
	Fora do loop o e feito um um filtro para retorna apenas os diretórios.
	O objetivo de se utilizar um loop recursivo é para criar o nível do diretório na coluna "Nivel"
	
*********************************************************************************************************/
;WITH CTE_Recursivo AS (

		SELECT 1 AS Nivel
				, [ItemID]
				, [ParentID]
				,CASE 
				WHEN [ParentID] IS NULL THEN 'Página Inicial'
				ELSE [Path]
				END AS 'Localizacao'
			  ,[Name] AS 'Pasta'
			  ,CASE
				WHEN [Type] = 1 THEN 'Folde'
				WHEN [Type] = 2 THEN 'Report'
				WHEN [Type] = 3 THEN 'File'
				WHEN [Type] = 4 THEN 'Linked Report'
				WHEN [Type] = 5 THEN 'Datasource'
				WHEN [Type] = 6 THEN 'Model'
				WHEN [Type] = 7 THEN 'ReportPart'
				WHEN [Type] = 8 THEN 'Shared Dataset'
				WHEN [Type] = 9 THEN 'Unknown'
				WHEN [Type] = 10 THEN '----'
				WHEN [Type] = 11 THEN 'Mobile Report'
				WHEN [Type] = 13 THEN 'Power BI Report'
				WHEN [Type] = 14 THEN 'QueryData'
				WHEN [Type] = 15 THEN 'ASModelStream'
				WHEN [Type] = 16 THEN 'RenderExcelWorkbook'
				WHEN [Type] = 17 THEN 'GetExcelWorkbookInfo'
				WHEN [Type] = 18 THEN 'SaveToCatalog'
				WHEN [Type] = 19 THEN 'DataRefresh'
			   END AS 'Tipo'
			  ,[CreationDate] AS 'DatadaCriacao'
			  ,[ModifiedDate] AS 'DatadaModificacao'
			  ,DATEDIFF(DAY,[CreationDate],[ModifiedDate]) AS 'DiasSemAlteracao'
		FROM [dbo].[Catalog]
		WHERE [ParentID] IS NULL

UNION ALL 

		SELECT B.Nivel + 1 AS Nivel 
				, A.[ItemID]
				, A.[ParentID]
				,CASE 
				WHEN A.[ParentID] IS NULL THEN 'Página Inicial'
				ELSE A.[Path]
				END AS 'Localizacao'
			  ,A.[Name] AS 'Pasta'
			  ,CASE
				WHEN A.[Type] = 1 THEN 'Folde'
				WHEN A.[Type] = 2 THEN 'Report'
				WHEN A.[Type] = 3 THEN 'File'
				WHEN A.[Type] = 4 THEN 'Linked Report'
				WHEN A.[Type] = 5 THEN 'Datasource'
				WHEN A.[Type] = 6 THEN 'Model'
				WHEN A.[Type] = 7 THEN 'ReportPart'
				WHEN A.[Type] = 8 THEN 'Shared Dataset'
				WHEN A.[Type] = 9 THEN 'Unknown'
				WHEN A.[Type] = 10 THEN '----'
				WHEN A.[Type] = 11 THEN 'Mobile Report'
				WHEN A.[Type] = 13 THEN 'Power BI Report'
				WHEN A.[Type] = 14 THEN 'QueryData'
				WHEN A.[Type] = 15 THEN 'ASModelStream'
				WHEN A.[Type] = 16 THEN 'RenderExcelWorkbook'
				WHEN A.[Type] = 17 THEN 'GetExcelWorkbookInfo'
				WHEN A.[Type] = 18 THEN 'SaveToCatalog'
				WHEN A.[Type] = 19 THEN 'DataRefresh'
			   END AS 'Tipo'
			  ,A.[CreationDate] AS 'DatadaCriacao'
			  ,A.[ModifiedDate] AS 'DatadaModificacao'
			  ,DATEDIFF(DAY,A.[CreationDate],A.[ModifiedDate]) AS 'DiasSemAlteracao'
		FROM [dbo].[Catalog] AS A
		INNER JOIN CTE_Recursivo AS B ON A.[ParentID] = B.[ItemID]
)
SELECT '1' AS 'idEstancia'
     , Nivel
     , CAST([ItemID] AS NVARCHAR(40)) AS 'ItemID'
	 , [ParentID]
	 , Localizacao
	 , Pasta 
	 , Tipo
	 , DatadaCriacao
	 , DatadaModificacao
	 , DiasSemAlteracao
FROM CTE_Recursivo WHERE Tipo = 'Folde'