/*********************************************************************************************
Script de criação da tabela "datasource"

Descrição:
	A tabela "datasource" deverá armazenar os painéis da organiza do site ou portal.

Relacionamento:
	se relaciona com a tabela pai "painel" que será de N para 1.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/


CREATE TABLE [objects].[datasource](
	[iddatasource] [int] IDENTITY(1,1) NOT NULL,
	[idpainel] [int] NOT NULL,
	[itemid] [nvarchar](40) NULL,
	[dstype] [varchar](100) NULL,
	[dsKind] [varchar](100) NULL,
	[authtype] [varchar](100) NULL,
	[DS] [nvarchar](max) NULL,
 CONSTRAINT [PK_iddatasource] PRIMARY KEY CLUSTERED 
(
	[iddatasource] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [objects].[datasource]  WITH CHECK ADD  CONSTRAINT [FK_idpainel_datasource] FOREIGN KEY([idpainel])
REFERENCES [objects].[painel] ([idpainel])
GO

ALTER TABLE [objects].[datasource] CHECK CONSTRAINT [FK_idpainel_datasource]
GO


