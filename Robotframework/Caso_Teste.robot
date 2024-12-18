*** Settings ***
Documentation    Suite de Teste https://automationexercise.com  interface WEB(UI) + API

Resource    Resource_Exec.robot
Test Teardown    Fechar browser


*** Test Cases ***
WEB Test Case 1: Register User
    [tags]  TC_WEB_01       TC_WEB
    Condicao não ter usuario cadastrado: chamando api de delecao
    WEB 01: Launch browser 
    WEB 01: Navigate to url   http://automationexercise.com
    WEB 01: Verify that home page is visible successfully
    WEB 01: Click on 'Signup / Login' button
    WEB 01: Verify 'New User Signup!' is visible
    WEB 01: Enter name and email address    
    WEB 01: Click 'Signup' button
    WEB 01: Verify that 'ENTER ACCOUNT INFORMATION' is visible
    WEB 01: Fill details: Title, Name, Email, Password, Date of birth
    WEB 01: Select checkbox 'Sign up for our newsletter!'
    WEB 01: Select checkbox 'Receive special offers from our partners!'
    WEB 01: Fill details: First name, Last name, Company, Address, Address2, Country, State, City, Zipcode, Mobile Number
    WEB 01: Click 'Create Account button'
    WEB 01: Verify that 'ACCOUNT CREATED!' is visible
    WEB 01: Click 'Continue' button
    WEB 01: Verify that 'Logged in as username' is visible
    WEB 01: Click 'Delete Account' button
    WEB 01: Verify that 'ACCOUNT DELETED!' is visible and click 'Continue' button


WEB Test Case 2: Login User with correct email and password
    [tags]  TC_WEB_02       TC_WEB
    Condicao ter usuario cadastrado: chamando api de criacao 
    WEB 02: Launch browser 
    WEB 02: Navigate to url    http://automationexercise.com
    WEB 02: Verify that home page is visible successfully
    WEB 02: Click on 'Signup / Login' button
    WEB 02: Verify 'Login to your account' is visible    
    WEB 02: Enter correct email address and password   
    WEB 02: Click 'login' button
    WEB 02: Verify that 'Logged in as username' is visible
    WEB 02: Click 'Delete Account' button
    WEB 02: Verify that 'ACCOUNT DELETED!' is visible


WEB Test Case 3: Login User with incorrect email and password
    [tags]  TC_WEB_03       TC_WEB
    Condicao ter usuario cadastrado: chamando api de criacao 
    WEB 03: Launch browser
    WEB 03: Navigate to url    http://automationexercise.com
    WEB 03: Verify that home page is visible successfully
    WEB 03: Click on 'Signup / Login' button
    WEB 03: Verify 'Login to your account' is visible
    WEB 03: Enter incorrect email address and password    
    WEB 03: Click 'login' button
    WEB 03: Verify error 'Your email or password is incorrect!' is visible
    Condicao não ter usuario cadastrado: chamando api de delecao


WEB Test Case 4: Logout User
    [tags]  TC_WEB_04       TC_WEB
    Condicao ter usuario cadastrado: chamando api de criacao 
    WEB 04: Launch browser
    WEB 04: Navigate to url    http://automationexercise.com
    WEB 04: Verify that home page is visible successfully
    WEB 04: Click on 'Signup / Login' button
    WEB 04: Verify 'Login to your account' is visible
    WEB 04: Enter correct email address and password
    WEB 04: Click 'login' button
    WEB 04: Verify that 'Logged in as username' is visible
    WEB 04: Click 'Logout' button
    WEB 04: Verify that user is navigated to login page

WEB Test Case 5: Register User with existing email
    [tags]  TC_WEB_05       TC_WEB
    WEB 05: Launch browser
    WEB 05: Navigate to url    http://automationexercise.com
    WEB 05: Verify that home page is visible successfully
    WEB 05: Click on 'Signup / Login' button
    WEB 05: Verify 'New User Signup!' is visible
    WEB 05: Enter name and already registered email address
    WEB 05: Click 'Signup' button
    WEB 05: Verify error 'Email Address already exist!' is visible

