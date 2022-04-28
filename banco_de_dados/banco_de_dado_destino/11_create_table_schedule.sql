/*********************************************************************************************
Script de criação da tabela "schedule"

Descrição:
	A tabela "schedule" deverá armazenar a rotinas de atualização dos painéis.

Relacionamento:
	se relaciona com a tabela pai "painel"  que será de N para 1.    

A tabela está sendo criada no filegroup "PRIMARY"


*********************************************************************************************/

CREATE TABLE [updating].[schedule](
	[idschedule] [int] IDENTITY(1,1) NOT NULL,
	[idpainel] [int] NOT NULL,
	[itemid] [nvarchar](40) NULL,
	[acheduleid] [nvarchar](40) NOT NULL,
	[schedulename] [nvarchar](260) NULL,
	[tiporecorrente] [varchar](8) NULL,
	[subtiporecorrente] [varchar](16) NULL,
	[executaracada(Hora)] [varchar](45) NULL,
	[executaracada(Dia)] [varchar](3) NULL,
	[executaracada(Semana)] [varchar](3) NULL,
	[executaracada(DiaDaSemana)] [varchar](30) NULL,
	[executaracada(SemanaDoMêe)] [varchar](7) NULL,
	[executaracada(Mes)] [varchar](48) NULL,
	[exectaraacada(DiaDoMes)] [varchar](84) NULL,
	[datainicio] [datetime] NULL,
	[proximaexecucao] [datetime] NULL,
	[ultimaexecucao] [datetime] NULL,
	[statusdaexecucao] [varchar](12) NULL,
	[duracao] [varchar](11) NULL,
	[dataFinal] [datetime] NULL,
 CONSTRAINT [PK_idschedule] PRIMARY KEY CLUSTERED 
(
	[idschedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [updating].[schedule]  WITH CHECK ADD  CONSTRAINT [FK_idpainel] FOREIGN KEY([idpainel])
REFERENCES [objects].[painel] ([idpainel])
GO
