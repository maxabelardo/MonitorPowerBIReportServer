# Projeto de ETL no Visual Studio 2017.

Como o objetivo do projeto é manter uma base do histórico dos objetos. sendo assim o ETL tem que executar uma comparação entre a origem e o destino, o que complica um pouco o projeto.

O ELT será compost por vários steps, vamos detalhar cada uma deles neste documento.

### Visão geral do workflow.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/00-Projeto.PNG?raw=true)


#### Lista dos Data Flow Task.
<table>
  <tr align="center">
    <td width="30%">Data Flow Task</td>
    <td width="20%">Imagem</td>
    <td width="50%">Detalhamento</td>
  </tr>    
  <tr>
    <td>ETL start</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/000-etlStart.PNG"></td>
    <td>Alimenta a variável de ambiente com a data e hora do início do ETL.</td>
  </tr>
  <tr>
    <td>Pasta-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/010-pastas-00.PNG"></td>
    <td>Exração dos diretórios da origem.</td>
  </tr>
  <tr>
    <td>Objetos-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/020-Objetos-00.PNG"></td>
    <td>Exração dos painéis da origem.</td>
  </tr>  
  <tr>
    <td>Objetos-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/030-UserRole-00.PNG"></td>
    <td>Exração dos Usuários suas permissões.</td>
  </tr>  
  <tr>
    <td>Objetos-00</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/040-RoleUserAD.PNG"></td>
    <td>Verifica se existe algum usuário novo cadastrado, se existir cadastra na tabelas "RoleUserAD". </td>
  </tr>    
</table>
