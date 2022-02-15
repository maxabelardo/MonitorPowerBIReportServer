# Projeto de ETL no Visual Studio 2017.

Como o objetivo do projeto é manter uma base do histórico dos objetos. sendo assim o ETL tem que executar uma comparação entre a origem e o destino, o que complica um pouco o projeto.

O ELT será compost por vários steps, vamos detalhar cada uma deles neste documento.

### Visão geral do workflow.
![alt text](https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/00-Projeto.PNG?raw=true)


#### Lista dos Data Flow Task.
<table>
  <tr align="center">
    <td width="20%">Data Flow Task</td>
    <td colspan="3" width="40%">Imagem</td>
    <td width="40%">Detalhamento</td>
  </tr>    
  <tr>
    <td>ETL start</td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/000-etlStart.PNG" height="50" width="1000"></td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/001-etlStart.PNG"></td>
    <td><img src="https://github.com/maxabelardo/MonitorPowerBIReportServer/blob/main/ETL-visualStudio/002-etlStart.PNG"></td>
    <td>Alimenta a variável de ambiente com a data e hora do início do ETL.</td>
  </tr>
</table>
