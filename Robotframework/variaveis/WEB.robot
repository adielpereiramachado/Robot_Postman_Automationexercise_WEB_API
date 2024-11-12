*** Variables ***
${HOME_BUNNER_PRINCIPAL}                        //img[contains(@alt,'Website for automation practice')]
${HOME_SIGNUP_LOGIN}                            //a[contains(.,'Signup / Login')]
${HOME_LBL_LOGIN_TO_YOUR_ACCOUNT}                  //h2[contains(.,'Login to your account')]
${HOME_INPUT_EMAIL}                                //input[contains(@data-qa,'login-email')]
${HOME_INPUT_SENHA}                            //input[contains(@type,'password')]  
${HOME_BTN_LOGIN}                              //button[@type='submit'][contains(.,'Login')]    
${HOME_BTN_CONTACT_US}                         //a[contains(.,'Contact us')]     
${HOME_BTN_TESTE_CASES}                        //a[@href='/test_cases'][contains(.,'Test Cases')]
${HOME_BTN_PRODUCTS}                            //a[contains(.,' Products')]
${HOME_LBL_SUBSCRIPTION}                               //h2[contains(.,'Subscription')]
${HOME_INPUT_SUBSCRIPTION}                               //input[@type='email'][contains(@id,'email')]
${HOME_BTN_SUBMIT_SUBSCRIPTION}                         //button[contains(@type,'submit')]
${HOME_LSL_MSG_SUBMIT_SUBSCRIPTION_SUCESS}              //div[@class='alert-success alert'][contains(.,'You have been successfully subscribed!')]
${HOME_BTN_CART}                                        //a[contains(.,'Cart')]
${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_1}                 (//h4[contains(@class,'panel-title')])[1]
${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_1/2}               //a[@data-toggle='collapse'][contains(.,'
${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_2/2}               ')]
${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_SUB_1/2}            //a[contains(.,'
${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_SUB_2/2}            ')]


${HOME_BRANDS_QUADRO_BRANDS}                             //div[@class='brands-name']
${HOME_BRANDS_LADO_ESQUERDO_OPCAO_1/2}                   //a[contains(.,'   
${HOME_BRANDS_LADO_ESQUERDO_OPCAO_2/2}                   ')]
${HOME_BRANDS_BTN_VIEW_PRODUCT_EXIBIDO_MENU_1/2}         (//a[contains(.,'View Product')])[
${HOME_BRANDS_BTN_VIEW_PRODUCT_EXIBIDO_MENU_2/2}         ]
${HOME_LBL_RECOMMENDED_ITEMS}                             //h2[@class='title text-center'][contains(.,'recommended items')]
${HOME_LBL_NOME_DO_PRODUTO_SELECIONADO}                   (//p[contains(.,'Blue Top')])[3]
${HOME_BTN_CART_PARTE_RECOMENDACOES}                    (//a[@data-product-id='1'][contains(.,'Add to cart')])[3]
${HOME_BTN_SETA_PRA_CIMA}                               //i[contains(@class,'fa fa-angle-up')]
${HOME_LBL_BANNER_ENGINEERS}                           //div[@id='slider-carousel']/div/div[1]/div[1]/h2
${HOME_LBL_BANNER_ENGINEERS_1/2}                           //div[@id='slider-carousel']/div/div[
${HOME_LBL_BANNER_ENGINEERS_2/2}                           ]/div[1]/h2
${HOME_BANNER_HOST_RODAPE}                             //div[contains(@class,'grippy-host')]


${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_INTEIRO}                        //h2[contains(@class,'title')]     
${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}                          //div[@class='google-anno-skip google-anno-sc']       


${LOGIN_LBL_NEW_USER_SIGNUP}                            //h2[contains(.,'New User Signup!')]
${LOGIN__INPUT_USUARIO}                            //input[contains(@type,'text')]
${LOGIN_INPUT_EMAIL}                            //input[contains(@data-qa,'signup-email')]
${LOGIN_BTN_SIGNUP}                                    //button[@type='submit'][contains(.,'Signup')]
${LOGIN_LABEL_ENTER_ACCOUNT_INFORMATION}              //b[contains(.,'Enter Account Information')]
${LOGIN_RADIO_BTN_TITLE}                                //input[@type='radio'][contains(@id,'gender1')]
${LOGIN_INPUT_PASSWORD}                            //input[contains(@type,'password')]
${LOGIN_LIST_DATE_DAY}                            //select[contains(@data-qa,'days')]
${LOGIN_LIST_DATE_MONTH}                        //select[contains(@data-qa,'months')]
${LOGIN_LIST_DATE_YEAR}                          //select[contains(@data-qa,'years')]
${LOGIN_SELECT_SIGN_UP_FOR_OUR_NEWSLETTER}        //input[contains(@name,'newsletter')]
${LOGIN_SELECT_RECEIVE_SPECIAL_OFFERS_FROM_OUR_PARTNERS}        //input[contains(@name,'optin')]   
${LOGIN_INPUT_FIRST_NAME}                            //input[contains(@data-qa,'first_name')]
${LOGIN_INPUT_LAST_NAME}                            //input[contains(@data-qa,'last_name')]
${LOGIN_INPUT_COMPANY}                               //input[contains(@data-qa,'company')]
${LOGIN_INPUT_ADDRESS}                                //input[contains(@data-qa,'address')]
${LOGIN_INPUT_ADDRESS_2}                            //input[contains(@data-qa,'address2')] 
${LOGIN_INPUT_COUNTRY}                            //select[contains(@data-qa,'country')]
${LOGIN_INPUT_STATE}                                //input[contains(@data-qa,'state')]
${LOGIN_INPUT_CITY}                                //input[contains(@data-qa,'city')]
${LOGIN_INPUT_ZIPCODE}                            //input[contains(@data-qa,'zipcode')]
${LOGIN_INPUT_MOBILE_NUMBER}                        //input[@type='text'][contains(@id,'number')]
${lOGIN_LBL_SUBSCRIPTION}                        //h2[contains(.,'Subscription')]
${LOGIN_BTN_CREATE_ACCOUNT}                        //button[@type='submit'][contains(.,'Create Account')]
${LOGIN_BTN_CREATE_ACCOUNT_JAVASCRIPT}              document.querySelector("button[data-qa='create-account']").click()
${LOGIN_LBL_ACCOUNT_CREATED}                        //b[contains(.,'Account Created!')]
${LOGIN_BTN_CONTINUE}                              //a[contains(@data-qa,'continue-button')] 
${LOGIN_LBL_LOGGED_IN_A_USERNAME}                   //b[contains(.,'Nome b')]
${LOGIN_BTN_DELETE_ACCOUNT}                         //a[contains(.,'Delete Account')]
${LOGIN_LBL_ACCOUNT_DELETED}                            //b[contains(.,'Account Deleted!')]
${LOGIN_BTN_CONTINUE}                                //a[contains(.,'Continue')]
${LOGIN_LBL_PASSWORD_IS_INCORRECT}                    //p[contains(.,'Your email or password is incorrect!')]
${LOGIN_BTN_LOGOUT}                                    //a[contains(.,'Logout')]
${LOGIN_LBL_EMAIL_ALREADY_EXIST}                      //p[contains(.,'Email Address already exist!')]
${LOGIN_LBL_LOGOUT}                            //img[contains(@alt,'Website for automation practice')]  


${CONTACT_LBL_GET_IN_TOUCH}                            //h2[@class='title text-center'][contains(.,'Get In Touch')]
${CONTACT_INPUT_NAME}                               //input[contains(@name,'name')]
${CONTACT_INPUT_EMAIL}                             //input[contains(@data-qa,'email')]
${CONTACT_INPUT_SUBJECT}                            //input[contains(@data-qa,'subject')]
${CONTACT_INPUT_MESSAGE}                            //textarea[contains(@name,'message')]
${CONTACT_UPLOAD_LOCATOR}                                //input[contains(@type,'file')]      
${CONTACT_UPLOAD_SUBMIT}                                            //input[contains(@type,'submit')]
${CONTACT_LBL_SUBMITTED_SUCCESSFULLY}                    //div[@class='status alert alert-success'][contains(.,'Success! Your details have been submitted successfully.')]
${CONTACT_BTN_HOME}                                    //a[@class='btn btn-success'][contains(.,'Home')]


${TESTE_CASE_LBL_TEST_CASES}                        //b[contains(.,'Test Cases')]


${PRODUCTS_LBL_ALL_PRODUCTS}                        //h2[@class='title text-center'][contains(.,'All Products')]
${PRODUCTS_LBL_LIST_PRODUCTS}                    //div[@class='features_items']
${PRODUCTS_BTN_VIEW_PRODUCT_1}                    (//a[contains(text(), 'View Product')])[1]
${PRODUCTS_BTN_VIEW_PRODUCT_X_web13_1/2}                    (//a[contains(@href,'details/
${PRODUCTS_BTN_VIEW_PRODUCT_X_web13_2/2}                    ')])[1]
${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_1/2}                    //h2[contains(.,' 
${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_2/2}                    ')]
${PRODUCTS_LBL_SUBSCRIPTION}                        //h2[contains(.,'Subscription')]
${PRODUCTS_LBL_NOME_PRODUTO_X_1/2}                 (//div[contains(@class,'features_items')]//div[@class='productinfo text-center']/p)[
${PRODUCTS_LBL_NOME_PRODUTO_X_2/2}                 ]
${PRODUCTS_BTN_VIEW_PRODUCT_X_1/2}                    //h2[contains(.,'  
${PRODUCTS_BTN_VIEW_PRODUCT_X_2/2}                    ')]   
${PRODUCTS_LBL_WRITE_YOUR_REVIEW}                //a[contains(@data-toggle,'tab')]   
${PRODUCTS_DETAILS_LBL_NOME_PRODUTO}           //div[contains(@class,'product-information')]/h2
${PRODUCTS_DETAILS_LBL_CATEGORY}                       //p[starts-with(.,'Category:')]
${PRODUCTS_DETAILS_LBL_PRICE}                          (//span[contains(.,'Rs.')])[2]
${PRODUCTS_DETAILS_LBL_AVAILABILITY}                   //div[contains(@class,'product-information')]/p[2]   
${PRODUCTS_DETAILS_LBL_RATING}                         //img[@src='/static/images/product-details/rating.png']
${PRODUCTS_DETAILS_LBL_QTDE}                          //input[@id='quantity']      
${PRODUCTS_DETAILS_BTN_ADD_CART}                      //button[@type='button'][contains(.,'Add to cart')]
${PRODUCTS_INPUT_PESQUISA}                            //input[@type='text'][contains(@id,'product')]
${PRODUCTS_BTN_PESQUISA}                              //button[@type='button'][contains(@id,'search')]
${PRODUCTS_DETAILS_LBL_CONDITION}                      //p[contains(.,'Condition:')]
${PRODUCTS_DETAILS_LBL_BRAND}                          //p[contains(.,'Brand:')]   


${PRODUCTS_MOUSE_OVER_EXIBE_LBL_ADD_CART}         (//a[contains(text(),'Add to cart')])[2]   
${PRODUCTS_LBL_NOME_PRODUTO_2}                    (//div[contains(@class,'features_items')]//div[@class='productinfo text-center']/p)[2] 
${PRODUCTS_MOUSE_OVER_EXIBE_LBL_ADD_CART_2}       (//a[@data-product-id='2'][contains(.,'Add to cart')])[2]     
${PRODUCTS_MSG_ADD_CART_ADDED}                    //h4[@class='modal-title w-100'][contains(.,'Added!')]    
${PRODUCTS_MSG_ADD_CART_CONTINUE_SHOPPING}        //button[@class='btn btn-success close-modal btn-block'][contains(.,'Continue Shopping')]   
${PRODUCTS_LBL_NOME_PRODUTO_1_MO}                 //div[contains(@class,'features_items')]/div[2]/div/div[1]/div[2]/div/p
${PRODUCTS_LBL_NOME_PRODUTO_2_MO}                 //div[contains(@class,'features_items')]/div[3]/div/div[1]/div[2]/div/p
${PRODUCTS_LBL_PRECO_PRODUTO_1_MO}                //div[contains(@class,'features_items')]/div[2]/div/div[1]/div[2]/div/h2    
${PRODUCTS_LBL_PRECO_PRODUTO_2_MO}                //div[contains(@class,'features_items')]/div[3]/div/div[1]/div[2]/div/h2    
${PRODUCTS_BTN_VIEW_CART}                         //u[contains(.,'View Cart')]
${PRODUCTS_LBL_WRITE_YOUR_REVIEW}                 //a[contains(@data-toggle,'tab')]
${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_NAME}      //input[contains(@type,'text')]
${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_EMAIL}     //input[contains(@placeholder,'Email Address')]
${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_REVIEW}    //textarea[contains(@name,'review')]
${PRODUCTS_LBL_WRITE_YOUR_REVIEW_BTN_SUBMIT}      //button[@type='submit'][contains(.,'Submit')]
${PRODUCTS_LBL_WRITE_YOUR_REVIEW_LBL_THANK_YOU}   //span[contains(.,'Thank you for your review.')]


${CART_LBL_SUBSCRIPTION}                               //h2[contains(.,'Subscription')]                               
${CART_INPUT_SUBSCRIPTION}                             //input[@type='email'][contains(@id,'email')]
${CART_BTN_SUBMIT_SUBSCRIPTION}                        //button[contains(@type,'submit')]
${CART_LBL_MSG_SUBMIT_SUBSCRIPTION_SUCESS}             //div[@class='alert-success alert'][contains(.,'You have been successfully subscribed!')]
${CART_LBL_VALOR_PRODUTO_1}                            //tr[@id='product-1']/td[@class='cart_price']     
${CART_LBL_QTDE_PRODUTO_1}                             //tr[@id='product-1']/td[@class='cart_quantity']/button
${CART_LBL_VL_TOTAL_PRODUTO_1}                         //tr[@id='product-1']/td[@class='cart_total']     
${CART_LBL_VALOR_PRODUTO_2}                            //tr[@id='product-2']/td[@class='cart_price']     
${CART_LBL_QTDE_PRODUTO_2}                             //tr[@id='product-2']/td[@class='cart_quantity']/button
${CART_LBL_VL_TOTAL_PRODUTO_2}                         //tr[@id='product-2']/td[@class='cart_total']  
${CART_BTN_EXCLUIR_PRODUTO_1}                          //a[contains(@class,'cart_quantity_delete')]
${CART_LBL_TELA_CART}                                  //li[@class='active'][contains(.,'Shopping Cart')]
${CART_LBL_MSG_CARRINHO_VAZIO}                         //p[@class='text-center'][contains(.,'Cart is empty! Click here to buy products.')]


${CART_LBL_NOME_PRODUTO_X}                               //td[contains(@class,'cart_description')]/h4
${CART_LBL_VALOR_PRODUTO_X}                             //td[contains(@class,'cart_price')]/p
${CART_LBL_QTDE_PRODUTO_X}                             //td[contains(@class,'cart_quantity')]
${CART_LBL_VL_TOTAL_PRODUTO_X}                         //td[contains(@class,'cart_total')]     
${CART_BTN_EXCLUIR_PRODUTO_X}                          //td[contains(@class,'cart_delete')]
${CART_BTN_PROCEED_TO_CHECKOUT}                        //a[@class='btn btn-default check_out'][contains(.,'Proceed To Checkout')] 
${CART_LBL_REGISTER_LOGIN}                             //u[contains(.,'Register / Login')]


${CHECKOUT_LBL_CHECKOUT}                                    //li[@class='active'][contains(.,'Checkout')]  
${CHECKOUT_LBL_DELIVERY_TITULO_NOME}                        //ul[@id='address_delivery']/li[2]
${CHECKOUT_LBL_DELIVERY_EMPRESA}                            //ul[@id='address_delivery']/li[3]
${CHECKOUT_LBL_DELIVERY_RUA}                                //ul[@id='address_delivery']/li[4]
${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP}                  //ul[@id='address_delivery']/li[6]
${CHECKOUT_LBL_DELIVERY_PAIS}                               //ul[@id='address_delivery']/li[7]
${CHECKOUT_LBL_DELIVERY_CELULAR}                            //ul[@id='address_delivery']/li[8]
${CHECKOUT_LBL_BILLING_TITULO_NOME}                        //ul[@id='address_invoice']/li[2]
${CHECKOUT_LBL_BILLING_EMPRESA}                            //ul[@id='address_invoice']/li[3]
${CHECKOUT_LBL_BILLING_RUA}                                //ul[@id='address_invoice']/li[4]
${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP}                  //ul[@id='address_invoice']/li[6]
${CHECKOUT_LBL_BILLING_PAIS}                               //ul[@id='address_invoice']/li[7]
${CHECKOUT_LBL_BILLING_CELULAR}                            //ul[@id='address_invoice']/li[8]
${CHECKOUT_LBL_REVIEW_YOUR_ORDER}                          //h2[@class='heading'][contains(.,'Review Your Order')]
${CHECKOUT_LBL_DESCRITION_NAME}                            td[class*='cart_description'] > h4
${CHECKOUT_LBL_CATEGORY}                                   //td[contains(@class,'cart_description')]/p
${CHECKOUT_LBL_PRICE}                                      //td[contains(@class,'cart_price')]
${CHECKOUT_LBL_QUANTITY}                                   //td[contains(@class,'cart_quantity')]
${CHECKOUT_LBL_VALOR_PRODUTO}                              //td[contains(@class,'cart_total')]
${CHECKOUT_LBL_VALOR_TOTAL}                                //table[contains(@class,'table')]/tbody/tr[2]/td[4]
${CHECKOUT_INPUT_COMMENT}                              //textarea[@name='message']
${CHECKOUT_BTN_PLACE_ORDER}                            //a[contains(text(),'Place Order')]                                   
    

${PAYMENT_LBL_TITULO}                                  //li[contains(@class,'active')]
${PAYMENT_INPUT_NAME_CARD}                             //input[@name='name_on_card']
${PAYMENT_INPUT_CARD_NUMBER}                           //input[@name='card_number']
${PAYMENT_INPUT_CARD_CVC}                              //input[@name='cvc']
${PAYMENT_INPUT_CARD_EXPIRATION}                       //input[@name='expiry_month']
${PAYMENT_INPUT_CARD_YEAR}                             //input[@name='expiry_year']
${PAYMENT_BTN_PAY}                                     //button[@id='submit']
${PAYMENT_LBL_PLACED_SUCCESSFULY}                      //div[@id='success_message']/div
${PAYMENT_DONE_LBL_ORDER_PLACED}                       //h2[contains(@class,'title')]/b
${PAYMENT_DONE_BTN_CONINUE}                            //a[contains(text(),'Continue')]
${PAYMENT_BTN_DOWNLOAD_INVOICE}                        //a[contains(@class,'btn btn-default check_out')]
${PAYMENT_LBL_DOWNLOAD_CONFIRMED}                      //p[contains(.,'Congratulations! Your order has been confirmed!')]

