# ReportServer

Base de origem será a base do Power BI Report Server que tem o nome padrão de "ReportServer", pore este nome pode ser mudado na hora da configuração do servidor.
Para localizar o nome da base siga os próximos passos:
|Passos |Imgens|
|------------------------------------------------------|-|
|conecte no servidor do Power BI Report Server||
|entre no aplicativo| ![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/icone_power_bi_repot_server.PNG?raw=true)|
|Digite o nome do servidor | ![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/Report_server_00.PNG?raw=true)|
|Clique na opção __Database__ | ![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/Report_server_02.PNG?raw=true)|


#### Dados que seram extraindo no destino:
- Diretórios.
- Painéis.
- Usuários com acesso.
- Permissões de acesso.
- __Conexões__, origem dos dados dos painéis.
- Tipo da origens dos dados.
- Agenda de atualização dos dados.
- Histórico de acesso aos painéis.
- Tamanho em MB dos painéis.


### Tabelas de origem dos dados:
- __Catalog__: Lista dos objetos "painel", diretórios e demais informações.
- __Users__: Lista doso os usuários com acesso ao site.
- __Policies__: vincula o objeto com a permissão dos usuários com a tabelas PocicyUserRole.
- __PolicyUserRoles__: Tabela N para N com a tabelas Role, Policies e Users
- __Roles__: tabelas com as permissões de acesso.
- __Schedule__: lista todas as agendas de atualização dos paineis. 
- __ReportSchedule__: vincula as agenda do painel da tabela "Schedule" com a tabelas "Catalog".
- __Subscriptions__: demais informações da agenda de atualização.
- __ExecutionLogStorage__: histórico de acesso aos objetos do site.

### Tabelas do SQL Server que seram extraido os dados.
- __msdb.dbo.sysjobs__: lista todos os jobs no servidor de SQL Server.
- __msdb.dbo.sysjobhistory__: lista o histórico de execução dos jobs.

### Diagrama de dados da base do Power BI Report Server.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/diagramaDadosPBIRS.PNG?raw=true)


## Destino dos dados.
#### O dados seram migrado para uma base rodando dentro SQL Server, mantendo a compatibilidade de SGBD, poderia ser utilizado outro SGBD para receber o dados? Sim totalmente possível.

### Estrutura de dados de destino.

### Tabelas:

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


### Diagrama de dados de destino.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/diagramaDadoDestino.PNG?raw=true)



