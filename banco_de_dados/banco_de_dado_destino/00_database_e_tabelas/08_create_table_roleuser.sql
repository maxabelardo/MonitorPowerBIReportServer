/*********************************************************************************************
Script de criação da tabela "roleuser"

Descrição:
	A tabela "roleuser" deverá armazenar os painéis da organiza do site ou portal.

Observação: ESTA TABELA É N para N com as tabelas "painel" e "pasta"

Relacionamento:
	se relaciona com a tabela pai "painel" e "pasta" que será de N para 1.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/


CREATE TABLE [security].[roleuser](
	[idroleuser] [int] IDENTITY(1,1) NOT NULL,
	[idpainel] [int] NULL,
	[idpasta] [int] NULL,
	[itemid] [nvarchar](40) NULL,
	[parentid] [nvarchar](40) NULL,
	[loginname] [nvarchar](260) NULL,
	[username] [nvarchar](260) NULL,
	[type] [int] NULL,
	[rolename] [nvarchar](260) NULL,
	[rolepermission] [varchar](500) NULL,
	[useraccountcontrol] [int] NULL,
	[email] [nvarchar](100) NULL,
	[lotacao] [nvarchar](260) NULL,
 CONSTRAINT [PK_idroleuser] PRIMARY KEY CLUSTERED 
(
	[idroleuser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [SECONDARY]
GO

ALTER TABLE [security].[roleuser]  WITH CHECK ADD  CONSTRAINT [FK_roleuser_Objeto] FOREIGN KEY([idpainel])
REFERENCES [objects].[painel] ([idpainel])
GO


ALTER TABLE [security].[roleuser]  WITH CHECK ADD  CONSTRAINT [FK_roleuser_pasta] FOREIGN KEY([idpasta])
REFERENCES [objects].[pasta] ([idpasta])
GO


