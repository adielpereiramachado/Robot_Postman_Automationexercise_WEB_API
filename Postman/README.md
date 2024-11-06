**Este conteúdo é o resultado da intenção de demonstrar na prática como realizo e organizo os artefatos utilizados em um teste API utilizando Postman, Newman e Git Actions.**

**Para execução dos testes será necessário 3 software/ferramentas: Postman, Node.js e Newman.**

- Postman:
  
**O Postman pode ser instalado no seu computador, para mais informações, acesse: https://www.postman.com  
Como opção pode ser utilizado a versão WEB acessando no mesmo link citado acima (foi a que optei).
Na data deste post, a versão utilizada do Postman Web é: 11.18.1-241106-0747**


- Node.js:
  
**Para instalar o Node.js no seu computador, acesse o site abaixo e siga o passo a passo:
https://nodejs.org/en/


- Newman:

**Para instalar o Newman no seu computador,  execute em um console:
```bash
npm install -g newman
```
Para verificar que a instalação ocorreu com sucesso, execute o comando abaixo, onde deverá exibir a versão instalada: 
```bash
newman --version
```
Para mim exibiu na data deste post, a versão: 6.2.1


-------------




**O conteúdo está organizado da seguinte maneira:**

- Postman: 
**Os arquivos "API_automationexercise.postman_collection.json" e "VAR_API.postman_environment.json", podem ser importados diretamente no Postman e executado os testes, onde terá o resultado dos testes como exibido abaixo:**

![Postman](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Postman/Arquivos%20de%20apoio/Postman.png)


- Newman:
**Os mesmos arquivos podem ser usados para execução do script com Newman. Para tanto, basta abrir um console de comando (cmd ou konsole) e executar o comando abaixo:**

```bash
newman run API_automationexercise.postman_collection.json -e VAR_API.postman_environment.json -r cli,htmlextra
```

**Depois de executado terá o resultado dos testes como exibido abaixo:**

![Newman](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Postman/Arquivos%20de%20apoio/Newman.png)




