/*********************************************************************************************
Script de criação da tabela "datasource"

Descrição:
	A tabela "datasource" deverá armazenar os painéis da organiza do site ou portal.

Relacionamento:
	se relaciona com a tabela pai "painel" que será de N para 1.

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/

CREATE TABLE [objects].[painelsize](
	[idpainelsize] [int] IDENTITY(1,1) NOT NULL,
	[idpainel] [int] NOT NULL,
	[size] [real] NULL,
	[datatimer] [datetime] NULL,
	[eventdate] [date] NULL,
	[eventtime] [time](7) NULL,
 CONSTRAINT [PK_idpainelsize] PRIMARY KEY CLUSTERED 
(
	[idpainelsize] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [objects].[painelsize] ADD  DEFAULT (getdate()) FOR [datatimer]
GO

ALTER TABLE [objects].[painelsize]  WITH CHECK ADD  CONSTRAINT [FK_idpainel_Size] FOREIGN KEY([idpainel])
REFERENCES [objects].[painel] ([idpainel])
GO

ALTER TABLE [objects].[painelsize] CHECK CONSTRAINT [FK_idpainel_Size]
GO
