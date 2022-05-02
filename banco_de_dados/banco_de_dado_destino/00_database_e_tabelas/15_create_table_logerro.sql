/*********************************************************************************************
Script de criação da tabela "logerror"

Descrição:
	A tabela "logerror" deverá armazenar o log de visualizações dos painéis.

Relacionamento:
	se relaciona com a tabela pai "painel" que será de N para 1.

A tabela está sendo criada no filegroup "AUDITING"

*********************************************************************************************/

CREATE TABLE [auditing].[logerror](
	[idlogerro]     [int] IDENTITY(1,1) NOT NULL,
	[errorobjeto]   [nvarchar](100) NULL,
	[errornumber]   [int] NULL,
	[ErrorMessage]  [nvarchar](MAX) NULL,
	[ErrorSeverity] [nvarchar](MAX) NULL,
	[ErrorState]    [int] NULL,
	[ErrorLine]     [nvarchar](MAX) NULL,
	[datatimer]     [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [SECONDARY]
GO

ALTER TABLE [auditing].[logerror] ADD  DEFAULT (getdate()) FOR [datatimer]
GO