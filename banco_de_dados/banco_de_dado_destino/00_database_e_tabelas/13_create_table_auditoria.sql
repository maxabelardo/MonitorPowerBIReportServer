/*********************************************************************************************
Script de criação da tabela "auditoria"

Descrição:
	A tabela "auditoria" deverá armazenar todas as alterações nos objetos.
    Esta tabela é alimentada pelas SP de Update e Delete dentro do banco


A tabela está sendo criada no filegroup "AUDITING"

*********************************************************************************************/

CREATE TABLE [auditing].[auditoria](
	[idauditoria] [int] IDENTITY(1,1) NOT NULL,
	[tabname] [nvarchar](30) NULL,
	[idregistro] [int] NULL,
	[acao] [nvarchar](10) NULL,
	[valoranterior] [text] NULL,
	[valordepois] [text] NULL,
	[datatimer] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [AUDITING]

GO

ALTER TABLE [auditing].[auditoria] ADD  DEFAULT (getdate()) FOR [datatimer]
GO

