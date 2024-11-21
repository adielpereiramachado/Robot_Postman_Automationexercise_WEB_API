# Postman - Newman - Github Actions #

### Objetivo ###

Este conteúdo é o resultado da intenção de demonstrar na prática como realizo teste em API e organizo os artefatos, utilizando Postman, Newman e Git Actions.

Vale reforçar que para os testes utilizei uma API pública da qual não sou autor de URL: https://automationexercise.com/api e foram realizados todos os desafios contidos no Site: https://automationexercise.com. 


![Site_Teste_API](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Site_Teste_API.png)

Aproveito para agradecer aos autores a publicação do Site e dos serviços nele contidos.

-------------

### Preparação do ambiente ###

Para execução dos testes será necessário 3 software/ferramentas: Postman, Node.js e Newman.

**- Postman**:
  
O Postman pode ser instalado no seu computador, para mais informações, acesse: https://www.postman.com  
Como opção pode ser utilizado a versão WEB acessando no mesmo link citado acima (foi a que optei).
Na data deste post, a versão utilizada do Postman Web é: 11.18.1-241106-0747


**- Node.js**:
  
Para instalar o Node.js no seu computador, acesse o site abaixo e siga o passo a passo:
https://nodejs.org/en/


**- Newman**:

Para instalar o Newman no seu computador,  execute em um console:
```bash
npm install -g newman
```
Para verificar que a instalação ocorreu com sucesso, execute o comando abaixo, onde deverá exibir a versão instalada:
```bash
newman --version
```
Para mim exibiu na data deste post, a versão: 6.2.1


-------------

### Organização e Execução do teste ###


O conteúdo está organizado para execução da seguinte maneira:

**- Postman**: Os arquivos "API_automationexercise.postman_collection.json" e "VAR_API.postman_environment.json", podem ser importados diretamente no Postman e executado os testes, onde terá o resultado dos testes como exibido abaixo:

![Postman](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Postman.png)


**- Newman**: Os mesmos arquivos podem ser usados para execução do script com Newman. Para tanto, basta abrir um console de comando (cmd ou konsole) e executar o comando abaixo:

```bash
newman run API_automationexercise.postman_collection.json -e VAR_API.postman_environment.json -r cli,htmlextra
```

Depois de executado terá o resultado dos testes como exibido abaixo:

![Newman](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Newman.png)


-------------

### Execução do teste Github Actions ###

- Github: Uma vez configurada o workflow, em havendo algum evento que dispare os teste, o Github Actions executa os testes e tive os resultados como exibido abaixo, onde durou 26 segundos e mais abaixo tem link para relatórios de execução do Newman:

![Github_action](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Git_Actions.png)

![Github_action_Dash](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Git_Actions_Newman_Dash.png)

![Github_action_Req](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Git_Actions_Newman_Req.png)


