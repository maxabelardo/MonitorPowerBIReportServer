/*********************************************************************************************
Script de criação da tabela "workspace"

Descrição:
	A tabela "workspace" deverá armazenar o primeiro e segundo nível de pastas do site ou portal.

Relacionamento:
	se relaciona com a tabela pai "instancia" que será de N para 1.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/
CREATE TABLE [objects].[workspace](
	[idworkspace] [int] IDENTITY(1,1) NOT NULL,
	[idinstancia] [int] NULL,
	[workspace] [nvarchar](500) NULL,
	[ItemID] [nvarchar](40) NULL,
	[Path] [nvarchar](500) NULL,
	[Nivel] [int] NULL,
	[Localizacao] [nvarchar](max) NULL,
 CONSTRAINT [PK_Raiz] PRIMARY KEY CLUSTERED 
(
	[idworkspace] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [objects].[workspace]  WITH CHECK ADD  CONSTRAINT [FK_idinstancia] FOREIGN KEY([idinstancia])
REFERENCES [objects].[instancia] ([idinstancia])
GO


