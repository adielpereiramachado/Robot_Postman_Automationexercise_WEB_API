<h1 align="center">Robotframework - Postman - Newman - Github Actions</h1>


#### Objetivo da Divulgação

Este repositório tem o objetivo de:

1. **Ajudar Testadores Iniciantes**:
   Compartilhando este projeto de testes automatizados espero demonstrar um exemplo prático e didático para aqueles que estão começando a trabalhar com automação de testes de software. O intuito é facilitar o aprendizado e fornecer um ponto de partida para quem deseja se familiarizar com as melhores práticas e ferramentas utilizadas nesta área.

2. **Expor meu modo de trabalho e meu código**:
   Ao divulgar este repositório, também desejo expor a forma como eu estruturo e implemento os testes automatizados em meus projetos. Desta maneira, ficarei grato em receber críticas e/ou sugestões de melhorias.

------

Este repositório contém o código de scripts de testes automatizados para um projeto de site público na internet 'Automation Exercise': ( https://automationexercise.com ).

Escolhi este site para usar nos testes, pois com ele foi possível realizar tanto os testes de interface web (UI) quanto os de API. Além de no próprio site conter lista com itens a serem verificados tanto no escopo UI quanto API.

![Página com Lista](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Site_lista_teste.png)


Como citado anteriormente os testes abrangem interface web (UI) e API. 

Para os testes de interface web (UI) eu utilizei o Robotframework, onde também utilizei para fazer teste de API.

Para uma outra abordagem de teste em API, utilizei o Postman & Newman.

E uma demonstração de Integração Contínua executei os testes escritos em Postman & Newman no Github Actions.

- Robot Framework para testes de interface web (UI) e de API;
- Postman e Newman para testes de API;
- GitHub Actions executando os scripts do Postman & Newman para Integração Contínua.

### Estrutura do Repositório

O repositório está organizado da seguinte forma:

- `Robotframework/`: Contém os scripts de testes de interface web (UI) usando Robot Framework.
- `Postman/`: Contém os scripts de API usando Postman & Newman e os mesmos para serem consumidos no Github Actions.
- `.github/workflows/`: Contém a configuração do GitHub Actions para execução dos testes.
- `Arquivos de apoio/`: Contém arquivos com imagens para os Readme.


### Como Executar os Testes

Instruções detalhadas sobre como executar os testes estão disponíveis nos respectivos subdiretórios. Consulte os READMEs individuais para obter mais informações.

### Contribuição

Contribuições são bem-vindas! Se você encontrar algum problema ou tiver sugestões de melhoria, sinta-se à vontade para abrir uma nova issue ou enviar um e-mail: adielmachado@yahoo.com.br
