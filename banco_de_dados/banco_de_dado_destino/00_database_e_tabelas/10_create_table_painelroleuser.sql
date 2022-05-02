/*********************************************************************************************
Script de criação da tabela "roleuser"

Descrição:
	A tabela "roleuser" deverá armazenar os painéis da organiza do site ou portal.

Relacionamento:
	se relaciona com a tabela pai "painel" e "pasta" que será de N para 1.    

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/


CREATE TABLE [security].[painelroleuser](
	[idpainelroleuser] [int] IDENTITY(1,1) NOT NULL,
	[idroleuserad] [int] NULL,
	[idpainel] [int] NULL,
	[idpasta] [int] NULL,
	[rolename] [nvarchar](260) NULL,
	[rolepermission] [varchar](500) NULL,
	[type] [int] NULL,
 CONSTRAINT [PK_idpainelroleuser] PRIMARY KEY CLUSTERED 
(
	[idpainelRoleUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [security].[painelroleuser]  WITH CHECK ADD  CONSTRAINT [FK_painelroleuser_Painel] FOREIGN KEY([idpainel])
REFERENCES [objects].[Painel] ([idpainel])
GO


ALTER TABLE [security].[painelroleuser]  WITH CHECK ADD  CONSTRAINT [FK_painelroleuser_Pasta] FOREIGN KEY([idPasta])
REFERENCES [objects].[Pasta] ([idPasta])
GO


ALTER TABLE [security].[painelroleuser]  WITH CHECK ADD  CONSTRAINT [FK_painelroleuser_RoleUserAD] FOREIGN KEY([idRoleUserAD])
REFERENCES [security].[RoleUserAD] ([idRoleUserAD])
GO