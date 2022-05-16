# Monitor Power BI Report Server.

### Este projeto tem objetivo de criar uma estrutura de documentação, monitoramento e auditoria do servidores locais de Power BI Report Server.

#### O que é o Power BI Report Server
O Servidor de Relatórios do Power BI é a solução na infraestrutura local para criar relatórios hoje, com a flexibilidade para mover para a nuvem amanhã. Ele é incluído com o Power BI Premium, para que você possa mover para a nuvem de acordo com suas necessidades.

O Pewer BI Report Server é um portal da Web no qual você pode exibir e gerenciar relatórios e KPIs. Com ele, vêm as ferramentas para criar relatórios do Power BI, relatórios paginados, relatórios móveis e KPIs. Seus usuários podem acessar esses relatórios de maneiras diferentes: exibindo-os em um navegador da Web ou dispositivo móvel, ou como um email em sua caixa de entrada

#### Publicar relatórios na infraestrutura local do Power BI
O Servidor de Relatórios fornece aos usuários acesso a relatórios avançados e interativos e a funcionalidades de criação de relatórios corporativos do SQL Server Reporting Services. Explore dados visuais e descubra rapidamente padrões para tomar decisões melhores com mais rapidez. Ao mesmo tempo, gere os relatórios paginados de pixels perfeitos de que seus negócios precisam. Você também pode escalonar com confiança para milhares de usuários, pois o Servidor de Relatórios do Power BI é baseado em uma plataforma comprovada de nível corporativo.

#### Comparando o Servidor de Relatórios do Power BI
O Servidor de Relatórios do Power BI é semelhante ao SQL Server Reporting Services e ao serviço do Power BI online, mas de maneiras diferentes. Assim como o serviço do Power BI, o Servidor de Relatórios do Power BI hospeda relatórios do Power BI (.pbix), arquivos do Excel e relatórios paginados (.rdl). Assim como o Reporting Services, o Servidor de Relatórios do Power BI é local. Os recursos do Servidor de Relatórios do Power BI são um superconjunto do Reporting Services: tudo o que você pode fazer no Reporting Services, pode fazer com o Servidor de Relatórios do Power BI, além do suporte para relatórios do Power BI.

#### Licenciando o Servidor de Relatórios do Power BI
O Servidor de Relatórios do Power BI está disponível por meio de duas licenças diferentes: __Power BI Premium__ e __SQL Server Enterprise Edition com Software Assurance__. Confira Licenciamento por Volume da Microsoft. Com uma licença do Power BI Premium, você pode criar uma implantação híbrida combinando recursos locais e na nuvem.

_Se você publicar os relatórios do Power BI no Servidor de Relatórios do Power BI, também precisará de uma licença do Power BI Pro. Você não precisa de uma licença do Power BI Pro para exibir e interagir com os relatórios do Power BI no Servidor de Relatórios do Power BI._

#### O que é SQL Server Enterprise Edition com Software Assurance?
É o licenciamento do SQL Server, com a licença do SQL Server é possível instalar um Power BI Report Server.

#### O que é o Power BI Premium?
Você pode usar o Power BI Premium para acessar recursos e funcionalidades disponíveis apenas no Premium e oferecer maior escala e melhor desempenho para o conteúdo do Power BI na sua organização. O Power BI Premium permite que mais usuários na organização aproveitem ao máximo o Power BI com melhor desempenho e capacidade de resposta.
O Power BI Premium é uma assinatura do Microsoft 365 de nível de locatário disponível em duas famílias de SKU (Unidade de Manutenção de Estoque):
* SKUs P (P1-P5) para recursos corporativos e de inserção, exigindo um compromisso mensal ou anual, cobrado mensalmente, com a inclusão de uma licença para instalar o Servidor de Relatórios do Power BI local.
* SKUs EM (EM1-EM3) para inserção organizacional, exigindo um compromisso anual cobrado mensalmente. Os SKUs EM1 e EM2 estão disponíveis somente por meio de planos de licenciamento por volume. Não é possível comprá-los diretamente.


## Como funcionará o projeto!

O projeto será divido em três partes: Base de origem __"ReportServer"__, Base de destino __"MonitorPowerBI"__ e a extração dos dados __"ETL"__

