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