WEB Test Case 6: Contact Us Form
    [tags]  TC_WEB_06       TC_WEB
    WEB 06: Launch browser
    WEB 06: Navigate to url    http://automationexercise.com
    WEB 06: Verify that home page is visible successfully
    WEB 06: Click on 'Contact Us' button
    WEB 06: Verify 'GET IN TOUCH' is visible
    WEB 06: Enter name, email, subject and message
    WEB 06: Upload file    /dados/API_14_Zerado.json 
    WEB 06: Click 'Submit' button
    WEB 06: Click OK button
    WEB 06: Verify success message 'Success! Your details have been submitted successfully.' is visible
    WEB 06: Click 'Home' button and verify that landed to home page successfully

WEB Test Case 7: Verify Test Cases Page
    [Tags]  TC_WEB_07       TC_WEB
    WEB 07: Launch browser
    WEB 07: Navigate to url    http://automationexercise.com
    WEB 07: Verify that home page is visible successfully
    WEB 07: Click on 'Test Cases' button
    WEB 07: Verify user is navigated to test cases page successfully

WEB Test Case 8: Verify All Products and product detail page
    [Tags]  TC_WEB_08       TC_WEB
    WEB 08: Launch browser
    WEB 08: Navigate to url    http://automationexercise.com
    WEB 08: Verify that home page is visible successfully
    WEB 08: Click on 'Products' button
    WEB 08: Verify user is navigated to ALL PRODUCTS page successfully
    WEB 08: The products list is visible
    WEB 08: Click on 'View Product' of first product
    WEB 08: User is landed to product detail page
    WEB 08: Verify that detail detail is visible: product name, category, price, availability, condition, brand

WEB Test Case 9: Search Product
    [Tags]  TC_WEB_09       TC_WEB
    WEB 09: Launch browser
    WEB 09: Navigate to url    http://automationexercise.com
    WEB 09: Verify that home page is visible successfully
    WEB 09: Click on 'Products' button
    WEB 09: Verify user is navigated to ALL PRODUCTS page successfully
    WEB 09: Enter product name in search input and click search button    Men Tshirt    
    WEB 09: Verify 'SEARCHED PRODUCTS' is visible
    WEB 09: Verify all the products related to search are visible

WEB Test Case 10: Verify Subscription in home page
    [Tags]  TC_WEB_10       TC_WEB
    WEB 10: Launch browser
    WEB 10: Navigate to url    http://automationexercise.com
    WEB 10: Verify that home page is visible successfully
    WEB 10: Scroll down to footer
    WEB 10: Verify text 'SUBSCRIPTION'
    WEB 10: Enter email address in input and click arrow button
    WEB 10: Verify success message 'You have been successfully subscribed!' is visible

WEB Test Case 11: Verify Subscription in Cart page
   [Tags]  TC_WEB_11       TC_WEB
    WEB 11: Launch browser
    WEB 11: Navigate to url    http://automationexercise.com
    WEB 11: Verify that home page is visible successfully
    WEB 11: Click 'Cart' button
    WEB 11: Scroll down to footer
    WEB 11: Verify text 'SUBSCRIPTION'
    WEB 11: Enter email address in input and click arrow button
    WEB 11: Verify success message 'You have been successfully subscribed!' is visible

WEB Test Case 12: Add Products in Cart
    [Tags]  TC_WEB_12       TC_WEB
    WEB 12: Launch browser
    WEB 12: Navigate to url    http://automationexercise.com
    WEB 12: Verify that home page is visible successfully
    WEB 12: Click 'Products' button
    WEB 12: Hover over first product and click 'Add to cart'    1
    WEB 12: Click 'Continue Shopping' button
    WEB 12: Hover over second product and click 'Add to cart'    1
    WEB 12: Click 'View Cart' button
    WEB 12: Verify both products are added to Cart
    WEB 12: Verify their prices, quantity and total price

