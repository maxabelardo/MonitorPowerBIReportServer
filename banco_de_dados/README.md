# Banco de dados de destino "monitor_porwer_bi"

### FileGroup
Como está base será utilizada como um historico dos portais do Power BI, a carga de dados deveram ser incremental, com isto teremos o histórico dos objetos. Prevendo um crescimento alto da base e o alto volume de dados nos logs de auditoria, a baser será criada com varios arquivos físico, dividir a carga de consulta e o volume de dados em diferentes arquivos e diretórios.

| FileGroup | Descrição |
|-----------|-----------|
| PRIMARY | grupo principal deverá armazenar a maioria das tabelas |
| SECONDAY | grupo secundario deverá armazenas as tabelas com alto volume de dados com baixa consulta. |
| AUDITING | grupo deverá armazenar a tabelas de auditoria. |
| INDEX | o recomendado que os arquivos deste grupo fique em um disco ssd, com isto o ganho de IO do index. |
| LOG | log transacional, será armazenados os dados das transacões de insert, update e delete no banco. |

Script:
```
USE [master]
GO

CREATE DATABASE [monitor_power_bi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'monitor_power_bi00', FILENAME = N'D:\SQL2016\monitor_power_bi00.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [AUDITING] 
( NAME = N'monitor_power_bi_auditing', FILENAME = N'D:\SQL2016\monitor_power_bi_auditing.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [INDEX] 
( NAME = N'monitor_power_bi_index', FILENAME = N'D:\SQL2016\monitor_power_bi_index.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [SECONDARY] 
( NAME = N'monitor_power_bi10', FILENAME = N'D:\SQL2016\monitor_power_bi10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'monitor_power_bi_log', FILENAME = N'E:\SQL2016\monitor_power_bi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [monitor_power_bi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

```



### Schema:
A base de dados é separada em objetos, sergurança, atualização e auditoria, cada item deverá ser um "schema" dentro do banco de dados.

* objetos      = objects
* sergurança   = security
* atualização  = updating
* auditoria    = auditing 
* dbo          = dbo

Com está metodologia podemos ter um controle melhor na liberação de acesso aos usuários em ações futuras.
### Script:
```
CREATE SCHEMA [objects] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [security] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [updating] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [auditing] AUTHORIZATION [dbo]
GO

```

### Tabelas:
| Schema              | Tabela             | Tipo            | Descrição                                                      |
|---------------------|--------------------|-----------------|----------------------------------------------------------------|
| auditing            | auditoria	         | BASE_TABLE	     | Tabela que armazena os logs do report server. |
| auditing            | visualizacao	      | BASE_TABLE	     | Tabela de auditoria dos painéis, lista todos os acessos ao painel. |
| objects             | datasource         |	BASE_TABLE	     | Fonte de dados dos painéis. |
| objects             | Estancia	          | BASE_TABLE	     | As estâncias que serão monitoras, Tabela principal do sistema. |
| objects             | painel             | BASE_TABLE	     | Tabelas que armazena os painéis e as pasta onde estão localizados o painel. |
| objects             | painelsize	        | BASE_TABLE	     | Tabela que armazena o tamanho do painel no momento do ETL. Histórico de crescimento do painel. |
| objects             | Pasta	             | BASE_TABLE	     | Lista a estrutura das pastas dos painéis. |
| objects             | workspace	         | BASE_TABLE	     | Lista das Pastas raiz, ou seja, a primeira pasta do site. |
| objects             | vw_objeto          | VIEW	           | Visão com os painéis com filtro para somente os painéis ativos. |
| objects             | vw_relobjetos	     | VIEW	           | Visão com os dados do painel cruzado com outras tabelas. |
| dbo                 | etl                |	BASE_TABLE	     | Históricos de extração executadas. Execução do ETL. |
| security            | objetoroleuser	    | BASE_TABLE	     | Regas de acesso aos painéis. |
| security            | roleuser	          | BASE_TABLE	     | Usuários e permissão de acesso aos painéis. (usuários duplicados). |
| security            | roleuserad	        | BASE_TABLE	     | Lista de usuários sem duplicação com informações trazidas do Active Directory. |
| updating            | schedule	          | BASE_TABLE	     | Lista de agenda de atualização dos painéis. |
| updating            | schedulehist	      | BASE_TABLE	     | Histórico de atualização e o status da execução. |


### Diagrama de dados _objects_:





### Diagrama de dados _security_:

### Diagrama de dados _updating_:

### Diagrama de dados _auditing_:
























## Origem dos dados.
### Itens que seram extraindo:
- Diretórios.
- Painéis.
- Usuários com acesso.
- Permissões de acesso.
- Conexões de dados, origem dos dados dos painéis.
- Tipo da origens dos dados.
- Agenda de atualização dos dados.
- Histórico de acesso aos painéis.

### Tabelas de origem dos dados:
- Catalog: Lista dos objetos "painel", diretórios e demais informações.
- Users: Lista doso os usuários com acesso ao site.
- Policies: vincula o objeto com a permissão dos usuários com a tabelas PocicyUserRole.
- PolicyUserRoles: Tabela N para N com a tabelas Role, Policies e Users
- Roles: tabelas com as permissões de acesso.
- Schedule: lista todas as agendas de atualização dos paineis. 
- ReportSchedule: vincula as agenda do painel da tabela "Schedule" com a tabelas "Catalog".
- Subscriptions: demais informações da agenda de atualização.
- ExecutionLogStorage: histórico de acesso aos objetos do site.

### Tabelas do servidor que são utilizadas.
- msdb.dbo.sysjobs: lista todos os jobs no servidor de SQL Server.
- msdb.dbo.sysjobhistory: lista o histórico de execução dos jobs.

### Diagrama de dados da base do Power BI Report Server.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/diagramaDadosPBIRS.PNG?raw=true)


## Destino dos dados.
#### O dados seram migrado para uma base rodando dentro SQL Server, mantendo a compatibilidade de SGBD, poderia ser utilizado outro SGBD para receber o dados? Sim totalmente possível.

### Estrutura de dados de destino.

### Tabelas:






### Diagrama de dados de destino.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/diagramaDadoDestino.PNG?raw=true)


