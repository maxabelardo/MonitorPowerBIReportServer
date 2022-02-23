# Projeto de ETL no Visual Studio 2017.

Como o objetivo do projeto é manter uma base do histórico dos objetos. sendo assim o ETL tem que executar uma comparação entre a origem e o destino, o que complica um pouco o projeto.

O ELT será compost por vários steps, vamos detalhar cada uma deles neste documento.

### Visão geral do workflow.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/_00-Projeto.PNG?raw=true)


#### Lista dos Data Flow Task.

<table>
  <tr align="center">
    <td width="30%">Data Flow Task</td>
    <td width="20%">Imagem</td>
    <td width="50%">Detalhamento</td>
    <td width="50%">Tabela de destino</td>
  </tr>    
  <tr>
    <td>ETL start</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/000-etlStart.PNG"></td>
    <td>Alimenta a variável de ambiente com a data e hora do início do ETL.</td>
    <td></td>
  </tr>
  <tr>
    <td>Pasta-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/010-pastas-00.PNG"></td>
    <td>Exração dos diretórios da origem.</td>
    <td>Pasta</td>
  </tr>
  <tr>
    <td>Objetos-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/020-Objetos-00.PNG"></td>
    <td>Exração dos painéis da origem.</td>
    <td>Objeto</td>
  </tr>  
  <tr>
    <td>UserRole-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/030-UserRole-00.PNG"></td>
    <td>Exração dos Usuários com o acesso aos objetos.</td>
    <td>RoleUser</td>
  </tr>  
  <tr>
    <td>RoleUserAD</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/040-RoleUserAD.PNG"></td>
    <td>Verifica se existe algum usuário novo cadastrado, se existir cadastra na tabelas "RoleUserAD". </td>
    <td>RoleUserAD</td>
  </tr>    
  <tr>
    <td>ObjetoRoleUser</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/050-ObjetoRoleUser.PNG"></td>
    <td>Extrai as permissões dos usuários aos objetos.</td>
    <td>ObjetoRoleUser</td>
  </tr>      
  <tr>
    <td>ObjetoRoleUser</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/imagens/050-ObjetoRoleUser.PNG"></td>
    <td>Extrai as permissões dos usuários aos objetos.</td>
    <td>ObjetoRoleUser</td>
  </tr>      
  
</table>
