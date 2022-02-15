# Monitor Power BI Report Server.

### Este projeto tem objetivo de criar uma estrutura de documentação, monitoramento e auditoria do servidor local de Power BI Report Server.

### Observação:
O Power BI Report Server é uma adaptação do antigo SQL Server Report Server SSRS, com isto as tabelas são muito parecidas.

### Para se instalar o Power BI Report Server é preciso ter uma licença do SQL Server.

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

Diagrama de dados da base do Power BI Report Server.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/diagramaDadosPBIRS.PNG?raw=true)


## Destino dos dados.
### O dados seram migrado para uma base rodando dentro SQL Server, mantendo a compatibilidade de SGBD, poderia ser utilizado outro SGBD para receber o dados? Sim totalmente possível.

### Estrutura de dados de destino.

### Tabelas:
<table>
  <td>aaa
    <tr>bbb <\tr>
  <\td>
<\table>
