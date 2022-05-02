/*********************************************************************************************
Script de criação da tabela "visualizacao"

Descrição:
	A tabela "visualizacao" deverá armazenar o log de visualizações dos painéis.

Relacionamento:
	se relaciona com a tabela pai "painel" que será de N para 1.

A tabela está sendo criada no filegroup "AUDITING"

*********************************************************************************************/


CREATE TABLE [auditing].[visualizacao](
	[idvisualizacao] [int] IDENTITY(1,1) NOT NULL,
	[idpainel] [int] NOT NULL,
	[itemid] [nvarchar](40) NULL,
	[username] [nvarchar](260) NULL,
	[loginname] [nvarchar](260) NULL,
	[lotacao] [nvarchar](260) NULL,
	[requesttype] [nvarchar](26) NULL,
	[format] [nvarchar](26) NULL,
	[itemaction] [nvarchar](26) NULL,
	[timestart] [datetime] NULL,
	[timedataretrieval] [int] NULL,
	[source] [nvarchar](20) NULL,
	[status] [nvarchar](40) NULL,
	[sountbyte] [bigint] NULL,
	[countrow] [bigint] NULL,
	[eventdate] [date] NULL,
	[eventtime] [time](7) NULL,
	[executionid] [nvarchar](64) NULL,
 CONSTRAINT [PK_idvisualizacao] PRIMARY KEY CLUSTERED 
(
	[idvisualizacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [SECONDARY]
GO

ALTER TABLE [auditing].[visualizacao]  WITH CHECK ADD  CONSTRAINT [FK_idpainel_visualizacao] FOREIGN KEY([idpainel])
REFERENCES [objects].[painel] ([idpainel])
GO
