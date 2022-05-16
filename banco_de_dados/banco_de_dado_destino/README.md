
# MonitorPowerBI
Base de dados de destivno dos dados migrado, a base estará rodando em um servidor de SQL Server, poderia ser utilizado outro SGBD para receber o dados? 
Sim totalmente possível, porem neste projeto vamos utilizar o SQL Server.

### Base de dados:

#### Tabelas:

#####  <table>
  <tr>
    <td>Tabelas</td>
    <td>Tipo</td>
    <td>Descrição</td>
  </tr>
  <tr>
    <td>Auditoria</td>
    <td>BASE TABLE</td>
    <td>Tabela que armazena os logs do report server    </td>
  </tr>
  <tr>
    <td>DataSource</td>
    <td>BASE TABLE</td>
    <td>Fonte de dados dos painéis </td>
  </tr>
  <tr>
    <td>Estancia</td>
    <td>BASE TABLE</td>
    <td>As estâncias que serão monitoras, Tabela principal do sistema.</td>
  </tr>
  <tr>
    <td>ETL</td>
    <td>BASE TABLE</td>
    <td>Históricos de extração executadas. Execução do ETL.</td>
  </tr>
  <tr>
    <td>LogError</td>
    <td>BASE TABLE</td>
    <td>Histórico dos log de erro interno da base de dados.</td>
  </tr>
  <tr>
    <td>ObjetoRoleUser</td>
    <td>BASE TABLE</td>
    <td>Regas de acesso aos painéis.</td>
  </tr>    
  <tr>
    <td>Painel</td>
    <td>BASE TABLE</td>
    <td>Tabelas que armazena os painéis e as pasta onde estão localizados o painel.</td>
  </tr>    
  <tr>
    <td>PainelSize</td>
    <td>BASE TABLE</td>
    <td>Tabela que armazena o tamanho do painel no momento do ETL. Histórico de crescimento do painel.</td>
  </tr>
  <tr>
    <td>Pasta</td>
    <td>BASE TABLE</td>
    <td>Lista a estrutura das pastas dos painéis.</td>
  </tr> 
  <tr>
    <td>RoleUser</td>
    <td>BASE TABLE</td>
    <td>Usuários e permissão de acesso aos painéis. (usuários duplicados) </td>
  </tr>  
  <tr>
    <td>RoleUserAD</td>
    <td>BASE TABLE</td>
    <td>Lista de usuários sem duplicação com informações trazidas do Active Directory</td>
  </tr>    
  <tr>
    <td>Schedule</td>
    <td>BASE TABLE</td>
    <td>Lista de agenda de atualização dos painéis.</td>
  </tr>    
  <tr>
    <td>ScheduleHist</td>
    <td>BASE TABLE</td>
    <td>Histórico de atualização e o status da execução.</td>
  </tr>    
  <tr>
    <td>Visualizacao</td>
    <td>BASE TABLE</td>
    <td>Tabela de auditoria dos painéis, lista todos os acessos ao painel.</td>
  </tr>    
  <tr>
    <td>WorkSpace</td>
    <td>BASE TABLE</td>
    <td>Lista das Pastas raiz, ou seja, a primeira pasta do site.</td>
  </tr>    
  <tr>
    <td>Objeto</td>
    <td>VIEW</td>
    <td>Visão com os painéis com filtro para somente os painéis ativos.</td>
  </tr>    
  <tr>
    <td>relObjetos</td>
    <td>VIEW</td>
    <td>Visão com os dados do painel cruzado com outras tabelas.</td>
  </tr>      
</table>


### Diagrama de dados:
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/diagramaDadoDestino.PNG?raw=true)



# Código fonte.

### FileGroup
Como está base será utilizada como um historico dos portais do Power BI, a carga de dados deveram ser incremental, com isto teremos o histórico de todos os objetos. Prevendo um crescimento alto da base e o alto volume de dados nos logs de auditoria, a baser será criada com varios arquivos físico, dividir a carga de consulta e o volume de dados em diferentes arquivos que seram distribuidos em varios HD.

| FileGroup | Descrição |
|-----------|-----------|
| PRIMARY | grupo principal deverá armazenar a maioria das tabelas |
| SECONDAY | grupo secundario deverá armazenas as tabelas com alto volume de dados com baixa consulta. |
| AUDITING | grupo deverá armazenar a tabelas de auditoria. |
| INDEX | o recomendado que os arquivos deste grupo fique em um disco ssd, com isto o ganho de IO do index. |
| LOG | log transacional, será armazenados os dados das transacões de insert, update e delete no banco. |

