/*********************************************************************************************
Script de criação da tabela "schedulehist"

Descrição:
	A tabela "schedulehist" deverá armazenar o historico de atualização dos painéis.

Relacionamento:
	se relaciona com a tabela pai "painel"  que será de N para 1.    

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/


CREATE TABLE [updating].[schedulehist](
	[idschedulehist] [int] IDENTITY(1,1) NOT NULL,
	[idschedule] [int] NOT NULL,
	[scheduleid] [sysname] NULL,
	[itemid] [nvarchar](40) NULL,
	[objeto] [nvarchar](425) NULL,
	[datadaexecucao] [datetime] NULL,
	[statusdaexecucao] [varchar](12) NULL,
	[duracao] [varchar](11) NULL,
	[run_status] [int] NULL,
	[eventdate] [date] NULL,
	[eventtime] [time](7) NULL,
 CONSTRAINT [PK_idschedulehist] PRIMARY KEY CLUSTERED 
(
	[idschedulehist] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [updating].[schedulehist]  WITH CHECK ADD  CONSTRAINT [FK_schedulehist] FOREIGN KEY([idschedule])
REFERENCES [updating].[schedule] ([idschedule])
GO