WEB Test Case 13: Verify Product quantity in Cart
    [Tags]  TC_WEB_13       TC_WEB
    WEB 13: Launch browser
    WEB 13: Navigate to url    http://automationexercise.com
    WEB 13: Verify that home page is visible successfully
    WEB 13: Click 'View Product' for any product on home page    1
    WEB 13: Verify product detail is opened
    WEB 13: Increase quantity to    3
    WEB 13: Click 'Add to cart' button
    WEB 13: Click 'View Cart' button
    WEB 13: Verify that product is displayed in cart page with exact quantity

WEB Test Case 14: Place Order: Register while Checkout
    [Tags]  TC_WEB_14       TC_WEB
    Condicao não ter usuario cadastrado: chamando api de delecao
    WEB 14: Launch browser
    WEB 14: Navigate to url    http://automationexercise.com
    WEB 14: Verify that home page is visible successfully
    WEB 14: Add products to cart    
    WEB 14: 5. Click 'Cart' button
    WEB 14: Verify that cart page is displayed
    WEB 14: Click Proceed To Checkout
    WEB 14: Click 'Register / Login' button
    WEB 14: Fill all details in Signup and create account
    WEB 14: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 14: Verify ' Logged in as username' at top
    WEB 14: 12. Click 'Cart' button
    WEB 14: Click 'Proceed To Checkout' button
    WEB 14: Verify Address Details and Review Your Order
    WEB 14: Enter description in comment text area and click 'Place Order'
    WEB 14: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 14: Click 'Pay and Confirm Order' button
    WEB 14: Verify success message 'Your order has been placed successfully!'
    WEB 14: Click 'Delete Account' button
    WEB 14: Verify 'ACCOUNT DELETED!' and click 'Continue' button

WEB Test Case 15: Place Order: Register before Checkout
    [Tags]  TC_WEB_15       TC_WEB
    Condicao não ter usuario cadastrado: chamando api de delecao
    WEB 15: Launch browser
    WEB 15: Navigate to url    http://automationexercise.com
    WEB 15: Verify that home page is visible successfully
    WEB 15: Click 'Signup / Login' button
    WEB 15: Fill all details in Signup and create account
    WEB 15: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 15: Verify ' Logged in as username' at top
    WEB 15: Add products to cart
    WEB 15: Click 'Cart' button
    WEB 15: Verify that cart page is displayed
    WEB 15: Click Proceed To Checkout
    WEB 15: Verify Address Details and Review Your Order
    WEB 15: Enter description in comment text area and click 'Place Order'
    WEB 15: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 15: Click 'Pay and Confirm Order' button
    WEB 15: Verify success message 'Your order has been placed successfully!'
    WEB 15: Click 'Delete Account' button
    WEB 15: Verify 'ACCOUNT DELETED!' and click 'Continue' button

WEB Test Case 16: Place Order: Login before Checkout
    [Tags]  TC_WEB_16       TC_WEB 
    Condicao ter usuario cadastrado: chamando api de criacao
    WEB 16: Launch browser
    WEB 16: Navigate to url    http://automationexercise.com
    WEB 16: Verify that home page is visible successfully
    WEB 16: Click 'Signup / Login' button
    WEB 16: Fill email, password and click 'Login' button
    WEB 16: Verify 'Logged in as username' at top
    WEB 16: Add products to cart
    WEB 16: Click 'Cart' button
    WEB 16: Verify that cart page is displayed
    WEB 16: Click Proceed To Checkout
    WEB 16: Verify Address Details and Review Your Order
    WEB 16: Enter description in comment text area and click 'Place Order'
    WEB 16: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 16: Click 'Pay and Confirm Order' button
    WEB 16: Verify success message 'Your order has been placed successfully!'
    WEB 16: Click 'Delete Account' button
    WEB 16: Verify 'ACCOUNT DELETED!' and click 'Continue' button

