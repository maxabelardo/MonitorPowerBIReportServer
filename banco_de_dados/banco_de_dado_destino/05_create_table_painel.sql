/*********************************************************************************************
Script de criação da tabela "painel"

Descrição:
	A tabela "painel" deverá armazenar os painéis da organiza do site ou portal.

Relacionamento:
	se relaciona com a tabela pai "pasta" que será de N para 1.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/

CREATE TABLE [objects].[painel](
	[idpainel] [int] IDENTITY(1,1) NOT NULL,
	[idpasta] [int] NOT NULL,
	[itemid] [nvarchar](40) NULL,
	[parentid] [nvarchar](40) NULL,
	[localizacao] [nvarchar](425) NULL,
	[painel] [nvarchar](425) NULL,
	[tipo] [varchar](20) NULL,
	[datadacriacao] [datetime] NULL,
	[datadamodificacao] [datetime] NULL,
	[ultimavisualizacao] [datetime] NULL,
	[diassemalteracao] [int] NULL,
	[tamanho] [float] NULL,
	[ativo] [bit] NULL,
	[createdbyusername] [nvarchar](260) NULL,
	[modifiedbyusername] [nvarchar](260) NULL,
 CONSTRAINT [PK_idObjeto] PRIMARY KEY CLUSTERED 
(
	[idpainel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [objects].[painel] ADD  DEFAULT ((1)) FOR [ativo]
GO

ALTER TABLE [objects].[painel]  WITH CHECK ADD  CONSTRAINT [FK_painel_pasta] FOREIGN KEY([idpasta])
REFERENCES [objects].[pasta] ([idpasta])
GO