#### Script de criação da base de dados.
```
USE [master]
GO
-- Comando para cria a base de dados, nome da base "monitor_power_bi"
CREATE DATABASE [monitor_power_bi]
 CONTAINMENT = NONE  ON  
 -- Arquivos físicos: "monitor_power_bi00" local "D:\SQL2016\monitor_power_bi00.mdf" e filegroup "PRIMARY"
 PRIMARY   
( NAME = N'monitor_power_bi00', FILENAME = N'D:\SQL2016\monitor_power_bi00.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

-- Arquivos físicos: "monitor_power_bi00" local "D:\SQL2016\monitor_power_bi_auditing.ndf" e filegroup "AUDITING"
 FILEGROUP [AUDITING]  
( NAME = N'monitor_power_bi_auditing', FILENAME = N'D:\SQL2016\monitor_power_bi_auditing.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 

-- Arquivos físicos: "monitor_power_bi00" local "D:\SQL2016\monitor_power_bi_index.ndf" e filegroup "INDEX"
 FILEGROUP [INDEX]  
( NAME = N'monitor_power_bi_index', FILENAME = N'D:\SQL2016\monitor_power_bi_index.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 

-- Arquivos físicos: "monitor_power_bi00" local "D:\SQL2016\monitor_power_bi10.ndf" e filegroup "PRIMARY"
 FILEGROUP [SECONDARY]  
( NAME = N'monitor_power_bi10', FILENAME = N'D:\SQL2016\monitor_power_bi10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )

-- Arquivos físicos: "monitor_power_bi00" local "E:\SQL2016\monitor_power_bi_log.ldf" e filegroup "LOG"
 LOG ON  
( NAME = N'monitor_power_bi_log', FILENAME = N'E:\SQL2016\monitor_power_bi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

-- Se a função FULL TEXT estiver ativa, ativar a função para base de dados.
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [monitor_power_bi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

```



### Schema:
A base de dados é separada em: objetos, sergurança, atualização e auditoria, cada item deverá ser um "schema" dentro do banco de dados.

* objetos      = objects
* sergurança   = security
* atualização  = updating
* auditoria    = auditing 
* dbo          = dbo

Com está metodologia podemos ter um controle melhor na liberação de acesso aos usuários em ações futuras.


#### Script:
```
-- Schema objetos
CREATE SCHEMA [objects] AUTHORIZATION [dbo]
GO

-- Schema sergurança
CREATE SCHEMA [security] AUTHORIZATION [dbo]
GO

-- Schema atualização
CREATE SCHEMA [updating] AUTHORIZATION [dbo]
GO

-- Schema auditoria
CREATE SCHEMA [auditing] AUTHORIZATION [dbo]
GO

```
O schema __"dbo"__ já existe por padrão no banco.


### Tabelas:
| Schema              | Tabela             | Tipo            | Descrição                                                      |
|---------------------|--------------------|-----------------|----------------------------------------------------------------|
| auditing            | auditoria	         | BASE_TABLE	     | Tabela que armazena os logs do report server. |
| auditing            | logerror	         | BASE_TABLE	     | Tabela que armazena os logs de erros internos da base. |
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
![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_objects.PNG?raw=true)


### Diagrama de dados _auditing_:
| auditing  | auditing com tabela "painel" do schema _objects_    |
|---|-----|
|![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_auditing.PNG?raw=true) | ![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_auditing_completo.PNG?raw=true)|


### Diagrama de dados _security_:
| security  | security com tabela "painel" do schema _objects_    |
|---|-----|
|![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_security.PNG?raw=true) | ![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_security_completo.PNG?raw=true)|


### Diagrama de dados _updating_:
| updating  | security com tabela "painel" do schema _updating_    |
|---|-----|
|![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_auditing.PNG?raw=true) | ![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_auditing_completo.PNG?raw=true)|

### Diagrama de dados completo:
![image](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/dd_completo.PNG?raw=true)

## Funções internas
Neste projetos vamos utilizar as SP __"store procedures"__ e FN __"Function"__ para executar tarefas dentro do banco.

<P>O que é __"store procedures"__?</P>
Um __Store Procedures__ no SQL Server é um grupo de uma ou mais instruções Transact-SQL ou uma referência a um método CLR (Common Language Runtime) do Microsoft .NET Framework. Os procedimentos lembram as construções em outras linguagens de programação porque podem:
* Aceitar parâmetros de entrada e retornar vários valores no formulário de parâmetros de saída para o programa de chamada.
* Conter instruções de programação que executam operações no banco de dados. Estas incluem a chamada de outros procedimentos.
* Retornar um valor de status a um programa de chamada para indicar êxito ou falha (e o motivo da falha).

[Para mais informações acessar o link](https://docs.microsoft.com/pt-br/sql/relational-databases/stored-procedures/stored-procedures-database-engine?view=sql-server-ver15)

<P>O que é __"Function"__?</P>
Uma função definida pelo usuário é uma rotina Transact-SQL ou CLR (Common Language Runtime) que aceita parâmetros, executa uma ação, como um cálculo complexo, e retorna o resultado dessa ação como um valor. O valor de retorno pode ser um valor escalar (único) ou uma tabela. Use essa instrução para criar uma rotina reutilizável que possa ser usada destas maneiras:
* Em instruções Transact-SQL, como SELECT
* Em aplicativos que chamam a função
* Na definição de outra função definida pelo usuário
* Para parametrizar uma exibição ou aprimorar a funcionalidade de uma exibição indexada
* Para definir uma coluna em uma tabela
* Para definir uma restrição CHECK em uma coluna
* Para substituir um procedimento armazenado

[Para mais informações acessar o link](https://docs.microsoft.com/pt-br/sql/t-sql/statements/create-function-transact-sql?view=sql-server-ver15)

