WEB Test Case 17: Remove Products From Cart
    [Tags]  TC_WEB_17       TC_WEB 
    WEB 17: Launch browser
    WEB 17: Navigate to url    http://automationexercise.com
    WEB 17: Verify that home page is visible successfully
    WEB 17: Add products to cart
    WEB 17: Click 'Cart' button
    WEB 17: Verify that cart page is displayed
    WEB 17: Click 'X' button corresponding to particular product
    WEB 17: Verify that product is removed from the cart

WEB Test Case 18: View Category Products
    [Tags]  TC_WEB_18       TC_WEB 
    WEB 18: Launch browser
    WEB 18: Navigate to url    http://automationexercise.com
    WEB 18: Verify that categories are visible on left side bar
    WEB 18: Click on 'Women' category    Women    
    WEB 18: Click on any category link under 'Women' category, for example: Dress    Tops     
    WEB 18: Verify that category page is displayed and confirm text 'WOMEN - TOPS PRODUCTS'
    WEB 18: On left side bar, click on any sub-category link of 'Men' category    Men    Jeans 
    WEB 18: Verify that user is navigated to that category page

WEB Test Case 19: View & Cart Brand Products
    [Tags]  TC_WEB_19       TC_WEB
    WEB 19: Launch browser
    WEB 19: Navigate to url    http://automationexercise.com
    WEB 19: Click on 'Products' button  
    WEB 19: Verify that Brands are visible on left side bar
    WEB 19: Click on any brand name   H&M 
    WEB 19: Verify that user is navigated to brand page and brand products are displayed
    WEB 19: On left side bar, click on any other brand link    Polo    
    WEB 19: Verify that user is navigated to that brand page and can see products

WEB Test Case 20: Search Products and Verify Cart After Login
    [Tags]  TC_WEB_20       TC_WEB
    Condicao ter usuario cadastrado: chamando api de criacao
    WEB 20: Launch browser
    WEB 20: Navigate to url    http://automationexercise.com 
    WEB 20: Click on 'Products' button
    WEB 20: Verify user is navigated to ALL PRODUCTS page successfully
    WEB 20: Enter product name in search input and click search button     Men Tshirt     
    WEB 20: Verify 'SEARCHED PRODUCTS' is visible
    WEB 20: Verify all the products related to search are visible
    WEB 20: Add those products to cart    1
    WEB 20: Click 'Cart' button and verify that products are visible in cart
    WEB 20: Click 'Signup / Login' button and submit login details
    WEB 20: Again, go to Cart page
    WEB 20: Verify that those products are visible in cart after login as well

WEB Test Case 21: Add review on product
    [Tags]  TC_WEB_21       TC_WEB
    WEB 21: Launch browser
    WEB 21: Navigate to url    http://automationexercise.com
    WEB 21: Click on 'Products' button
    WEB 21: Verify user is navigated to ALL PRODUCTS page successfully
    WEB 21: Click on 'View Product' button
    WEB 21: Verify 'Write Your Review' is visible
    WEB 21: Enter name, email and review
    WEB 21: Click 'Submit' button
    WEB 21: Verify success message 'Thank you for your review.'

WEB Test Case 22: Add to cart from Recommended items
    [Tags]  TC_WEB_22       TC_WEB
    WEB 22: Launch browser
    WEB 22: Navigate to url    http://automationexercise.com
    WEB 22: Scroll to bottom of page
    WEB 22: Verify 'RECOMMENDED ITEMS' are visible
    WEB 22: Click on 'Add To Cart' on Recommended product
    WEB 22: Click on 'View Cart' button
    WEB 22: Verify that product is displayed in cart page

