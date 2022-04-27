/*********************************************************************************************
Script de criação da tabela "roleuserad"

Descrição:
	A tabela "roleuserad" deverá armazenar os painéis da organiza do site ou portal.


A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/

CREATE TABLE [security].[roleuserad](
	[idroleuserad] [int] IDENTITY(1,1) NOT NULL,
	[loginname] [nvarchar](260) NULL,
	[username] [nvarchar](260) NULL,
	[useraccountcontrol] [int] NULL,
	[email] [nvarchar](100) NULL,
	[lotacao] [nvarchar](260) NULL,
 CONSTRAINT [PK_idroleuserad] PRIMARY KEY CLUSTERED 
(
	[idroleuserad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


