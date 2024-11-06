# Teste utilizando Postman e Newman : REST API Automation Exercise :
## Os testes foram apontando para o site Automation Exercise: https://automationexercise.com
![Página do teste](https://github.com/adielpereiramachado/Github_Cursos/blob/main/Desafios/ladybug.png)
![homepage](https://user-images.githubusercontent.com/124753072/235929032-4471bd18-9133-46ae-84da-931f0d94bb35.jpg)

O projeto foi feito para praticar habilidades de teste de API no Postman. Testes automatizados foram escritos para os cenários de teste mostrados abaixo. Os testes foram executados diretamente no aplicativo Postman e por meio da linha de comando Collection Runner (Newman), que permite executar e testar uma coleção Postman diretamente da linha de comando.

## :one: Postman:
![postman_x](https://user-images.githubusercontent.com/124753072/236633314-80ae1e22-8cdc-4e73-997d-aac1bd801f81.jpg)
## :two: Newman:
` newman run AutomationExercise_API_Testing.postman_collection.json -e AutomationExercise.postman_environment.json `

![newmanX1](https://user-images.githubusercontent.com/124753072/236633835-dd52103d-98df-4b2b-b184-f1589b0626d7.jpg)
![newman_7-13](https://user-images.githubusercontent.com/124753072/236633759-ade9b709-d3f8-48ba-bd98-4b6e4ca045f3.jpg)
![newman_14](https://user-images.githubusercontent.com/124753072/236633760-dc241205-245b-4062-b226-689640bf3a6c.jpg)

## :white_check_mark: API 1: Get All Products List
* API URL: https://automationexercise.com/api/productsList
* Request Method: GET
* Response Code: 200
* Response JSON: All products list

## :white_check_mark: API 2: POST To All Products List
* API URL: https://automationexercise.com/api/productsList
* Request Method: POST
* Response Code: 405
* Response Message: This request method is not supported.

## :white_check_mark: API 3: Get All Brands List
* API URL: https://automationexercise.com/api/brandsList
* Request Method: GET
* Response Code: 200
* Response JSON: All brands list

## :white_check_mark: API 4: PUT To All Brands List
* API URL: https://automationexercise.com/api/brandsList
* Request Method: PUT
* Response Code: 405
* Response Message: This request method is not supported.

## :white_check_mark: API 5: POST To Search Product
* API URL: https://automationexercise.com/api/searchProduct
* Request Method: POST
* Request Parameter: search_product (For example: top, tshirt, jean)
* Response Code: 200
* Response JSON: Searched products list

## :white_check_mark: API 6: POST To Search Product without search_product parameter
* API URL: https://automationexercise.com/api/searchProduct
* Request Method: POST
* Response Code: 400
* Response Message: Bad request, search_product parameter is missing in POST request.

## :white_check_mark: API 7: POST To Verify Login with valid details
* API URL: https://automationexercise.com/api/verifyLogin
* Request Method: POST
* Request Parameters: email, password
* Response Code: 200
* Response Message: User exists!

## :white_check_mark: API 8: POST To Verify Login without email parameter
* API URL: https://automationexercise.com/api/verifyLogin
* Request Method: POST
* Request Parameter: password
* Response Code: 400
* Response Message: Bad request, email or password parameter is missing in POST request.

## :white_check_mark: API 9: DELETE To Verify Login
* API URL: https://automationexercise.com/api/verifyLogin
* Request Method: DELETE
* Response Code: 405
* Response Message: This request method is not supported.

## :white_check_mark: API 10: POST To Verify Login with invalid details
* API URL: https://automationexercise.com/api/verifyLogin
* Request Method: POST
* Request Parameters: email, password (invalid values)
* Response Code: 404
* Response Message: User not found!

## :white_check_mark: API 11: POST To Create/Register User Account
* API URL: https://automationexercise.com/api/createAccount
* Request Method: POST
* Request Parameters: name, email, password, title (for example: Mr, Mrs, Miss), birth_date, birth_month, birth_year, firstname, lastname, company, address1, address2, country, zipcode, state, city, mobile_number
* Response Code: 201
* Response Message: User created!

## :white_check_mark: API 12: DELETE METHOD To Delete User Account
* API URL: https://automationexercise.com/api/deleteAccount
* Request Method: DELETE
* Request Parameters: email, password
* Response Code: 200
* Response Message: Account deleted!

## :white_check_mark: API 13: PUT METHOD To Update User Account
* API URL: https://automationexercise.com/api/updateAccount
* Request Method: PUT
* Request Parameters: name, email, password, title (for example: Mr, Mrs, Miss), birth_date, birth_month, birth_year, firstname, lastname, company, address1, address2, country, zipcode, state, city, mobile_number
* Response Code: 200
* Response Message: User updated!

## :white_check_mark: API 14: GET user account detail by email
* API URL: https://automationexercise.com/api/getUserDetailByEmail
* Request Method: GET
* Request Parameters: email
* Response Code: 200
* Response JSON: User Detail
