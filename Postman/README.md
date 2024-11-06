###  Teste utilizando Postman e Newman : REST API Automation Exercise :
**Os testes foram apontando para o site Automation Exercise: ( https://automationexercise.com ).**

![Página do teste](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Postman/Arquivos%20de%20apoio/Site%20Automation%20Exercise.png)

**Este conteúdo é o resultado da intenção de demonstrar na prática como realizo e organizo os artefatos utilizados em um teste API utilizando Postman, Newman e Git Actions.**

------------


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