WEB Test Case 23: Verify address details in checkout page
    [Tags]  TC_WEB_23       TC_WEB
    Condicao não ter usuario cadastrado: chamando api de delecao
    WEB 23: Launch browser
    WEB 23: Navigate to url    http://automationexercise.com
    WEB 23: Verify that home page is visible successfully
    WEB 23: Click 'Signup / Login' button
    WEB 23: Fill all details in Signup and create account
    WEB 23: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 23: Verify ' Logged in as username' at top
    WEB 23: Add products to cart
    WEB 23: Click 'Cart' button
    WEB 23: Verify that cart page is displayed
    WEB 23: Click Proceed To Checkout
    WEB 23: Verify that the delivery address is same address filled at the time registration of account
    WEB 23: Verify that the billing address is same address filled at the time registration of account
    WEB 23: Click 'Delete Account' button
    WEB 23: Verify 'ACCOUNT DELETED!' and click 'Continue' button

WEB Test Case 24: Download Invoice after purchase order
    [Tags]  TC_WEB_24       TC_WEB
    Condicao não ter usuario cadastrado: chamando api de delecao
    WEB 24: Launch browser
    WEB 24: Navigate to url    http://automationexercise.com
    WEB 24: Verify that home page is visible successfully
    WEB 24: Add products to cart
    WEB 24: Click 'Cart' button
    WEB 24: Verify that cart page is displayed
    WEB 24: Click Proceed To Checkout
    WEB 24: Click 'Register / Login' button
    WEB 24: Fill all details in Signup and create account
    WEB 24: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 24: Verify ' Logged in as username' at top
    WEB 24: Click 'Cart' button.
    WEB 24: Click 'Proceed To Checkout' button
    WEB 24: Verify Address Details and Review Your Order
    WEB 24: Enter description in comment text area and click 'Place Order'
    WEB 24: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 24: Click 'Pay and Confirm Order' button
    WEB 24: Verify success message 'Your order has been placed successfully!'
    WEB 24: Click 'Download Invoice' button and verify invoice is downloaded successfully.
    WEB 24: Click 'Continue' button
    WEB 24: Click 'Delete Account' button
    WEB 24: Verify 'ACCOUNT DELETED!' and click 'Continue' button

WEB Test Case 25: Verify Scroll Up using 'Arrow' button and Scroll Down functionality
    [Tags]  TC_WEB_25       TC_WEB
    WEB 25: Launch browser
    WEB 25: Navigate to url    http://automationexercise.com
    WEB 25: Verify that home page is visible successfully
    WEB 25: Scroll down page to bottom
    WEB 25: Verify 'SUBSCRIPTION' is visible
    WEB 25: Click on arrow at bottom right side to move upward
    WEB 25: Verify that page is scrolled up and 'Full-Fledged practice website for Automation Engineers' text is visible on screen

WEB Test Case 26: Verify Scroll Up without 'Arrow' button and Scroll Down functionality
    [Tags]  TC_WEB_26       TC_WEB
    WEB 26: Launch browser
    WEB 26: Navigate to url    http://automationexercise.com
    WEB 26: Verify that home page is visible successfully
    WEB 26: Scroll down page to bottom
    WEB 26: Verify 'SUBSCRIPTION' is visible
    WEB 26: Scroll up page to top
    WEB 26: Verify that page is scrolled up and 'Full-Fledged practice website for Automation Engineers' text is visible on screen



API 01: Get All Products List
    [tags]   TC_API_01    TC_API
    Cria sessao
    API 01: Dispara requisicao
    API 01: Verifica Status code    200
    API 01: Verifica tipo Schema/Contrato    
    API 01: Verifica o Schema/Contrato modelo no caminho    /dados/modelo_contrato_API_01-02.json

API 02: POST To All Products List
    [tags]   TC_API_02    TC_API
    Cria sessao
    API 02: Dispara requisicao
    API 02: Verifica Status code    200    
    API 02: Verifica Response Code     405    This request method is not supported. 

