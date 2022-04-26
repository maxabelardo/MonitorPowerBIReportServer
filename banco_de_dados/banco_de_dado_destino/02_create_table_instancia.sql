/*********************************************************************************************
Script de criação da tabela "PAI" "instancia"

Descrição:
	A tabela "instancia" deverá armazenar os sites ou portal do Power BI Report Server.
	Para cada site haverá uma linha na tabela.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/

CREATE TABLE [objects].[instancia](
	[idinstancia] [int] IDENTITY(1,1) NOT NULL,
	[instancia] [nvarchar](55) NULL,
	[descricao] [nvarchar](100) NULL,
	[url] [nvarchar](max) NULL,
	[conexaobanco] [nvarchar](max) NULL,
	[servidor] [nvarchar](30) NULL,
 CONSTRAINT [PK_instancia] PRIMARY KEY CLUSTERED 
(
	[idinstancia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


