# Monitor Power BI Report Server.

## Este projeto tem objetivo de criar uma estrutura de documentação, monitoramento e auditoria do servidor local de Power BI Report Server.

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