API 03: Get All Products List
    [tags]   TC_API_03    TC_API
    Cria sessao
    API 03: Dispara requisicao
    API 03: Verifica Status code    200
    API 03: Verifica Response Code    200
    API 03: Verifica tipo Schema/Contrato    
    API 03: Verifica o Schema/Contrato modelo no caminho    /dados/modelo_contrato_API_03.json
    API 03: Verifica se no retorno vem somente valor esperado    brands 
    
API 04: Get All Products List
    [tags]   TC_API_04    TC_API
    Cria sessao
    API 04: Dispara requisicao
    API 04: Verifica Status code    200
    API 04: Verifica Response Code     405    This request method is not supported.

API 11: POST To Create/Register User Account 
    [tags]   TC_API_05    TC_API
    Cria sessao
    API 11: Dispara requisicao   /dados/dados_para_cadastro.json    /dados/API_11.json
    API 11: Verifica Status code    200
    API 11: Verifica Response Code     201    User created!

API 13: PUT METHOD To Update User Account
    [tags]   TC_API_06    TC_API
    Cria sessao 
    API 13: Dispara requisicao de atualização de endereco    Rua Dois    /dados/dados_para_cadastro.json    /dados/API_11.json    /dados/API_13.json    
    API 13: Verifica Status code    200
    API 13: Verifica Response Code     200    User updated!

API 5: POST To Search Product
    [tags]   TC_API_07    TC_API
    Cria sessao
    API 05: Dispara requisicao     tshirt 
    API 05: Verifica Status code     200
    API 05: Verifica Response Code     200
    API 05: Verifica retorno dados cadastro
    API 05: Verifica o Schema/Contrato modelo no caminho    /dados/modelo_contrato_API_05.json 

API 6: POST To Search Product without search_product parameter
    [tags]   TC_API_08    TC_API
    Cria sessao
    API 06: Dispara requisicao
    API 06: Verifica Status code    200    
    API 06: Verifica Response Code     400    Bad request, search_product parameter is missing in POST request.


API 7: POST To Search Product without search_product parameter
    [tags]   TC_API_09    TC_API
    Cria sessao
    API 07: Dispara requisicao    /dados/API_11.json    /dados/dados_para_cadastro.json
    API 07: Verifica Status code    200    
    API 07: Verifica Response Code     200    User exists!


API 8: POST To Verify Login without email parameter
    [tags]   TC_API_10    TC_API
    Cria sessao
    API 08: Dispara requisicao    /dados/dados_para_cadastro.json
    API 08: Verifica Status code    200    
    API 08: Verifica Response Code     400    Bad request, email or password parameter is missing in POST request.

API 9: DELETE To Verify Login
    [tags]   TC_API_11    TC_API
    Cria sessao
    API 09: Dispara requisicao
    API 09: Verifica Status code    200    
    API 09: Verifica Response Code     405    This request method is not supported.

API 10: POST To Search Product without search_product parameter
    [tags]   TC_API_12    TC_API
    Cria sessao
    API 10: Dispara requisicao    /dados/API_11.json    
    API 10: Verifica Status code    200    
    API 10: Verifica Response Code     404    User not found!

API 14: GET user account detail by email
    [tags]   TC_API_13    TC_API
    Cria sessao
    API 14: Dispara requisicao    /dados/API_11.json 
    API 14: Verifica Status code    200
    API 14: Verifica Response Code    200
    API 14: Verifica retorno dados cadastro   /dados/API_11.json     
    API 14: Verifica o Schema/Contrato modelo no caminho    /dados/modelo_contrato_API_14.json

API 12: DELETE METHOD To Delete User Account
    [tags]   TC_API_14    TC_API
    Cria sessao
    API 12: Dispara requisicao    /dados/API_11.json    /dados/dados_para_cadastro.json
    API 12: Verifica Status code    200    
    API 12: Verifica Response Code     200    Account deleted!
