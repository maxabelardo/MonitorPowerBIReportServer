/*********************************************************************************************
Script de criação da tabela "pasta"

Descrição:
	A tabela "pasta" deverá armazenar as pasta que organiza o site ou portal.

Relacionamento:
	se relaciona com a tabela pai "instancia" que será de N para 1.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/

CREATE TABLE [objects].[pasta](
	[idpasta] [int] IDENTITY(1,1) NOT NULL,
	[idinstancia] [int] NULL,
	[ItemID] [nvarchar](40) NULL,
	[parentID] [nvarchar](40) NULL,
	[localizacao] [nvarchar](425) NULL,
	[pasta] [nvarchar](425) NULL,
	[tipo] [varchar](20) NULL,
	[dataDacriacao] [datetime] NULL,
	[datadamodificacao] [datetime] NULL,
	[ultimavisualizacao] [datetime] NULL,
	[diassemalteracao] [int] NULL,
	[nivel] [int] NULL,
	[ativo] [bit] NULL,
 CONSTRAINT [PK_idWorkSpace] PRIMARY KEY CLUSTERED 
(
	[idpasta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [objects].[pasta] ADD  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [objects].[pasta]  WITH CHECK ADD  CONSTRAINT [FK_pasta_instancia] FOREIGN KEY([idinstancia])
REFERENCES [objects].[instancia] ([idinstancia])
GO


