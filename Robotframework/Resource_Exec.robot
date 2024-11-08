*** Settings ***
Documentation       
Library             Collections
Library             String
Library             SeleniumLibrary
Library             Dialogs
Library             RequestsLibrary
Library             JSONSchemaLibrary
Library             JSONLibrary
Library             OperatingSystem
Library             DateTime
Library             BuiltIn
Resource            ./secreto/secreto.robot
Resource            ./variaveis/WEB.robot
Resource            ./variaveis/API.robot

*** Variables ***
${BROWSER}    Chrome
# ${BROWSER}    HeadlessChrome
# ${BROWSER}    Firefox
# ${BROWSER}    HeadlessFirefox
# ${BROWSER}    Edge
# ${BROWSER}    HeadlessEdge
${TEMPO_ESPERA}        10
${SELENIUM_SPEED}      0.2
${LOG_CONSOLE}         false 

*** Keywords ***
WEB 01: Launch browser 
    Sleep    1   
    Log    \n0 Browser passado é:<${BROWSER}>                   console=${LOG_CONSOLE}
    IF    '${BROWSER}' == 'Chrome'
        Log    \n1 Browser é Chrome: ${BROWSER}                 console=${LOG_CONSOLE}
        Open Browser         about:blank    ${BROWSER}      options=add_argument("--force-device-scale-factor=0.8");add_experimental_option("excludeSwitches", ["enable-logging"]);add_argument("--window-size=1550,800")
        Set Selenium Speed    ${SELENIUM_SPEED}
    ELSE
        IF    '${BROWSER}' == 'HeadlessChrome'
            Log    \n2 Browser é HeadlessChrome: ${BROWSER}     console=${LOG_CONSOLE}
            Open Browser         about:blank    ${BROWSER}      options=add_argument("--force-device-scale-factor=0.8");add_experimental_option("excludeSwitches", ["enable-logging"]);add_argument("--window-size=1550,800")
            Set Selenium Speed    ${SELENIUM_SPEED}
        ELSE
            IF    '${BROWSER}' == 'Firefox'    
                Log    \n3 Browser é Firefox: ${BROWSER}        console=${LOG_CONSOLE}
                ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys
                Call Method    ${options}    set_preference    layout.css.devPixelsPerPx    0.8
                Create Webdriver    Firefox    options=${options}
                Go To    about:blank
                Set Selenium Speed    ${SELENIUM_SPEED}
            ELSE
                IF  '${BROWSER}' == 'HeadlessFirefox'
                    Log    \n4 Browser é HeadlessFirefox: ${BROWSER}    console=${LOG_CONSOLE}
                    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
                    Call Method    ${options}    add_argument    --headless
                    Call Method    ${options}    add_argument    --disable-gpu
                    Create Webdriver    Chrome    options=${options}
                    Go To    about:blank
                    Execute JavaScript    var docEl = document.documentElement;docEl.style.transform = 'scale(0.8)';docEl.style.transformOrigin = 'top left';
                    Set Selenium Speed    ${SELENIUM_SPEED}
                ELSE
                    IF    '${BROWSER}' == 'Edge' 
                        Log    \n5 Browser é Edge: ${BROWSER}   console=${LOG_CONSOLE}
                        Open Browser   about:blank     ${BROWSER}    options=add_argument("--force-device-scale-factor=0.8")
                        Set Selenium Speed    ${SELENIUM_SPEED}
                    ELSE
                        IF    '${BROWSER}' == 'HeadlessEdge'
                            Log    \n6 Definindo Browser como sendo HeadlessEdge: ${BROWSER}    console=${LOG_CONSOLE}
                            Open Browser         about:blank     Edge    options=add_argument("--headless");add_argument("--disable-gpu");add_argument("--force-device-scale-factor=0.8")
                            Set Selenium Speed    ${SELENIUM_SPEED}
                        ELSE
                            Log    \n7 Reveja definição do BROWSER pois foi passado: ${BROWSER}    console=${LOG_CONSOLE}
                        END
                    END
                END
            END
            
        END
        
    END
    Maximize Browser Window 

WEB 01: Navigate to url
    [Arguments]    ${HOME_URL}
    Go To    ${HOME_URL}    

WEB 01: Verify that home page is visible successfully
    Wait Until Element Is Visible               ${HOME_BUNNER_PRINCIPAL}     timeout=${TEMPO_ESPERA}

WEB 01: Click on 'Signup / Login' button
    Wait Until Element Is Visible               ${HOME_SIGNUP_LOGIN}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Enabled               ${HOME_SIGNUP_LOGIN}         timeout=${TEMPO_ESPERA}
    Mouse Over                                  ${HOME_SIGNUP_LOGIN}
    aguardar_e_clicar_javascript                ${HOME_SIGNUP_LOGIN}

WEB 01: Verify 'New User Signup!' is visible
    Wait Until Element Is Visible               ${LOGIN_LBL_NEW_USER_SIGNUP}    timeout=${TEMPO_ESPERA}

WEB 01: Enter name and email address
    Obter dados 
    Wait Until Element Is Visible                ${LOGIN_INPUT_EMAIL}      timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible                ${LOGIN_INPUT_USUARIO}    timeout=${TEMPO_ESPERA}
    Input Text                                   ${LOGIN_INPUT_USUARIO}    ${NOME_ESPERADO}
    Input Text                                   ${LOGIN_INPUT_EMAIL}      ${EMAIL_ESPERADO}

WEB 01: Click 'Signup' button
    aguardar_e_clicar_javascript     ${LOGIN_BTN_SIGNUP}

WEB 01: Verify that 'ENTER ACCOUNT INFORMATION' is visible
    Wait Until Element Is Visible    ${LOGIN_LABEL_ENTER_ACCOUNT_INFORMATION}    timeout=${TEMPO_ESPERA}

WEB 01: Fill details: Title, Name, Email, Password, Date of birth
    Wait Until Element Is Visible            ${LOGIN_INPUT_PASSWORD}              timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible            ${LOGIN_LIST_DATE_DAY}               timeout=${TEMPO_ESPERA}    
    aguardar_e_clicar_javascript             ${LOGIN_RADIO_BTN_TITLE}
    Input Text                               ${LOGIN_INPUT_PASSWORD}     ${PASSWORD_ESPERADO}
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position      ${LOGIN_LIST_DATE_DAY}
    ${POSICAO_X_DO_ELEMENTO}=    Get Horizontal Position    ${LOGIN_LIST_DATE_DAY}
    Execute JavaScript    window.scrollTo(${POSICAO_X_DO_ELEMENTO}, ${POSICAO_Y_DO_ELEMENTO})
    Select From List By Value    ${LOGIN_LIST_DATE_DAY}      ${DIA_ANIVERSARIO_ESPERADO}
    Select From List By Value    ${LOGIN_LIST_DATE_MONTH}    ${MES_ANIVERSARIO_ESPERADO}
    Select From List By Value    ${LOGIN_LIST_DATE_YEAR}     ${ANO_ANIVERSARIO_ESPERADO}
    
WEB 01: Select checkbox 'Sign up for our newsletter!'
    aguardar_e_clicar_javascript    ${LOGIN_SELECT_SIGN_UP_FOR_OUR_NEWSLETTER}
    
WEB 01: Select checkbox 'Receive special offers from our partners!'
    Wait Until Element Is Visible    ${LOGIN_SELECT_RECEIVE_SPECIAL_OFFERS_FROM_OUR_PARTNERS}    timeout=${TEMPO_ESPERA}

    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${LOGIN_SELECT_RECEIVE_SPECIAL_OFFERS_FROM_OUR_PARTNERS}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    aguardar_e_clicar_javascript    ${LOGIN_SELECT_RECEIVE_SPECIAL_OFFERS_FROM_OUR_PARTNERS}
    
WEB 01: Fill details: First name, Last name, Company, Address, Address2, Country, State, City, Zipcode, Mobile Number
    Wait Until Element Is Visible    ${LOGIN_INPUT_FIRST_NAME}    timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_LAST_NAME}     timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_COMPANY}       timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_ADDRESS}       timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_ADDRESS_2}     timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_COUNTRY}       timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_STATE}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_CITY}          timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_ZIPCODE}       timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_INPUT_MOBILE_NUMBER}    timeout=${TEMPO_ESPERA}
    Wait Until Element Is Enabled    ${LOGIN_INPUT_MOBILE_NUMBER}    timeout=${TEMPO_ESPERA}
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${LOGIN_INPUT_FIRST_NAME}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    Scroll Element Into View    ${LOGIN_INPUT_FIRST_NAME} 
    Input Text        ${LOGIN_INPUT_FIRST_NAME}    ${PRIMEIRO_NOME_ESPERADO}
    Input Text        ${LOGIN_INPUT_LAST_NAME}    ${SOBRE_NOME_ESPERADO}    
    Input Text        ${LOGIN_INPUT_COMPANY}      ${EMPRESA_ESPERADO}
    Input Text        ${LOGIN_INPUT_ADDRESS}      ${ENDERECO1_ESPERADO}    
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${LOGIN_INPUT_ADDRESS}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})    
    Scroll Element Into View    ${LOGIN_INPUT_ADDRESS}     
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${LOGIN_INPUT_ADDRESS_2}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    Input Text        ${LOGIN_INPUT_ADDRESS_2}    ${ENDERECO2_ESPERADO}
    Scroll Element Into View        ${LOGIN_INPUT_ADDRESS_2} 
    Select From List By Value       ${LOGIN_INPUT_COUNTRY}       ${PAIS_ESPERADO} 
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${LOGIN_INPUT_STATE}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    Input Text        ${LOGIN_INPUT_STATE}      ${ESTADO_ESPERADO}    
    Input Text        ${LOGIN_INPUT_CITY}       ${CIDADE_ESPERADO}
    Input Text        ${LOGIN_INPUT_ZIPCODE}    ${CEP_ESPERADO}
    Input Text        ${LOGIN_INPUT_MOBILE_NUMBER}    ${CELULAR_ESPERADO}    
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${LOGIN_BTN_CREATE_ACCOUNT}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    Scroll Element Into View    ${LOGIN_BTN_CREATE_ACCOUNT}
    
WEB 01: Click 'Create Account button'
    aguardar_e_clicar_javascript     ${LOGIN_BTN_CREATE_ACCOUNT}

WEB 01: Verify that 'ACCOUNT CREATED!' is visible
    Wait Until Element Is Visible    ${LOGIN_LBL_ACCOUNT_CREATED}     timeout=${TEMPO_ESPERA}    

WEB 01: Click 'Continue' button
    Wait Until Element Is Enabled    ${LOGIN_LBL_ACCOUNT_CREATED}     timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${LOGIN_BTN_CONTINUE}            timeout=${TEMPO_ESPERA}
    aguardar_e_clicar_javascript     ${LOGIN_BTN_CONTINUE}    

WEB 01: Verify that 'Logged in as username' is visible
    Wait Until Element Is Visible    ${LOGIN_LBL_LOGGED_IN_A_USERNAME}            timeout=${TEMPO_ESPERA}

WEB 01: Click 'Delete Account' button
    aguardar_e_clicar_javascript    ${LOGIN_BTN_DELETE_ACCOUNT}    
    
WEB 01: Verify that 'ACCOUNT DELETED!' is visible and click 'Continue' button
    aguardar_e_clicar_javascript         ${LOGIN_LBL_ACCOUNT_DELETED}
    Wait Until Element Is Visible        ${LOGIN_BTN_CONTINUE}      timeout=${TEMPO_ESPERA}    



WEB 02: Launch browser 
    WEB 01: Launch browser 

WEB 02: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 
     
WEB 02: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 02: Click on 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button

WEB 02: Verify 'Login to your account' is visible   
    Wait Until Element Is Visible     ${HOME_LBL_LOGIN_TO_YOUR_ACCOUNT}        timeout=${TEMPO_ESPERA}

WEB 02: Enter correct email address and password  
    Obter dados 
    Wait Until Element Is Visible     ${HOME_INPUT_EMAIL}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${HOME_INPUT_SENHA}        timeout=${TEMPO_ESPERA}
    Input Text                        ${HOME_INPUT_EMAIL}        ${EMAIL_ESPERADO}
    Input Text                        ${HOME_INPUT_SENHA}        ${PASSWORD_ESPERADO}    

WEB 02: Click 'login' button
    aguardar_e_clicar_javascript    ${HOME_BTN_LOGIN}

WEB 02: Verify that 'Logged in as username' is visible
    WEB 01: Verify that 'Logged in as username' is visible
    
WEB 02: Click 'Delete Account' button
    WEB 01: Click 'Delete Account' button    

WEB 02: Verify that 'ACCOUNT DELETED!' is visible
    WEB 01: Verify that 'ACCOUNT DELETED!' is visible and click 'Continue' button
    aguardar_e_clicar_javascript    ${LOGIN_BTN_CONTINUE}
    


WEB 03: Launch browser 
    WEB 01: Launch browser 

WEB 03: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 
     
WEB 03: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully
    
WEB 03: Click on 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button

WEB 03: Verify 'Login to your account' is visible    
    Wait Until Element Is Visible    ${HOME_LBL_LOGIN_TO_YOUR_ACCOUNT}        timeout=${TEMPO_ESPERA}

WEB 03: Enter incorrect email address and password    
    Obter dados 
    Wait Until Element Is Visible     ${HOME_INPUT_EMAIL}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${HOME_INPUT_SENHA}        timeout=${TEMPO_ESPERA}
    Input Text                        ${HOME_INPUT_EMAIL}        ${EMAIL_ESPERADO}
    Input Text                        ${HOME_INPUT_SENHA}        PASSWORD_ERRADA 
    
WEB 03: Click 'login' button
    WEB 02: Click 'login' button
    
WEB 03: Verify error 'Your email or password is incorrect!' is visible
    Wait Until Element Is Visible        ${LOGIN_LBL_PASSWORD_IS_INCORRECT}         timeout=${TEMPO_ESPERA}

WEB 04: Launch browser
    WEB 01: Launch browser

WEB 04: Navigate to url    
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 04: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 04: Click on 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button

WEB 04: Verify 'Login to your account' is visible
    Wait Until Element Is Visible    ${HOME_LBL_LOGIN_TO_YOUR_ACCOUNT}        timeout=${TEMPO_ESPERA}

WEB 04: Enter correct email address and password
    WEB 02: Enter correct email address and password

WEB 04: Click 'login' button
    WEB 02: Click 'login' button

WEB 04: Verify that 'Logged in as username' is visible
    WEB 01: Verify that 'Logged in as username' is visible

WEB 04: Click 'Logout' button
    aguardar_e_clicar_javascript    ${LOGIN_BTN_LOGOUT}

WEB 04: Verify that user is navigated to login page
    Wait Until Element Is Visible            ${LOGIN_LBL_LOGOUT}        timeout=${TEMPO_ESPERA}



WEB 05: Launch browser
    WEB 01: Launch browser

WEB 05: Navigate to url   
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 05: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 05: Click on 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button

WEB 05: Verify 'New User Signup!' is visible
    WEB 01: Verify 'New User Signup!' is visible

WEB 05: Enter name and already registered email address
    Obter dados 
    Wait Until Element Is Visible                ${LOGIN_INPUT_EMAIL}      timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible                ${LOGIN_INPUT_USUARIO}    timeout=${TEMPO_ESPERA}
    Input Text                                   ${LOGIN_INPUT_USUARIO}    NOME_NOVO
    Input Text                                   ${LOGIN_INPUT_EMAIL}      ${EMAIL_ESPERADO}

WEB 05: Click 'Signup' button
    WEB 01: Click 'Signup' button
WEB 05: Verify error 'Email Address already exist!' is visible    
    Wait Until Element Is Visible                ${LOGIN_LBL_EMAIL_ALREADY_EXIST}        timeout=${TEMPO_ESPERA}

WEB 06: Launch browser
    WEB 01: Launch browser

WEB 06: Navigate to url   
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 06: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 06: Click on 'Contact Us' button
    aguardar_e_clicar_javascript    ${HOME_BTN_CONTACT_US}

WEB 06: Verify 'GET IN TOUCH' is visible        
    Wait Until Element Is Visible         ${CONTACT_LBL_GET_IN_TOUCH}      timeout=${TEMPO_ESPERA}

WEB 06: Enter name, email, subject and message
    Obter dados 
    Wait Until Element Is Visible         ${CONTACT_INPUT_NAME}            timeout=${TEMPO_ESPERA}        
    Wait Until Element Is Visible         ${CONTACT_INPUT_EMAIL}           timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible         ${CONTACT_INPUT_SUBJECT}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible         ${CONTACT_INPUT_MESSAGE}         timeout=${TEMPO_ESPERA}                       
    Input Text                            ${CONTACT_INPUT_NAME}            ${NOME_ESPERADO}        
    Input Text                            ${CONTACT_INPUT_EMAIL}           ${EMAIL_ESPERADO}
    Input Text                            ${CONTACT_INPUT_SUBJECT}         Assunto de teste
    Input Text                            ${CONTACT_INPUT_MESSAGE}         Essa é uma mensagem de teste
    
WEB 06: Upload file
    [Arguments]    ${CAMINHO_ARQ_ENVIAR}
    ${CAMINHO_ARQ_ENVIAR}    resolver_caminho_so    ${CAMINHO_ARQ_ENVIAR}
    ${CAMINHO_ARQ_ENVIAR}    Set Variable    ${CURDIR}${CAMINHO_ARQ_ENVIAR}    
    Wait Until Element Is Visible            ${CONTACT_UPLOAD_LOCATOR}               timeout=${TEMPO_ESPERA}
    Mouse Over            ${CONTACT_UPLOAD_LOCATOR}  
    ${element}=    Get WebElement    ${CONTACT_UPLOAD_LOCATOR}
    log     \n:1${element}    console=${LOG_CONSOLE}
    log     \n:1${CAMINHO_ARQ_ENVIAR}    console=${LOG_CONSOLE}    
    Input Text    ${CONTACT_UPLOAD_LOCATOR}    ${CAMINHO_ARQ_ENVIAR}

WEB 06: Click 'Submit' button
    aguardar_e_clicar_javascript    ${CONTACT_UPLOAD_SUBMIT} 

WEB 06: Click OK button
    Wait Until Keyword Succeeds    10s    2s    Handle Alert    accept   
    
WEB 06: Verify success message 'Success! Your details have been submitted successfully.' is visible
    Wait Until Element Is Visible            ${CONTACT_LBL_SUBMITTED_SUCCESSFULLY}             timeout=${TEMPO_ESPERA} 

WEB 06: Click 'Home' button and verify that landed to home page successfully
    aguardar_e_clicar_javascript    ${CONTACT_BTN_HOME}
     Wait Until Element Is Visible            ${HOME_BUNNER_PRINCIPAL}             timeout=${TEMPO_ESPERA} 



WEB 07: Launch browser
    WEB 01: Launch browser

WEB 07: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 07: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 07: Click on 'Test Cases' button
    aguardar_e_clicar_javascript             ${HOME_BTN_TESTE_CASES}

WEB 07: Verify user is navigated to test cases page successfully
    Wait Until Element Is Visible            ${TESTE_CASE_LBL_TEST_CASES}             timeout=${TEMPO_ESPERA} 



WEB 08: Launch browser
    WEB 01: Launch browser

WEB 08: Navigate to url 
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}   

WEB 08: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 08: Click on 'Products' button 
    aguardar_e_clicar_javascript        ${HOME_BTN_PRODUCTS}

WEB 08: Verify user is navigated to ALL PRODUCTS page successfully
    Wait Until Element Is Visible       ${PRODUCTS_LBL_ALL_PRODUCTS}           timeout=${TEMPO_ESPERA}
    
WEB 08: The products list is visible    
    Wait Until Element Is Visible       ${PRODUCTS_LBL_LIST_PRODUCTS}          timeout=${TEMPO_ESPERA}
    ${conteudo}    Get Text    //div[@class='features_items']
    ${qtde_conteudo}=     Get Length    ${conteudo} 
    Should Not Contain    ${conteudo}    SEARCHED PRODUCTS    msg=A string "SEARCHED PRODUCTS" foi encontrada no conteúdo, ou seja, a lista está vazia!
    
WEB 08: Click on 'View Product' of first product
    Wait Until Element Is Visible            ${PRODUCTS_BTN_VIEW_PRODUCT_1}       timeout=${TEMPO_ESPERA} 
    ${ELEMENTO_PARA_BUSCA}       Set Variable              ${PRODUCTS_INPUT_PESQUISA}
    ${POSICAO_Y_DO_ELEMENTO}    Get Vertical Position      ${ELEMENTO_PARA_BUSCA}
    ${POSICAO_X_DO_ELEMENTO}    Get Horizontal Position    ${ELEMENTO_PARA_BUSCA}
    Execute JavaScript    window.scrollTo(${POSICAO_X_DO_ELEMENTO}, ${POSICAO_Y_DO_ELEMENTO})      
    Log    \n\nPRODUCTS_BTN_VIEW_PRODUCT_1:${PRODUCTS_BTN_VIEW_PRODUCT_1}    console=${LOG_CONSOLE}    
    ${PRODUCTS_LBL_NOME_PRODUTO_X}    Set Variable    ${PRODUCTS_LBL_NOME_PRODUTO_X_1/2}1${PRODUCTS_LBL_NOME_PRODUTO_X_2/2}
    Wait Until Element Is Visible    ${PRODUCTS_LBL_NOME_PRODUTO_X}     timeout=${TEMPO_ESPERA}
    ${nome_produto_original}=    Get text   ${PRODUCTS_LBL_NOME_PRODUTO_X} 
    Log    \n\nNome_produto_original:${nome_produto_original}    console=${LOG_CONSOLE}
    ${primeiro_character}=    Get Substring    ${nome_produto_original}    0    1
    Log    \n0.:<${primeiro_character}>    console=${LOG_CONSOLE}
    IF    '${primeiro_character}' == '${SPACE}'
        Log    \n0.:Tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}=    Evaluate    "${nome_produto_original}"[1:]
        Log    \nVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n0.:NÃO tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}    Set Variable    ${nome_produto_original}
        Log    \nNVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    END
    Log    \n00.:${nome_produto}     console=${LOG_CONSOLE}
    ${nome_produto}    Replace String    ${nome_produto}    ${SPACE}${SPACE}     ${EMPTY}
    ${metade}=    Evaluate    len('${nome_produto}')//2
    ${primeira_metade}=   Get Substring    ${nome_produto}    0    ${metade}
    ${segunda_metade}=    Get Substring    ${nome_produto}    ${metade}
    Log    \n1.primeira_metade:${primeira_metade}    console=${LOG_CONSOLE}
    Log    \n2.segunda_metade:${segunda_metade}    console=${LOG_CONSOLE}
    IF    '${primeira_metade}' == '${segunda_metade}'
        ${nome_produto}   Set Variable    ${primeira_metade}
        Set Suite Variable    ${nome_produto}
        Log    \n3 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE  
        Log    \n4 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
        Log    \n5 nome_produto_original:<${nome_produto_original}>    console=${LOG_CONSOLE}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Não precisa alterar:${nome_produto}    console=${LOG_CONSOLE}
    END
    Log    \nConseguiu achar o PRIMEIRO produto da lista!    console=${LOG_CONSOLE}     
    Wait Until Element Is Visible    ${PRODUCTS_LBL_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}   
    aguardar_e_clicar_javascript     ${PRODUCTS_BTN_VIEW_PRODUCT_1}

WEB 08: User is landed to product detail page
    Wait Until Element Is Visible    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW}        timeout=${TEMPO_ESPERA}

WEB 08: Verify that detail detail is visible: product name, category, price, availability, condition, brand
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_CATEGORY}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_PRICE}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_AVAILABILITY}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_CONDITION}        timeout=${TEMPO_ESPERA}        
    Log    \nPRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_1/2:${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_1/2}    console=${LOG_CONSOLE}
    Log    \nPRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_2/2:${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_2/2}    console=${LOG_CONSOLE}
    Log    \nPRODUCTS_DETAILS_LBL_NOME_PRODUTO_X:${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_1/2}${nome_produto}${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_2/2}    console=${LOG_CONSOLE}
    ${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X}    Set Variable    ${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_1/2}${nome_produto}${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X_2/2}
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_NOME_PRODUTO_X}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_BRAND}        timeout=${TEMPO_ESPERA}    



WEB 09: Launch browser
    WEB 01: Launch browser

WEB 09: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 09: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 09: Click on 'Products' button
    aguardar_e_clicar_javascript        ${HOME_BTN_PRODUCTS}

WEB 09: Verify user is navigated to ALL PRODUCTS page successfully
    Wait Until Element Is Visible       ${PRODUCTS_LBL_ALL_PRODUCTS}      timeout=${TEMPO_ESPERA}

WEB 09: Enter product name in search input and click search button
    [Arguments]    ${NOME_PRODUTO_PESQUISAR}    
    Set Suite Variable    ${NOME_PRODUTO_PESQUISAR} 
    Wait Until Element Is Visible       ${PRODUCTS_INPUT_PESQUISA}        timeout=${TEMPO_ESPERA}
    Input Text                          ${PRODUCTS_INPUT_PESQUISA}        ${NOME_PRODUTO_PESQUISAR} 
    aguardar_e_clicar_javascript        ${PRODUCTS_BTN_PESQUISA}

WEB 09: Verify 'SEARCHED PRODUCTS' is visible
    Wait Until Element Is Visible       ${PRODUCTS_BTN_VIEW_PRODUCT_1}    timeout=${TEMPO_ESPERA}    
    Scroll Element Into View            ${PRODUCTS_BTN_VIEW_PRODUCT_1}  
    ${PRODUCTS_LBL_NOME_PRODUTO_X}    Set Variable    ${PRODUCTS_LBL_NOME_PRODUTO_X_1/2}1${PRODUCTS_LBL_NOME_PRODUTO_X_2/2}
    Wait Until Element Is Visible    ${PRODUCTS_LBL_NOME_PRODUTO_X}     timeout=${TEMPO_ESPERA}
    ${nome_produto_original}=    Get text   ${PRODUCTS_LBL_NOME_PRODUTO_X} 
    Log    \n\nNome_produto_original:${nome_produto_original}    console=${LOG_CONSOLE}
    ${primeiro_character}=    Get Substring    ${nome_produto_original}    0    1
    Log    \n0.:<${primeiro_character}>    console=${LOG_CONSOLE}
    IF    '${primeiro_character}' == '${SPACE}'
        Log    \n0.:Tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}=    Evaluate    "${nome_produto_original}"[1:]
        Log    \nVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n0.:NÃO tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}    Set Variable    ${nome_produto_original}
        Log    \nNVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    END
    Log    \n00.:${nome_produto}     console=${LOG_CONSOLE}
    ${nome_produto}    Replace String Using Regexp    ${nome_produto}    '    ${EMPTY}
    ${metade}=    Evaluate    len('${nome_produto}')//2
    ${primeira_metade}=   Get Substring    ${nome_produto}    0    ${metade}
    ${segunda_metade}=    Get Substring    ${nome_produto}    ${metade}
    Log    \n1.primeira_metade:${primeira_metade}    console=${LOG_CONSOLE}
    Log    \n2.segunda_metade:${segunda_metade}    console=${LOG_CONSOLE}
    IF    '${primeira_metade}' == '${segunda_metade}'
        ${nome_produto}   Set Variable    ${primeira_metade}
        Set Suite Variable    ${nome_produto}
        Log    \n3 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE 
        Log    \n4 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
        Log    \n5 nome_produto_original:<${nome_produto_original}>    console=${LOG_CONSOLE}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Não precisa alterar:${nome_produto}    console=${LOG_CONSOLE}
    END

WEB 09: Verify all the products related to search are visible
    Log    \nNome_produto_exibido_na_tela<${nome_produto}>             console=${LOG_CONSOLE}
    Log    \NOME_PRODUTO_INPUT_PESQUISAR<${NOME_PRODUTO_PESQUISAR}>    console=${LOG_CONSOLE}
    ${nome_produto}    Replace String    ${nome_produto}    ${SPACE}   ${EMPTY}
    ${NOME_PRODUTO_PESQUISAR}    Replace String    ${nome_produto}     ${SPACE}     ${EMPTY}
    Should Be Equal As Strings    ${nome_produto}    ${NOME_PRODUTO_PESQUISAR}



WEB 10: Launch browser
    WEB 01: Launch browser

WEB 10: Navigate to url  
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 10: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 10: Scroll down to footer
    Wait Until Element Is Visible            ${HOME_LBL_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}  
    ${ELEMENTO_PARA_BUSCA}       Set Variable              ${HOME_LBL_SUBSCRIPTION}
    ${POSICAO_Y_DO_ELEMENTO}    Get Vertical Position      ${ELEMENTO_PARA_BUSCA}
    ${POSICAO_X_DO_ELEMENTO}    Get Horizontal Position    ${ELEMENTO_PARA_BUSCA}
    Execute JavaScript    window.scrollTo(${POSICAO_X_DO_ELEMENTO}, ${POSICAO_Y_DO_ELEMENTO})  

WEB 10: Verify text 'SUBSCRIPTION'
    Wait Until Element Is Visible             ${HOME_LBL_SUBSCRIPTION}              timeout=${TEMPO_ESPERA} 

WEB 10: Enter email address in input and click arrow button
    Obter dados 
    Wait Until Element Is Visible             ${HOME_INPUT_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}   
    Input Text    ${HOME_INPUT_SUBSCRIPTION}  ${EMAIL_ESPERADO}
    aguardar_e_clicar_javascript              ${HOME_BTN_SUBMIT_SUBSCRIPTION}
    
WEB 10: Verify success message 'You have been successfully subscribed!' is visible
    Wait Until Element Is Visible        ${HOME_LSL_MSG_SUBMIT_SUBSCRIPTION_SUCESS}    timeout=${TEMPO_ESPERA}   
    Log    \nOK!    console=${LOG_CONSOLE}

WEB 11: Launch browser
    WEB 01: Launch browser

WEB 11: Navigate to url   
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 11: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 11: Click 'Cart' button
    aguardar_e_clicar_javascript               ${HOME_BTN_CART}

WEB 11: Scroll down to footer
    Wait Until Element Is Visible              ${CART_LBL_TELA_CART}                timeout=${TEMPO_ESPERA}   
    Wait Until Element Is Visible              ${CART_LBL_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}    
    Scroll Element Into View                   ${CART_LBL_SUBSCRIPTION} 

WEB 11: Verify text 'SUBSCRIPTION'
    Wait Until Element Is Visible              ${CART_LBL_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}  

WEB 11: Enter email address in input and click arrow button
    Obter dados 
    Wait Until Element Is Visible             ${HOME_INPUT_SUBSCRIPTION}            timeout=${TEMPO_ESPERA}   
    Input Text    ${HOME_INPUT_SUBSCRIPTION}  ${EMAIL_ESPERADO}
    aguardar_e_clicar_javascript              ${HOME_BTN_SUBMIT_SUBSCRIPTION}

WEB 11: Verify success message 'You have been successfully subscribed!' is visible
    Wait Until Element Is Visible        ${HOME_LSL_MSG_SUBMIT_SUBSCRIPTION_SUCESS}    timeout=${TEMPO_ESPERA}   
    Log    \nOK!    console=${LOG_CONSOLE}



WEB 12: Launch browser
    WEB 01: Launch browser

WEB 12: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL} 

WEB 12: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 12: Click 'Products' button
    WEB 08: Click on 'Products' button    

WEB 12: Hover over first product and click 'Add to cart'
    [Arguments]    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_1}
    Set Suite Variable    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_1}
    Execucao: Mouser Over + Obtem informacao + Adiciona carrinho - Produto 1 
    Wait Until Element Is Visible             ${PRODUCTS_LBL_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible             ${PRODUCTS_BTN_VIEW_PRODUCT_1}           timeout=${TEMPO_ESPERA}    

WEB 12: Click 'Continue Shopping' button
    FOR    ${counter}    IN RANGE    1    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_1}    
        aguardar_e_clicar_javascript               ${PRODUCTS_MSG_ADD_CART_CONTINUE_SHOPPING}
        Log    \n*counter<${counter}>    console=${LOG_CONSOLE}
        Execucao: Mouser Over + Obtem informacao + Adiciona carrinho - Produto 1
    END
    aguardar_e_clicar_javascript               ${PRODUCTS_MSG_ADD_CART_CONTINUE_SHOPPING}

WEB 12: Hover over second product and click 'Add to cart'
    [Arguments]    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_2}
    Set Suite Variable    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_2}
    FOR    ${counter}    IN RANGE    0    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_2}    
        Log    \n*counter<${counter}>    console=${LOG_CONSOLE}
        Execucao: Mouser Over + Obtem informacao + Adiciona carrinho - Produto 2
        aguardar_e_clicar_javascript               ${PRODUCTS_MSG_ADD_CART_CONTINUE_SHOPPING}
    END    
    Wait Until Element Is Visible    ${PRODUCTS_LBL_SUBSCRIPTION}
    Wait Until Element Is Visible            ${PRODUCTS_LBL_ALL_PRODUCTS}                    timeout=${TEMPO_ESPERA}

WEB 12: Click 'View Cart' button
    aguardar_e_clicar_javascript               ${HOME_BTN_CART}

WEB 12: Verify both products are added to Cart
    Wait Until Element Is Visible             ${CART_LBL_TELA_CART}             timeout=${TEMPO_ESPERA} 
    Log    \n1:${nome_produto_1}    console=${LOG_CONSOLE}
    Log    \n2:${nome_produto_2}    console=${LOG_CONSOLE}
    Wait Until Element Is Visible             ${CART_BTN_PROCEED_TO_CHECKOUT}   timeout=${TEMPO_ESPERA}   
    Page Should Contain           ${nome_produto_1} 
    Page Should Contain           ${nome_produto_2}
     

WEB 12: Verify their prices, quantity and total price
    ${Valor_produto_1}=                Get Text    ${CART_LBL_VALOR_PRODUTO_1}
    ${Valor_produto_1_LIMPO}           Limpa Preco    ${Valor_produto_1}
    ${PREÇO_PRODUTO_1_TELA_LIMPO}      Limpa Preco    ${PREÇO_PRODUTO_1_TELA} 
    Should Be Equal As Strings         ${Valor_produto_1_LIMPO}    ${PREÇO_PRODUTO_1_TELA_LIMPO}
    Log    \nValor_produto_1:<${Valor_produto_1_LIMPO},${PREÇO_PRODUTO_1_TELA_LIMPO}>    console=${LOG_CONSOLE}
    ${Qtde_produto_1}=    Get Text     ${CART_LBL_QTDE_PRODUTO_1}
    Should Be Equal As Strings    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_1}    ${Qtde_produto_1}
    Log    \nQtde_produto_1:<${Qtde_produto_1}>    console=${LOG_CONSOLE}
    ${Valor_Total_produto_1}=          Get Text       ${CART_LBL_VL_TOTAL_PRODUTO_1}
    ${Valor_Total_produto_1_LIMPO}     Limpa Preco    ${Valor_Total_produto_1}
    ${PREÇO_PRODUTO_1_TELA}    Limpa Preco    ${PREÇO_PRODUTO_1_TELA}
    ${VALOR_TOTAL_PRODUTO_1_TELA_LIMPO}=    Evaluate    ${Qtde_produto_1}*${PREÇO_PRODUTO_1_TELA}
    Should Be Equal As Strings         ${Valor_Total_produto_1_LIMPO}     ${VALOR_TOTAL_PRODUTO_1_TELA_LIMPO}
    Log    \n>>>>>>>>>Valor_Total_produto_1:<${Valor_Total_produto_1}>    console=${LOG_CONSOLE}
    Log    \n>>>>>>>>>Valor_Total_produto_1:<${Valor_Total_produto_1_LIMPO}>    console=${LOG_CONSOLE}
    Log    \n>>>>>>>>>Valor_Total_produto_1:<${VALOR_TOTAL_PRODUTO_1_TELA_LIMPO}>    console=${LOG_CONSOLE}
    ${Valor_produto_2}=    Get Text    ${CART_LBL_VALOR_PRODUTO_2}
    ${Valor_produto_2_LIMPO}        Limpa Preco    ${Valor_produto_2}
    ${PREÇO_PRODUTO_2_TELA_LIMPO}   Limpa Preco    ${PREÇO_PRODUTO_2_TELA} 
    Should Be Equal As Strings         ${Valor_produto_2_LIMPO}    ${PREÇO_PRODUTO_2_TELA_LIMPO}
    Log    \nValor_produto_2:<${Valor_produto_2_LIMPO},${PREÇO_PRODUTO_2_TELA_LIMPO}>    console=${LOG_CONSOLE}
    ${Qtde_produto_2}=    Get Text     ${CART_LBL_QTDE_PRODUTO_2}
    Should Be Equal As Strings    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_2}    ${Qtde_produto_2}
    Log    \nQtde_produto_2:<${Qtde_produto_2}>    console=${LOG_CONSOLE}
    ${Valor_Total_produto_2}=    Get Text    ${CART_LBL_VL_TOTAL_PRODUTO_2}
    ${Valor_Total_produto_2_LIMPO}     Limpa Preco    ${Valor_Total_produto_2}
    ${PREÇO_PRODUTO_2_TELA}    Limpa Preco    ${PREÇO_PRODUTO_2_TELA}
    ${VALOR_TOTAL_PRODUTO_2_TELA_LIMPO}=    Evaluate    ${Qtde_produto_2}*${PREÇO_PRODUTO_2_TELA}
    Should Be Equal As Strings         ${Valor_Total_produto_2_LIMPO}     ${VALOR_TOTAL_PRODUTO_2_TELA_LIMPO}
    Log    \n>>>>>>>>>Valor_Total_produto_2:<${Valor_Total_produto_2}>    console=${LOG_CONSOLE}
    Log    \n>>>>>>>>>Valor_Total_produto_2:<${Valor_Total_produto_2_LIMPO}>    console=${LOG_CONSOLE}
    Log    \n>>>>>>>>>Valor_Total_produto_2:<${VALOR_TOTAL_PRODUTO_2_TELA_LIMPO}>    console=${LOG_CONSOLE}
    


WEB 13: Launch browser
    WEB 01: Launch browser

WEB 13: Navigate to url  
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 13: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 13: Click 'View Product' for any product on home page
    [Arguments]    ${INDICE_DO_PRODUTO}   
    Selecionar o produto X   ${INDICE_DO_PRODUTO}   
    Set Suite Variable    ${INDICE_DO_PRODUTO}

WEB 13: Verify product detail is opened  
    Executar obtencao de informacao - Produto X    ${NOME_PRODUTO_TELA_PROD} 
    
Executar obtencao de informacao - Produto X      
    [Arguments]    ${NOME_PRODUTO_TELA_PROD}
    Wait Until Element Is Visible                    ${PRODUCTS_DETAILS_LBL_NOME_PRODUTO}                timeout=${TEMPO_ESPERA}
    ${nome_produto_original}    Get text   ${PRODUCTS_DETAILS_LBL_NOME_PRODUTO} 
    Tratar espaco no nome do produto    ${nome_produto_original}
    Log    \nEx 1. NOME_PRODUTO_TELA_PROD:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    Log    \nEx 2. nome_produto_original :<${nome_produto_original}>    console=${LOG_CONSOLE}
    ${nome_produto_original}    Retirar todos espacos    ${nome_produto_original}
    ${NOME_TELA_DETALHE_PRODUTO}     Retirar todos espacos    ${NOME_PRODUTO_TELA_PROD}
    Log    \nEx 1. NOME_TELA_DETALHE_PRODUTO:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    Should Be Equal As Strings       ${NOME_TELA_DETALHE_PRODUTO}     ${nome_produto_original} 
    Wait Until Element Is Visible            ${PRODUCTS_DETAILS_LBL_CATEGORY}            timeout=${TEMPO_ESPERA}
    ${CATEGORIA_TELA_DETALHE_PRODUTO}    Get text    ${PRODUCTS_DETAILS_LBL_CATEGORY}
    Log    \n2. CATEGORIA_TELA_DETALHE_PRODUTO:<${CATEGORIA_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Set Suite Variable    ${CATEGORIA_TELA_DETALHE_PRODUTO} 
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_RATING}     timeout=${TEMPO_ESPERA}
    ${DISPONIBILIDADE_TELA_DETALHE_PRODUTO}    Get Text    ${PRODUCTS_DETAILS_LBL_RATING}                          
    Log    \n3. AVALIACAO_TELA_DETALHE_PRODUTO:${DISPONIBILIDADE_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Set Suite Variable    ${DISPONIBILIDADE_TELA_DETALHE_PRODUTO} 
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_PRICE}     timeout=${TEMPO_ESPERA}
    ${PRECO_TELA_DETALHE_PRODUTO}    Get Text    ${PRODUCTS_DETAILS_LBL_PRICE}                          
    Log    \n4. PRECO_TELA_DETALHE_PRODUTO:${PRECO_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Set Suite Variable    ${PRECO_TELA_DETALHE_PRODUTO}   
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_QTDE}     timeout=${TEMPO_ESPERA}
    ${QTDE_TELA_DETALHE_PRODUTO}    Get Value    ${PRODUCTS_DETAILS_LBL_QTDE}                          
    Log    \n5. QTDE_TELA_DETALHE_PRODUTO:${QTDE_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Set Suite Variable    ${QTDE_TELA_DETALHE_PRODUTO} 
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_AVAILABILITY}     timeout=${TEMPO_ESPERA}
    ${DISPONIBILIDADE_TELA_DETALHE_PRODUTO}    Get Text    ${PRODUCTS_DETAILS_LBL_AVAILABILITY}                          
    Log    \n6. DISPONIBILIDADE_TELA_DETALHE_PRODUTO:${DISPONIBILIDADE_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Set Suite Variable    ${DISPONIBILIDADE_TELA_DETALHE_PRODUTO} 
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_CONDITION}      timeout=${TEMPO_ESPERA}
    ${CONDICAO_TELA_DETALHE_PRODUTO}    Get Text    ${PRODUCTS_DETAILS_LBL_CONDITION}                          
    Log    \n7. CONDICAO_TELA_DETALHE_PRODUTO:${CONDICAO_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Set Suite Variable    ${CONDICAO_TELA_DETALHE_PRODUTO} 
    Wait Until Element Is Visible    ${PRODUCTS_DETAILS_LBL_BRAND}      timeout=${TEMPO_ESPERA}
    ${MARCA_TELA_DETALHE_PRODUTO}    Get Text    ${PRODUCTS_DETAILS_LBL_BRAND}                          
    Log    \n8. MARCA_TELA_DETALHE_PRODUTO:${MARCA_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Set Suite Variable    ${MARCA_TELA_DETALHE_PRODUTO} 


Tratar espaco no nome do produto   
    [Arguments]    ${nome_produto_original}
    ${primeiro_character}=    Get Substring    ${nome_produto_original}    0    1
    Log    \n0.:<${primeiro_character}>    console=${LOG_CONSOLE}
    IF    '${primeiro_character}' == '${SPACE}'
        Log    \n0.:Tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}=    Evaluate    "${nome_produto_original}"[1:]
        Log    \nVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n0.:NÃO tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}    Set Variable    ${nome_produto_original}
        Log    \nNVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    END
    Log    \n00.:${nome_produto}     console=${LOG_CONSOLE}
    ${metade}=    Evaluate    len('${nome_produto}')//2
    ${primeira_metade}=    Get Substring    ${nome_produto}    0    ${metade}
    ${segunda_metade}=    Get Substring    ${nome_produto}    ${metade}
    Log    \n1.primeira_metade:${primeira_metade}    console=${LOG_CONSOLE}
    Log    \n2.segunda_metade:${segunda_metade}    console=${LOG_CONSOLE}
    IF    '${primeira_metade}' == '${segunda_metade}'
        ${nome_produto}   Set Variable    ${primeira_metade}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Precisou alterar, segue nome do produto como:${nome_produto}    console=${LOG_CONSOLE}
    ELSE
        Log    \n4 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
        Log    \n5 nome_produto_original:<${nome_produto_original}>    console=${LOG_CONSOLE}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Não precisa alterar, segue nome do produto como:${nome_produto}    console=${LOG_CONSOLE}
    END
    ${nome_produto_tratado}    Set Variable   ${nome_produto}
    Set Suite Variable    ${nome_produto_tratado}
    

WEB 13: Increase quantity to
    [Arguments]    ${QTDE_INSERIR_PRODUTO}
    Set Suite Variable    ${QTDE_INSERIR_PRODUTO}
    Input Text    ${PRODUCTS_DETAILS_LBL_QTDE}     ${QTDE_INSERIR_PRODUTO}
    ${PRODUCTS_DETAILS_LBL_QTDE_INSERIDO}    Get value    ${PRODUCTS_DETAILS_LBL_QTDE}
    Set Suite Variable    ${PRODUCTS_DETAILS_LBL_QTDE_INSERIDO}
    Log    \n1. NOME_TELA_DETALHE_PRODUTO:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    Log    \n2. CATEGORIA_TELA_DETALHE_PRODUTO:<${CATEGORIA_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Log    \n3. AVALIACAO_TELA_DETALHE_PRODUTO:<${DISPONIBILIDADE_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Log    \n4. PRECO_TELA_DETALHE_PRODUTO:<${PRECO_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Log    \n5. QTDE_TELA_DETALHE_PRODUTO:<${QTDE_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Log    \n6. DISPONIBILIDADE_TELA_DETALHE_PRODUTO:<${DISPONIBILIDADE_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Log    \n7. CONDICAO_TELA_DETALHE_PRODUTO:<${CONDICAO_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    Log    \n8. MARCA_TELA_DETALHE_PRODUTO:<${MARCA_TELA_DETALHE_PRODUTO}>    console=${LOG_CONSOLE}
    
WEB 13: Click 'Add to cart' button
    aguardar_e_clicar_javascript               ${PRODUCTS_DETAILS_BTN_ADD_CART}
    
    Wait Until Element Is Visible    ${PRODUCTS_MSG_ADD_CART_ADDED}        timeout=${TEMPO_ESPERA}
    aguardar_e_clicar_javascript               ${PRODUCTS_MSG_ADD_CART_CONTINUE_SHOPPING}

WEB 13: Click 'View Cart' button
    WEB 11: Click 'Cart' button

WEB 13: Verify that product is displayed in cart page with exact quantity
    Wait Until Element Is Visible    ${CART_LBL_TELA_CART}               timeout=${TEMPO_ESPERA} 
    Wait Until Element Is Visible    ${CART_LBL_SUBSCRIPTION}            timeout=${TEMPO_ESPERA}    
    Wait Until Element Is Visible    ${CART_LBL_NOME_PRODUTO_X}          timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CART_LBL_VALOR_PRODUTO_X}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CART_LBL_QTDE_PRODUTO_X}          timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CART_LBL_VL_TOTAL_PRODUTO_X}      timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CART_BTN_EXCLUIR_PRODUTO_X}       timeout=${TEMPO_ESPERA}    
    ${NOME_PRODUTO_TELA_CART}    Get text    ${CART_LBL_NOME_PRODUTO_X} 
    ${QTDE_PRODUTO_TELA_CART}    Get text    ${CART_LBL_QTDE_PRODUTO_X}
    ${VALOR_PRODUTO_TELA_CART}   Get text    ${CART_LBL_VALOR_PRODUTO_X}
    ${VALOR_TOTAL_PRODUTO_TELA_CART}    Get text    ${CART_LBL_VL_TOTAL_PRODUTO_X}
    Log    \n9. NOME_PRODUTO_TELA_CART:<${NOME_PRODUTO_TELA_CART}>     console=${LOG_CONSOLE}
    Log    \n10. QTDE_PRODUTO_TELA_CART:<${QTDE_PRODUTO_TELA_CART}>    console=${LOG_CONSOLE}
    Log    \n11. VALOR_PRODUTO_TELA_CART:<${VALOR_PRODUTO_TELA_CART}>  console=${LOG_CONSOLE}
    Log    \n12. VALOR_TOTAL_PRODUTO_TELA_CART:<${VALOR_TOTAL_PRODUTO_TELA_CART}>    console=${LOG_CONSOLE}
    Log    \n13 NOME_PRODUTO_TELA_PROD:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    ${NOME_PRODUTO_TELA_PROD}    Retirar todos espacos    ${NOME_PRODUTO_TELA_PROD}
    ${NOME_PRODUTO_TELA_CART_RETIRADO_ESPACOS}    Retirar todos espacos    ${NOME_PRODUTO_TELA_CART}
    Log    \n14 NOME_PRODUTO_TELA_CART_RETIRADO_ESPACOS:<${NOME_PRODUTO_TELA_CART_RETIRADO_ESPACOS}>    console=${LOG_CONSOLE}
    Should Be Equal As Strings    ${NOME_PRODUTO_TELA_PROD}    ${NOME_PRODUTO_TELA_CART_RETIRADO_ESPACOS}
    Log    \n NOME IGUAIS OK    console=${LOG_CONSOLE}
    Should Be Equal As Strings      ${PRECO_TELA_DETALHE_PRODUTO}   ${VALOR_PRODUTO_TELA_CART}
    Log    \n PREÇO IGUAIS OK    console=${LOG_CONSOLE}
    Should Be Equal As Strings    ${QTDE_INSERIR_PRODUTO}    ${QTDE_PRODUTO_TELA_CART}
    Log    \n QTDE IGUAIS OK    console=${LOG_CONSOLE}
    ${PRECO_TELA_DETALHE_PRODUTO}    Limpa Preco    ${PRECO_TELA_DETALHE_PRODUTO}
    ${VALOR_TOTAL_PRODUTO_TELA_CART}    Limpa Preco    ${VALOR_TOTAL_PRODUTO_TELA_CART}
    Log    \n.PRECO_TELA_ DETALHE _ PRODUTO:${PRECO_TELA_DETALHE_PRODUTO}    console=${LOG_CONSOLE}
    Log    \n.VALOR_TOTAL_PRODUTO_TELA_CART:${VALOR_TOTAL_PRODUTO_TELA_CART}    console=${LOG_CONSOLE}
    ${VALOR_TOTAL_CALCULADO}    Evaluate  ${PRECO_TELA_DETALHE_PRODUTO}*${QTDE_INSERIR_PRODUTO} 
    Should Be Equal As Strings    ${VALOR_TOTAL_CALCULADO}    ${VALOR_TOTAL_PRODUTO_TELA_CART}



WEB 14: Launch browser
    WEB 01: Launch browser

WEB 14: Navigate to url    
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 14: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 14: Add products to cart
    Selecionar o produto X    1
    Executar obtencao de informacao - Produto X    ${NOME_PRODUTO_TELA_PROD} 
    WEB 13: Increase quantity to    2
    WEB 13: Click 'Add to cart' button

WEB 14: 5. Click 'Cart' button
    WEB 11: Click 'Cart' button

WEB 14: Verify that cart page is displayed
    WEB 13: Verify that product is displayed in cart page with exact quantity

WEB 14: Click Proceed To Checkout
    Wait Until Element Is Visible                ${CART_BTN_PROCEED_TO_CHECKOUT}   timeout=${TEMPO_ESPERA} 
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position     ${CART_BTN_PROCEED_TO_CHECKOUT}
    ${POSICAO_X_DO_ELEMENTO}=    Get Horizontal Position   ${CART_BTN_PROCEED_TO_CHECKOUT}
    Execute JavaScript    window.scrollTo(${POSICAO_X_DO_ELEMENTO}, ${POSICAO_Y_DO_ELEMENTO})   
    aguardar_e_clicar_javascript               ${CART_BTN_PROCEED_TO_CHECKOUT}

WEB 14: Click 'Register / Login' button
    aguardar_e_clicar_javascript               ${CART_LBL_REGISTER_LOGIN}

WEB 14: Fill all details in Signup and create account
    WEB 01: Verify 'New User Signup!' is visible
    WEB 01: Enter name and email address
    WEB 01: Click 'Signup' button    
    WEB 01: Verify that 'ENTER ACCOUNT INFORMATION' is visible
    WEB 01: Fill details: Title, Name, Email, Password, Date of birth
    WEB 01: Select checkbox 'Sign up for our newsletter!'
    WEB 01: Fill details: First name, Last name, Company, Address, Address2, Country, State, City, Zipcode, Mobile Number
    WEB 01: Click 'Create Account button'

WEB 14: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 01: Verify that 'ACCOUNT CREATED!' is visible
    WEB 01: Click 'Continue' button
    
WEB 14: Verify ' Logged in as username' at top
    WEB 01: Verify that 'Logged in as username' is visible

WEB 14: 12. Click 'Cart' button
    WEB 11: Click 'Cart' button

WEB 14: Click 'Proceed To Checkout' button
    WEB 14: Click Proceed To Checkout    

WEB 14: Verify Address Details and Review Your Order 
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_EMPRESA}            timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_RUA}                timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP}  timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_PAIS}               timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_CELULAR}            timeout=${TEMPO_ESPERA}
    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME_TELA}            Get Text    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME}
    ${CHECKOUT_LBL_DELIVERY_EMPRESA_TELA}                Get Text    ${CHECKOUT_LBL_DELIVERY_EMPRESA}
    ${CHECKOUT_LBL_DELIVERY_RUA_TELA}                    Get Text    ${CHECKOUT_LBL_DELIVERY_RUA}
    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP_TELA}      Get Text    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP}
    ${CHECKOUT_LBL_DELIVERY_PAIS_TELA}                   Get Text    ${CHECKOUT_LBL_DELIVERY_PAIS}
    ${CHECKOUT_LBL_DELIVERY_CELULAR_TELA}                Get Text    ${CHECKOUT_LBL_DELIVERY_CELULAR}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_TITULO_NOME}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_EMPRESA}             timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_RUA}                 timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP}   timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_PAIS}                timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_CELULAR}             timeout=${TEMPO_ESPERA}
    ${CHECKOUT_LBL_BILLING_TITULO_NOME_TELA}            Get Text    ${CHECKOUT_LBL_BILLING_TITULO_NOME}
    ${CHECKOUT_LBL_BILLING_EMPRESA_TELA}                Get Text    ${CHECKOUT_LBL_BILLING_EMPRESA}
    ${CHECKOUT_LBL_BILLING_RUA_TELA}                    Get Text    ${CHECKOUT_LBL_BILLING_RUA}
    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP_TELA}      Get Text    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP}
    ${CHECKOUT_LBL_BILLING_PAIS_TELA}                   Get Text    ${CHECKOUT_LBL_BILLING_PAIS}
    ${CHECKOUT_LBL_BILLING_CELULAR_TELA}                Get Text    ${CHECKOUT_LBL_BILLING_CELULAR}
    Obter dados
    Should Be Equal As Strings     ${TITULO_ESPERADO}.${SPACE}${PRIMEIRO_NOME_ESPERADO}${SPACE}${SOBRE_NOME_ESPERADO}    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME_TELA}
    Should Be Equal As Strings     ${TITULO_ESPERADO}.${SPACE}${PRIMEIRO_NOME_ESPERADO}${SPACE}${SOBRE_NOME_ESPERADO}    ${CHECKOUT_LBL_BILLING_TITULO_NOME_TELA}
    Should Be Equal As Strings     ${EMPRESA_ESPERADO}     ${CHECKOUT_LBL_DELIVERY_EMPRESA_TELA}
    Should Be Equal As Strings     ${EMPRESA_ESPERADO}     ${CHECKOUT_LBL_BILLING_EMPRESA_TELA}
    Should Be Equal As Strings     ${ENDERECO1_ESPERADO}   ${CHECKOUT_LBL_DELIVERY_RUA_TELA}
    Should Be Equal As Strings     ${ENDERECO1_ESPERADO}   ${CHECKOUT_LBL_BILLING_RUA_TELA}
    Should Be Equal As Strings     ${CIDADE_ESPERADO}${SPACE}${ESTADO_ESPERADO}${SPACE}${CEP_ESPERADO}    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP_TELA}
    Should Be Equal As Strings     ${CIDADE_ESPERADO}${SPACE}${ESTADO_ESPERADO}${SPACE}${CEP_ESPERADO}    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP_TELA}
    Should Be Equal As Strings     ${PAIS_ESPERADO}      ${CHECKOUT_LBL_DELIVERY_PAIS_TELA}
    Should Be Equal As Strings     ${PAIS_ESPERADO}      ${CHECKOUT_LBL_BILLING_PAIS_TELA}
    Should Be Equal As Strings     ${CELULAR_ESPERADO}   ${CHECKOUT_LBL_DELIVERY_CELULAR_TELA}
    Should Be Equal As Strings     ${CELULAR_ESPERADO}   ${CHECKOUT_LBL_BILLING_CELULAR_TELA}
    Wait Until Element Is Visible  ${CHECKOUT_LBL_REVIEW_YOUR_ORDER}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible  css=${CHECKOUT_LBL_DESCRITION_NAME}       timeout=${TEMPO_ESPERA}    
    Wait Until Element Is Visible  ${CHECKOUT_LBL_CATEGORY}                  timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible  ${CHECKOUT_LBL_PRICE}                     timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible  ${CHECKOUT_LBL_QUANTITY}                  timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible  ${CHECKOUT_LBL_VALOR_PRODUTO}             timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible  ${CHECKOUT_LBL_VALOR_TOTAL}               timeout=${TEMPO_ESPERA}
    ${CHECKOUT_LBL_DESCRITION_NAME_TELA}               Get Text    css=${CHECKOUT_LBL_DESCRITION_NAME}  
    ${CHECKOUT_LBL_CATEGORY_TELA}                      Get Text    ${CHECKOUT_LBL_CATEGORY}
    ${CHECKOUT_LBL_PRICE_TELA}                         Get Text    ${CHECKOUT_LBL_PRICE}
    ${CHECKOUT_LBL_QUANTITY_TELA}                      Get Text    ${CHECKOUT_LBL_QUANTITY}    
    ${CHECKOUT_LBL_PRICE_TOTAL_PRODUTO_TELA}           Get Text    ${CHECKOUT_LBL_VALOR_PRODUTO}
    ${CHECKOUT_LBL_PRICE_TOTAL_GERAL_TELA}             Get Text    ${CHECKOUT_LBL_VALOR_TOTAL}
    Log    \n0:CHECKOUT_LBL_QUANTITY_TELA:${CHECKOUT_LBL_QUANTITY_TELA}                        console=${LOG_CONSOLE}
    ${NOME_PRODUTO_TELA_PROD_SEM_ESPACOS}    Retirar todos espacos    ${NOME_PRODUTO_TELA_PROD}     
    ${CHECKOUT_LBL_DESCRITION_NAME_TELA_SEM_ESPACOS}  Retirar todos espacos   ${CHECKOUT_LBL_DESCRITION_NAME_TELA}  
    Should Be Equal As Strings    ${NOME_PRODUTO_TELA_PROD_SEM_ESPACOS}       ${CHECKOUT_LBL_DESCRITION_NAME_TELA_SEM_ESPACOS} 
    ${CATEGORIA_TELA_DETALHE_PRODUTO}   Replace String    ${CATEGORIA_TELA_DETALHE_PRODUTO}          Category:     ${EMPTY}
    ${CATEGORIA_TELA_DETALHE_PRODUTO_SEM_ESPACOS}  Retirar todos espacos    ${CATEGORIA_TELA_DETALHE_PRODUTO}     
    ${CHECKOUT_LBL_CATEGORY_TELA_SEM_ESPACOS}      Retirar todos espacos    ${CHECKOUT_LBL_CATEGORY_TELA}   
    Should Be Equal As Strings    ${CATEGORIA_TELA_DETALHE_PRODUTO_SEM_ESPACOS}    ${CHECKOUT_LBL_CATEGORY_TELA_SEM_ESPACOS} 
    ${PRECO_TELA_DETALHE_PRODUTO_LIMPO}     Limpa Preco    ${PRECO_TELA_DETALHE_PRODUTO} 
    ${CHECKOUT_LBL_PRICE_TELA_LIMPO}        Limpa Preco    ${CHECKOUT_LBL_PRICE_TELA} 
    Should Be Equal As Strings    ${PRECO_TELA_DETALHE_PRODUTO_LIMPO}    ${CHECKOUT_LBL_PRICE_TELA_LIMPO} 
    Should Be Equal As Strings    ${CHECKOUT_LBL_QUANTITY_TELA}    ${QTDE_INSERIR_PRODUTO}
    Log    \n1:PRODUCTS_DETAILS_LBL_QTDE_INSERIDO:${PRODUCTS_DETAILS_LBL_QTDE_INSERIDO}     console=${LOG_CONSOLE}
    Log    \n2:CHECKOUT_LBL_QUANTITY_TELA:${CHECKOUT_LBL_QUANTITY_TELA}    console=${LOG_CONSOLE}
    Should Be Equal As Strings    ${PRODUCTS_DETAILS_LBL_QTDE_INSERIDO}    ${CHECKOUT_LBL_QUANTITY_TELA} 
    ${VALOR_TOTAL_PRODUTO_CALCULADO}   Evaluate   ${PRECO_TELA_DETALHE_PRODUTO_LIMPO}*${QTDE_INSERIR_PRODUTO}
    ${CHECKOUT_LBL_PRICE_TOTAL_PRODUTO_TELA_LIMPO}  Limpa Preco    ${CHECKOUT_LBL_PRICE_TOTAL_PRODUTO_TELA} 
    Should Be Equal As Strings   ${VALOR_TOTAL_PRODUTO_CALCULADO}  ${CHECKOUT_LBL_PRICE_TOTAL_PRODUTO_TELA_LIMPO} 
    ${CHECKOUT_LBL_PRICE_TOTAL_GERAL_TELA_LIMPO}    Limpa Preco    ${CHECKOUT_LBL_PRICE_TOTAL_GERAL_TELA} 
    Should Be Equal As Strings   ${VALOR_TOTAL_PRODUTO_CALCULADO}  ${CHECKOUT_LBL_PRICE_TOTAL_GERAL_TELA_LIMPO} 

WEB 14: Enter description in comment text area and click 'Place Order'
    Wait Until Element Is Visible    //textarea[@name='message']    timeout=${TEMPO_ESPERA}
    Input Text    //textarea[@name='message']    texto comentario
    Wait Until Element Is Visible    ${CHECKOUT_BTN_PLACE_ORDER}   timeout=${TEMPO_ESPERA}
    aguardar_e_clicar_javascript               ${CHECKOUT_BTN_PLACE_ORDER}
    
WEB 14: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    Wait Until Element Is Visible     ${PAYMENT_LBL_TITULO}              timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_NAME_CARD}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_NUMBER}       timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_CVC}          timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_EXPIRATION}   timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_YEAR}         timeout=${TEMPO_ESPERA}
    Inserir dados do cartao   
    
WEB 14: Click 'Pay and Confirm Order' button
    aguardar_e_clicar_javascript               ${PAYMENT_BTN_PAY}
    
WEB 14: Verify success message 'Your order has been placed successfully!'
    Wait Until Element Is Visible    ${PAYMENT_DONE_LBL_ORDER_PLACED}     timeout=${TEMPO_ESPERA}
    aguardar_e_clicar_javascript     ${PAYMENT_DONE_BTN_CONINUE}
    Set Selenium Speed    ${SELENIUM_SPEED}
    
WEB 14: Click 'Delete Account' button
    WEB 01: Click 'Delete Account' button

WEB 14: Verify 'ACCOUNT DELETED!' and click 'Continue' button
    WEB 01: Verify that 'ACCOUNT DELETED!' is visible and click 'Continue' button



WEB 15: Launch browser
    WEB 01: Launch browser

WEB 15: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 15: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 15: Click 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button
    
WEB 15: Fill all details in Signup and create account
    WEB 14: Fill all details in Signup and create account

WEB 15: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 14: Verify 'ACCOUNT CREATED!' and click 'Continue' button

WEB 15: Verify ' Logged in as username' at top
    WEB 14: Verify ' Logged in as username' at top

WEB 15: Add products to cart
    WEB 14: Add products to cart
    
WEB 15: Click 'Cart' button
    WEB 11: Click 'Cart' button
    
WEB 15: Verify that cart page is displayed
    WEB 13: Verify that product is displayed in cart page with exact quantity
    
WEB 15: Click Proceed To Checkout
    WEB 14: Click Proceed To Checkout

WEB 15: Verify Address Details and Review Your Order
    WEB 14: Verify Address Details and Review Your Order

WEB 15: Enter description in comment text area and click 'Place Order'
    WEB 14: Enter description in comment text area and click 'Place Order'

WEB 15: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 14: Enter payment details: Name on Card, Card Number, CVC, Expiration date

WEB 15: Click 'Pay and Confirm Order' button
    WEB 14: Click 'Pay and Confirm Order' button

WEB 15: Verify success message 'Your order has been placed successfully!'
    WEB 14: Verify success message 'Your order has been placed successfully!'

WEB 15: Click 'Delete Account' button
    WEB 01: Click 'Delete Account' button
    
WEB 15: Verify 'ACCOUNT DELETED!' and click 'Continue' button
    WEB 01: Verify that 'ACCOUNT DELETED!' is visible and click 'Continue' button



WEB 16: Launch browser
    WEB 01: Launch browser

WEB 16: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 16: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 16: Click 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button

WEB 16: Fill email, password and click 'Login' button
    WEB 02: Verify 'Login to your account' is visible 
    WEB 02: Enter correct email address and password
    WEB 02: Click 'login' button
    
WEB 16: Verify 'Logged in as username' at top
    WEB 01: Verify that 'Logged in as username' is visible
WEB 16: Add products to cart
    Selecionar o produto X    1
    Executar obtencao de informacao - Produto X    ${NOME_PRODUTO_TELA_PROD} 
    WEB 13: Increase quantity to    6
    WEB 13: Click 'Add to cart' button

WEB 16: Click 'Cart' button
    WEB 11: Click 'Cart' button

WEB 16: Verify that cart page is displayed
    WEB 13: Verify that product is displayed in cart page with exact quantity

WEB 16: Click Proceed To Checkout
    WEB 14: Click Proceed To Checkout

WEB 16: Verify Address Details and Review Your Order
    WEB 14: Verify Address Details and Review Your Order

WEB 16: Enter description in comment text area and click 'Place Order'
    WEB 14: Enter description in comment text area and click 'Place Order'

WEB 16: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 14: Enter payment details: Name on Card, Card Number, CVC, Expiration date

WEB 16: Click 'Pay and Confirm Order' button
    WEB 14: Click 'Pay and Confirm Order' button

WEB 16: Verify success message 'Your order has been placed successfully!'
    WEB 14: Verify success message 'Your order has been placed successfully!'

WEB 16: Click 'Delete Account' button
    WEB 01: Click 'Delete Account' button

WEB 16: Verify 'ACCOUNT DELETED!' and click 'Continue' button
    WEB 01: Verify that 'ACCOUNT DELETED!' is visible and click 'Continue' button



WEB 17: Launch browser
    WEB 01: Launch browser

WEB 17: Navigate to url 
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 17: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully
    
WEB 17: Add products to cart
    Selecionar o produto X    1
    Executar obtencao de informacao - Produto X    ${NOME_PRODUTO_TELA_PROD} 
    WEB 13: Increase quantity to    6
    WEB 13: Click 'Add to cart' button

WEB 17: Click 'Cart' button
    WEB 11: Click 'Cart' button

WEB 17: Verify that cart page is displayed
    WEB 13: Verify that product is displayed in cart page with exact quantity

WEB 17: Click 'X' button corresponding to particular product
    aguardar_e_clicar_javascript    ${CART_BTN_EXCLUIR_PRODUTO_1}
    
WEB 17: Verify that product is removed from the cart
    Wait Until Element Is Visible                ${CART_LBL_MSG_CARRINHO_VAZIO}            timeout=${TEMPO_ESPERA}



WEB 18: Launch browser
    WEB 01: Launch browser
    
WEB 18: Navigate to url   
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 18: Verify that categories are visible on left side bar
    Wait Until Element Is Visible                ${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_1}            timeout=${TEMPO_ESPERA}

WEB 18: Click on 'Women' category
    [Arguments]    ${CATEGORIA} 
    Seleciona Categoria    ${CATEGORIA}

WEB 18: Click on any category link under 'Women' category, for example: Dress
    [Arguments]    ${SUB_CATEGORIA} 
    Seleciona Sub-Categoria     ${SUB_CATEGORIA} 

WEB 18: Verify that category page is displayed and confirm text 'WOMEN - TOPS PRODUCTS'
    Verificar Titulo Categoria

WEB 18: On left side bar, click on any sub-category link of 'Men' category
    [Arguments]    ${CATEGORIA}   ${SUB_CATEGORIA}  
    Log    \n1:<${CATEGORIA}>    console=${LOG_CONSOLE}
    Log    \n2:<${SUB_CATEGORIA}>    console=${LOG_CONSOLE}
    Seleciona Categoria     ${CATEGORIA} 
    Seleciona Sub-Categoria     ${SUB_CATEGORIA} 

WEB 18: Verify that user is navigated to that category page
    Verificar Titulo Categoria

    
WEB 19: Launch browser
    WEB 01: Launch browser

WEB 19: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 19: Click on 'Products' button
    WEB 08: Click on 'Products' button
WEB 19: Verify that Brands are visible on left side bar
    Wait Until Element Is Visible     ${HOME_BRANDS_QUADRO_BRANDS}        timeout=${TEMPO_ESPERA}
WEB 19: Click on any brand name
    [Arguments]    ${OPCAO_BRANDS} 
    Set Suite Variable                ${OPCAO_BRANDS} 
    Seleciona BRANDS                  ${OPCAO_BRANDS}

Seleciona BRANDS
    [Arguments]    ${OPCAO_BRANDS}
    ${HOME_BRANDS_SELECIONAR}  Set Variable  ${HOME_BRANDS_LADO_ESQUERDO_OPCAO_1/2}${OPCAO_BRANDS}${HOME_BRANDS_LADO_ESQUERDO_OPCAO_2/2}
    Wait Until Element Is Visible            ${HOME_BRANDS_SELECIONAR}          timeout=${TEMPO_ESPERA}
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${HOME_BRANDS_SELECIONAR}
    ${POSICAO_X_DO_ELEMENTO}=    Get Horizontal Position  ${HOME_BRANDS_SELECIONAR}
    Execute JavaScript           window.scrollTo(${POSICAO_X_DO_ELEMENTO}, ${POSICAO_Y_DO_ELEMENTO})
    aguardar_e_clicar_javascript               ${HOME_BRANDS_SELECIONAR}
    
WEB 19: Verify that user is navigated to brand page and brand products are displayed
    Verifica Titulo BRANDS    ${OPCAO_BRANDS}

Verifica Titulo BRANDS
    [Arguments]    ${OPCAO_BRANDS}
    ${TEXTO_TITLULO_CONSTRUIDO}    Set Variable    BRAND${SPACE}-${SPACE}${OPCAO_BRANDS}${SPACE}PRODUCTS
    ${TEXTO_TITLULO_CONSTRUIDO}    Retirar todos espacos    ${TEXTO_TITLULO_CONSTRUIDO}
    ${TEXTO_TITLULO_CONSTRUIDO}    Convert To Lower Case    ${TEXTO_TITLULO_CONSTRUIDO}
    Set Suite Variable             ${TEXTO_TITLULO_CONSTRUIDO}
    Log    \nTexto para validar com Titulo:<${TEXTO_TITLULO_CONSTRUIDO}>    console=${LOG_CONSOLE}
    Wait Until Element Is Visible              ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_INTEIRO}    timeout=${TEMPO_ESPERA}
    ${TEXTO_LBL_TITULO_SELECAO}    Get Text    ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_INTEIRO}
    ${TEXTO_LBL_TITULO_SELECAO}    Retirar todos espacos    ${TEXTO_LBL_TITULO_SELECAO}
    ${TEXTO_LBL_TITULO_SELECAO}    Convert To Lower Case    ${TEXTO_LBL_TITULO_SELECAO}
    Log    \nTexto para validar com selecoes anteriores:<${TEXTO_LBL_TITULO_SELECAO}>    console=${LOG_CONSOLE}
    Should Be Equal As Strings    ${TEXTO_TITLULO_CONSTRUIDO}    ${TEXTO_LBL_TITULO_SELECAO}

WEB 19: On left side bar, click on any other brand link
    [Arguments]    ${OPCAO_BRANDS} 
    Set Suite Variable                        ${OPCAO_BRANDS} 
    Seleciona BRANDS                          ${OPCAO_BRANDS}

WEB 19: Verify that user is navigated to that brand page and can see products
    Verifica Titulo BRANDS    ${OPCAO_BRANDS}
    Verificar se produto tem a marca selecionada no menu



WEB 20: Launch browser
    WEB 01: Launch browser

WEB 20: Navigate to url    
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 20: Click on 'Products' button
    WEB 08: Click on 'Products' button

WEB 20: Verify user is navigated to ALL PRODUCTS page successfully
    WEB 08: Verify user is navigated to ALL PRODUCTS page successfully

WEB 20: Enter product name in search input and click search button   
    [Arguments]    ${NOME_PRODUTO_PESQUISAR}    
    Set Suite Variable    ${NOME_PRODUTO_PESQUISAR}   
    WEB 09: Enter product name in search input and click search button    ${NOME_PRODUTO_PESQUISAR}

WEB 20: Verify 'SEARCHED PRODUCTS' is visible
    WEB 09: Verify 'SEARCHED PRODUCTS' is visible

WEB 20: Verify all the products related to search are visible
    WEB 09: Verify all the products related to search are visible

WEB 20: Add those products to cart                                        
    [Arguments]    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_1}
    WEB 12: Hover over first product and click 'Add to cart'    ${QTDE_QUE_DEVE_SELECIONAR_PRODUTO_1}   
    WEB 12: Click 'Continue Shopping' button
    
WEB 20: Click 'Cart' button and verify that products are visible in cart  
    WEB 11: Click 'Cart' button
    Wait Until Element Is Visible    ${CART_BTN_PROCEED_TO_CHECKOUT}   timeout=${TEMPO_ESPERA}   
    Page Should Contain              ${NOME_PRODUTO_PESQUISAR}

WEB 20: Click 'Signup / Login' button and submit login details            
    WEB 15: Click 'Signup / Login' button
    WEB 02: Verify 'Login to your account' is visible
    WEB 02: Enter correct email address and password  
    WEB 02: Click 'login' button

WEB 20: Again, go to Cart page
    WEB 11: Click 'Cart' button
    Wait Until Element Is Visible    ${CART_BTN_PROCEED_TO_CHECKOUT}       timeout=${TEMPO_ESPERA}   

WEB 20: Verify that those products are visible in cart after login as well
    Page Should Contain              ${NOME_PRODUTO_PESQUISAR}



WEB 21: Launch browser
    WEB 01: Launch browser
    
WEB 21: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 21: Click on 'Products' button
    WEB 08: Click on 'Products' button

WEB 21: Verify user is navigated to ALL PRODUCTS page successfully
    WEB 08: Verify user is navigated to ALL PRODUCTS page successfully

WEB 21: Click on 'View Product' button
    WEB 08: Click on 'View Product' of first product

WEB 21: Verify 'Write Your Review' is visible
    Wait Until Element Is Visible    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW}            timeout=${TEMPO_ESPERA}
WEB 21: Enter name, email and review
    Obter dados
    Wait Until Element Is Visible    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_NAME}     timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_EMAIL}    timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_REVIEW}   timeout=${TEMPO_ESPERA}
    Input Text    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_NAME}      ${NOME_ESPERADO}
    Input Text    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_EMAIL}     ${EMAIL_ESPERADO}
    Input Text    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_INPUT_REVIEW}    Texto de Review

WEB 21: Click 'Submit' button
    aguardar_e_clicar_javascript     ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_BTN_SUBMIT}
    
WEB 21: Verify success message 'Thank you for your review.'
    Wait Until Element Is Visible    ${PRODUCTS_LBL_WRITE_YOUR_REVIEW_LBL_THANK_YOU}   timeout=${TEMPO_ESPERA}



WEB 22: Launch browser
    WEB 01: Launch browser

WEB 22: Navigate to url  
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 22: Scroll to bottom of page
    Wait Until Element Is Visible     ${HOME_LBL_SUBSCRIPTION}      timeout=${TEMPO_ESPERA}
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${HOME_LBL_RECOMMENDED_ITEMS}
    ${POSICAO_X_DO_ELEMENTO}=    Get Horizontal Position  ${HOME_LBL_RECOMMENDED_ITEMS}
    Execute JavaScript    window.scrollTo(${POSICAO_X_DO_ELEMENTO}, ${POSICAO_Y_DO_ELEMENTO})

WEB 22: Verify 'RECOMMENDED ITEMS' are visible
    Wait Until Element Is Visible    ${HOME_LBL_RECOMMENDED_ITEMS}   timeout=${TEMPO_ESPERA}
    
WEB 22: Click on 'Add To Cart' on Recommended product
    ${TEMPO_ESPERA_EM_DOBRO}    Evaluate    ${TEMPO_ESPERA}*2
    Wait Until Element Is Visible   ${HOME_BTN_CART_PARTE_RECOMENDACOES}       timeout=${TEMPO_ESPERA_EM_DOBRO}
    Wait Until Element Is Visible   ${HOME_LBL_NOME_DO_PRODUTO_SELECIONADO}    timeout=${TEMPO_ESPERA_EM_DOBRO}
    ${HOME_LBL_NOME_DO_PRODUTO_SELECIONADO_TEXTO}    Get Text    ${HOME_LBL_NOME_DO_PRODUTO_SELECIONADO}
    Set Suite Variable    ${HOME_LBL_NOME_DO_PRODUTO_SELECIONADO_TEXTO}
    aguardar_e_clicar_javascript               ${HOME_BTN_CART_PARTE_RECOMENDACOES}
    aguardar_e_clicar_javascript               ${PRODUCTS_BTN_VIEW_CART} 

WEB 22: Click on 'View Cart' button
    WEB 12: Click 'View Cart' button

WEB 22: Verify that product is displayed in cart page
    Page Should Contain                       ${HOME_LBL_NOME_DO_PRODUTO_SELECIONADO_TEXTO}



WEB 23: Launch browser
    WEB 01: Launch browser

WEB 23: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 23: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 23: Click 'Signup / Login' button
    WEB 01: Click on 'Signup / Login' button

WEB 23: Fill all details in Signup and create account
    WEB 01: Verify 'New User Signup!' is visible
    WEB 01: Enter name and email address
    WEB 01: Click 'Signup' button
    WEB 01: Verify that 'ENTER ACCOUNT INFORMATION' is visible
    WEB 01: Fill details: Title, Name, Email, Password, Date of birth
    WEB 01: Select checkbox 'Sign up for our newsletter!'
    WEB 01: Select checkbox 'Receive special offers from our partners!'
    WEB 01: Fill details: First name, Last name, Company, Address, Address2, Country, State, City, Zipcode, Mobile Number
    WEB 01: Click 'Create Account button'

WEB 23: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 01: Verify that 'ACCOUNT CREATED!' is visible
    WEB 01: Click 'Continue' button

WEB 23: Verify ' Logged in as username' at top
    WEB 01: Verify that 'Logged in as username' is visible 

WEB 23: Add products to cart
    WEB 12: Click 'Products' button
    WEB 12: Hover over first product and click 'Add to cart'    1
    WEB 12: Click 'Continue Shopping' button
    WEB 12: Hover over second product and click 'Add to cart'   1
    
WEB 23: Click 'Cart' button
    WEB 12: Click 'View Cart' button

WEB 23: Verify that cart page is displayed
    WEB 12: Verify both products are added to Cart

WEB 23: Click Proceed To Checkout
    WEB 14: Click Proceed To Checkout

WEB 23: Verify that the delivery address is same address filled at the time registration of account
    ${NOME_PRODUTO_TELA_PROD}    Set Variable  ${nome_produto_1}
    Set Suite Variable    ${NOME_PRODUTO_TELA_PROD}
    Verificar endereco de entrega
    Verificar endereco de cobranca

WEB 23: Verify that the billing address is same address filled at the time registration of account
    No Operation   

WEB 23: Click 'Delete Account' button
    aguardar_e_clicar_javascript               ${LOGIN_BTN_DELETE_ACCOUNT}

    
WEB 23: Verify 'ACCOUNT DELETED!' and click 'Continue' button
    Wait Until Element Is Visible            ${LOGIN_LBL_ACCOUNT_DELETED}             timeout=${TEMPO_ESPERA}  
  


WEB 24: Launch browser
    WEB 01: Launch browser

WEB 24: Navigate to url    
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 24: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully

WEB 24: Add products to cart
    WEB 12: Click 'Products' button
    WEB 12: Hover over first product and click 'Add to cart'    1
    WEB 12: Click 'Continue Shopping' button
    WEB 12: Hover over second product and click 'Add to cart'   1

WEB 24: Click 'Cart' button
    WEB 12: Click 'View Cart' button

WEB 24: Verify that cart page is displayed
    WEB 12: Verify both products are added to Cart

WEB 24: Click Proceed To Checkout
    WEB 14: Click Proceed To Checkout

WEB 24: Click 'Register / Login' button
    WEB 14: Click 'Register / Login' button

WEB 24: Fill all details in Signup and create account
    WEB 01: Verify 'New User Signup!' is visible
    WEB 01: Enter name and email address
    WEB 01: Click 'Signup' button    
    WEB 01: Verify that 'ENTER ACCOUNT INFORMATION' is visible
    WEB 01: Fill details: Title, Name, Email, Password, Date of birth
    WEB 01: Select checkbox 'Sign up for our newsletter!'
    WEB 01: Fill details: First name, Last name, Company, Address, Address2, Country, State, City, Zipcode, Mobile Number
    WEB 01: Click 'Create Account button'

WEB 24: Verify 'ACCOUNT CREATED!' and click 'Continue' button
    WEB 01: Verify that 'ACCOUNT CREATED!' is visible
    WEB 01: Click 'Continue' button

WEB 24: Verify ' Logged in as username' at top
    WEB 01: Verify that 'Logged in as username' is visible

WEB 24: Click 'Cart' button.
    WEB 11: Click 'Cart' button

WEB 24: Click 'Proceed To Checkout' button
    WEB 14: Click Proceed To Checkout  

WEB 24: Verify Address Details and Review Your Order
    Verificar endereco de entrega
    Verificar endereco de cobranca

WEB 24: Enter description in comment text area and click 'Place Order'
    WEB 14: Enter description in comment text area and click 'Place Order'

WEB 24: Enter payment details: Name on Card, Card Number, CVC, Expiration date
    WEB 14: Enter payment details: Name on Card, Card Number, CVC, Expiration date

WEB 24: Click 'Pay and Confirm Order' button
    WEB 14: Click 'Pay and Confirm Order' button

WEB 24: Verify success message 'Your order has been placed successfully!'
    Wait Until Element Is Visible    ${PAYMENT_DONE_LBL_ORDER_PLACED}     timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${PAYMENT_DONE_BTN_CONINUE}          timeout=${TEMPO_ESPERA}

WEB 24: Click 'Download Invoice' button and verify invoice is downloaded successfully.
    aguardar_e_clicar_javascript            ${PAYMENT_BTN_DOWNLOAD_INVOICE}
    ${TEMPO_ESPERA_EM_DOBRO}    Evaluate    ${TEMPO_ESPERA}*2
    Wait Until Element Is Visible           ${PAYMENT_LBL_DOWNLOAD_CONFIRMED}         timeout=${TEMPO_ESPERA_EM_DOBRO}

WEB 24: Click 'Continue' button
    aguardar_e_clicar_javascript            ${LOGIN_BTN_CONTINUE}

WEB 24: Click 'Delete Account' button
    aguardar_e_clicar_javascript           ${LOGIN_BTN_DELETE_ACCOUNT}

WEB 24: Verify 'ACCOUNT DELETED!' and click 'Continue' button
    Wait Until Element Is Visible          ${LOGIN_LBL_ACCOUNT_DELETED}           timeout=${TEMPO_ESPERA}



WEB 25: Launch browser
    WEB 01: Launch browser

WEB 25: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 25: Verify that home page is visible successfully
    WEB 01: Verify that home page is visible successfully
    FOR    ${exec}    IN RANGE    1    4
        ${HOME_LBL_BANNER_ENGINEERS_X}    Set Variable    ${HOME_LBL_BANNER_ENGINEERS_1/2}${exec}${HOME_LBL_BANNER_ENGINEERS_2/2}
        ${resultado}    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${HOME_LBL_BANNER_ENGINEERS_X}    timeout=1    screenshot=${LOG_CONSOLE}
        IF    '${resultado[0]}' == 'PASS'
            Log    \nVDD ${exec}   console=${LOG_CONSOLE}
            Exit For Loop
        END
    END

WEB 25: Scroll down page to bottom
    WEB 22: Scroll to bottom of page

WEB 25: Verify 'SUBSCRIPTION' is visible
     Wait Until Element Is Visible            ${HOME_LBL_SUBSCRIPTION}                   timeout=${TEMPO_ESPERA}
    
WEB 25: Click on arrow at bottom right side to move upward
    Wait Until Element Is Visible                ${HOME_BTN_SETA_PRA_CIMA}       timeout=${TEMPO_ESPERA}
    ${result}    Run Keyword And Ignore Error    Wait Until Element Is Visible   ${HOME_BANNER_HOST_RODAPE}     timeout=${TEMPO_ESPERA}    screenshot=${LOG_CONSOLE}
    ${result}    Run Keyword And Ignore Error    Mouse Over                      ${HOME_BANNER_HOST_RODAPE}    screenshot=${LOG_CONSOLE}
    ${result}    Run Keyword And Ignore Error    Double Click Element            ${HOME_BANNER_HOST_RODAPE}    screenshot=${LOG_CONSOLE}
    Sleep    2
    aguardar_e_clicar_javascript               ${HOME_BTN_SETA_PRA_CIMA}

WEB 25: Verify that page is scrolled up and 'Full-Fledged practice website for Automation Engineers' text is visible on screen
    ${TEMPO_ESPERA_EM_DOBRO}    Evaluate    ${TEMPO_ESPERA}*2
    FOR    ${exec}    IN RANGE    1    4
        ${HOME_LBL_BANNER_ENGINEERS_X}   Set Variable   ${HOME_LBL_BANNER_ENGINEERS_1/2}${exec}${HOME_LBL_BANNER_ENGINEERS_2/2}
        ${resultado}    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${HOME_LBL_BANNER_ENGINEERS_X}    timeout=1   screenshot=${LOG_CONSOLE}
        IF    '${resultado[0]}' == 'PASS'
            Log    \nVDD ${exec}   console=${LOG_CONSOLE}
            Exit For Loop
        END
    END
    Log    \n2... Resultado 2: Verificando ${HOME_LBL_BANNER_ENGINEERS_X} = ${resultado}    console=${LOG_CONSOLE}
    Wait Until Element Is Visible    ${HOME_LBL_BANNER_ENGINEERS_X}    timeout=${TEMPO_ESPERA_EM_DOBRO} 



WEB 26: Launch browser
    WEB 01: Launch browser
WEB 26: Navigate to url
    [Arguments]    ${HOME_URL} 
    WEB 01: Navigate to url    ${HOME_URL}

WEB 26: Verify that home page is visible successfully    
    WEB 01: Verify that home page is visible successfully

WEB 26: Scroll down page to bottom
    WEB 22: Scroll to bottom of page

WEB 26: Verify 'SUBSCRIPTION' is visible
    WEB 25: Verify 'SUBSCRIPTION' is visible
    
WEB 26: Scroll up page to top
    Wait Until Element Is Visible    ${HOME_BUNNER_PRINCIPAL}  
    Execute JavaScript    window.scrollTo(0, 0);
    
WEB 26: Verify that page is scrolled up and 'Full-Fledged practice website for Automation Engineers' text is visible on screen
    ${TEMPO_ESPERA_EM_DOBRO}    Evaluate    ${TEMPO_ESPERA}*2 
    FOR    ${exec}    IN RANGE    1    4
        ${HOME_LBL_BANNER_ENGINEERS_X}    Set Variable    ${HOME_LBL_BANNER_ENGINEERS_1/2}${exec}${HOME_LBL_BANNER_ENGINEERS_2/2}
        ${resultado}    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${HOME_LBL_BANNER_ENGINEERS_X}    timeout=1    screenshot=${LOG_CONSOLE}
        IF    '${resultado[0]}' == 'PASS'
            Log    \nVDD ${exec}   console=${LOG_CONSOLE}
            Exit For Loop
        END
    END
    Log    \n2... Resultado 2: Verificando ${HOME_LBL_BANNER_ENGINEERS_X} = ${resultado}    console=${LOG_CONSOLE}
    Wait Until Element Is Visible    ${HOME_LBL_BANNER_ENGINEERS_X}    timeout=${TEMPO_ESPERA_EM_DOBRO} 


Fechar browser
    Close Browser
    Sleep    2   


resolver_caminho_so
    [Arguments]    ${CAMINHO_RESOLVER}
    Log    \n>>>Ver entrada:<${CAMINHO_RESOLVER}>    console=${LOG_CONSOLE}
    ${SO}=    Evaluate    platform.system()    platform
    Log    \nSistema Operacional identificado como sendo...:<${SO}>    console=${LOG_CONSOLE}
    IF    '${BROWSER}' == 'HeadlessFirefox' or '${BROWSER}' == 'Firefox'
        Log    \n0SO Lin:<${SO}>    console=${LOG_CONSOLE}
        IF    '${SO}'=='Linux'
            ${CAMINHO_RESOLVER}    Replace String    ${CAMINHO_RESOLVER}    /     //
        ELSE
            ${CAMINHO_RESOLVER}    Replace String    ${CAMINHO_RESOLVER}    /     \\
        END
    END 
    Log    \n>>> Ver saida :<${CAMINHO_RESOLVER}>    console=${LOG_CONSOLE}
    RETURN    ${CAMINHO_RESOLVER}


Execucao: Mouser Over + Obtem informacao + Adiciona carrinho - Produto 1
    ${PRODUCTS_LBL_NOME_PRODUTO_X}    Set Variable    ${PRODUCTS_LBL_NOME_PRODUTO_X_1/2}1${PRODUCTS_LBL_NOME_PRODUTO_X_2/2}
    Wait Until Element Is Visible          ${PRODUCTS_LBL_NOME_PRODUTO_X}              timeout=${TEMPO_ESPERA} 
    Sleep    0.7
    Mouse Over                             ${PRODUCTS_LBL_NOME_PRODUTO_X}             
    Sleep    0.5
    Wait Until Element Is Visible          ${PRODUCTS_MOUSE_OVER_EXIBE_LBL_ADD_CART}   timeout=${TEMPO_ESPERA}        
    ${PREÇO_PRODUTO_1_TELA}=    Get Text   ${PRODUCTS_LBL_PRECO_PRODUTO_1_MO} 
    Set Suite Variable                ${PREÇO_PRODUTO_1_TELA}
    Log    \nPREÇO_PRODUTO_1:${PREÇO_PRODUTO_1_TELA}    console=${LOG_CONSOLE}
    ${nome_produto_original}=    Get text   ${PRODUCTS_LBL_NOME_PRODUTO_1_MO} 
    Log    \n\nNome_produto_original:${nome_produto_original}    console=${LOG_CONSOLE}
    ${primeiro_character}=    Get Substring    ${nome_produto_original}    0    1
    Log    \n0.:<${primeiro_character}>    console=${LOG_CONSOLE}    
    IF    '${primeiro_character}' == '${SPACE}'
        Log    \n0.:Tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}=    Evaluate    "${nome_produto_original}"[1:]
        Log    \nVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n0.:NÃO tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}    Set Variable    ${nome_produto_original}
        Log    \nNVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    END
    Log    \n00.:${nome_produto}     console=${LOG_CONSOLE}
    ${metade}=    Evaluate    len('${nome_produto}')//2
    ${primeira_metade}=   Get Substring    ${nome_produto}    0    ${metade}
    ${segunda_metade}=    Get Substring    ${nome_produto}    ${metade}
    Log    \n1.primeira_metade:${primeira_metade}    console=${LOG_CONSOLE}
    Log    \n2.segunda_metade:${segunda_metade}    console=${LOG_CONSOLE}
    IF    '${primeira_metade}' == '${segunda_metade}'
        ${nome_produto}   Set Variable    ${primeira_metade}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Precisou alterar, segue nome do produto como:${nome_produto}    console=${LOG_CONSOLE}
    ELSE   
        Log    \n4 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
        Log    \n5 nome_produto_original:<${nome_produto_original}>    console=${LOG_CONSOLE}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Não precisa alterar, segue nome do produto como:${nome_produto}    console=${LOG_CONSOLE}
    END
    ${nome_produto_1}    Set Variable   ${nome_produto}
    Set Suite Variable    ${nome_produto_1}
    aguardar_e_clicar_javascript          ${PRODUCTS_MOUSE_OVER_EXIBE_LBL_ADD_CART}
    Wait Until Element Is Visible         ${PRODUCTS_MSG_ADD_CART_ADDED}                timeout=${TEMPO_ESPERA} 



Execucao: Mouser Over + Obtem informacao + Adiciona carrinho - Produto 2
    Wait Until Element Is Visible         ${PRODUCTS_LBL_NOME_PRODUTO_2}             timeout=${TEMPO_ESPERA} 
    Mouse Over                            ${PRODUCTS_LBL_NOME_PRODUTO_2}             
    Sleep    0.5
    Wait Until Element Is Visible         ${PRODUCTS_MOUSE_OVER_EXIBE_LBL_ADD_CART_2}   timeout=${TEMPO_ESPERA}    
    ${PREÇO_PRODUTO_2_TELA}=  Get Text    ${PRODUCTS_LBL_PRECO_PRODUTO_2_MO} 
    Set Suite Variable                ${PREÇO_PRODUTO_2_TELA}
    Log    \nPREÇO_PRODUTO_2:${PREÇO_PRODUTO_2_TELA}    console=${LOG_CONSOLE}
    ${nome_produto_original}=    Get text   ${PRODUCTS_LBL_NOME_PRODUTO_2_MO} 
    Log    \n\nNome_produto_original:${nome_produto_original}    console=${LOG_CONSOLE}
    ${primeiro_character}=    Get Substring    ${nome_produto_original}    0    1
    Log    \n0.:<${primeiro_character}>    console=${LOG_CONSOLE}
    IF    '${primeiro_character}' == '${SPACE}'
        Log    \n0.:Tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}=    Evaluate    "${nome_produto_original}"[1:]
        Log    \nVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n0.:NÃO tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${nome_produto}    Set Variable    ${nome_produto_original}
        Log    \nNVDD vai pra frente assim:<${nome_produto}>    console=${LOG_CONSOLE}
    END
    Log    \n00.:${nome_produto}     console=${LOG_CONSOLE}
    ${metade}=    Evaluate    len('${nome_produto}')//2
    ${primeira_metade}=   Get Substring    ${nome_produto}    0    ${metade}
    ${segunda_metade}=    Get Substring    ${nome_produto}    ${metade}
    Log    \n1.primeira_metade:${primeira_metade}   console=${LOG_CONSOLE}
    Log    \n2.segunda_metade:${segunda_metade}     console=${LOG_CONSOLE}
    IF    '${primeira_metade}' == '${segunda_metade}'
        ${nome_produto}   Set Variable    ${primeira_metade}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Precisou alterar, segue nome do produto como:${nome_produto}    console=${LOG_CONSOLE}
    ELSE
        Log    \n4 nome_produto:<${nome_produto}>    console=${LOG_CONSOLE}
        Log    \n5 nome_produto_original:<${nome_produto_original}>    console=${LOG_CONSOLE}
        Set Suite Variable    ${nome_produto}
        Log    \n6.: Não precisa alterar, segue nome do produto como:${nome_produto}    console=${LOG_CONSOLE}
    END
    ${nome_produto_2}    Set Variable   ${nome_produto}
    Set Suite Variable    ${nome_produto_2}
    aguardar_e_clicar_javascript          ${PRODUCTS_MOUSE_OVER_EXIBE_LBL_ADD_CART_2}
    Wait Until Element Is Visible         ${PRODUCTS_MSG_ADD_CART_ADDED}                timeout=${TEMPO_ESPERA} 



Selecionar o produto X   
    [Arguments]    ${INDICE_DO_PRODUTO}   
    ${PRODUCTS_BTN_VIEW_PRODUCT_X}    Set Variable    ${PRODUCTS_BTN_VIEW_PRODUCT_X_web13_1/2}${INDICE_DO_PRODUTO}${PRODUCTS_BTN_VIEW_PRODUCT_X_web13_2/2}
    Wait Until Element Is Visible            ${PRODUCTS_BTN_VIEW_PRODUCT_X}       timeout=${TEMPO_ESPERA}    
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${PRODUCTS_BTN_VIEW_PRODUCT_X}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    Scroll Element Into View            ${PRODUCTS_BTN_VIEW_PRODUCT_X}    
    ${PRODUCTS_LBL_NOME_PRODUTO_X}    Set Variable    ${PRODUCTS_LBL_NOME_PRODUTO_X_1/2}${INDICE_DO_PRODUTO}${PRODUCTS_LBL_NOME_PRODUTO_X_2/2}    
    Wait Until Element Is Visible    ${PRODUCTS_LBL_NOME_PRODUTO_X}     timeout=${TEMPO_ESPERA}
    ${nome_produto_original}=    Get text   ${PRODUCTS_LBL_NOME_PRODUTO_X} 
    Log    \n\nNome_produto_original:${nome_produto_original}    console=${LOG_CONSOLE}
    ${primeiro_character}=    Get Substring    ${nome_produto_original}    0    1
    Log    \n0.:<${primeiro_character}>    console=${LOG_CONSOLE}
    IF    '${primeiro_character}' == '${SPACE}'
        Log    \n0.:Tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${NOME_PRODUTO_TELA_PROD}=    Evaluate    "${nome_produto_original}"[1:]
        Log    \nVDD vai pra frente assim:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n0.:NÃO tem espaço no 1º caracter    console=${LOG_CONSOLE}
        ${NOME_PRODUTO_TELA_PROD}    Set Variable    ${nome_produto_original}
        Log    \nNVDD vai pra frente assim:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    END
    Log    \n00.:${NOME_PRODUTO_TELA_PROD}     console=${LOG_CONSOLE}
    ${metade}=    Evaluate    len('${NOME_PRODUTO_TELA_PROD}')//2
    ${primeira_metade}=   Get Substring    ${NOME_PRODUTO_TELA_PROD}    0    ${metade}
    ${segunda_metade}=    Get Substring    ${NOME_PRODUTO_TELA_PROD}    ${metade}
    Log    \n1.primeira_metade:${primeira_metade}    console=${LOG_CONSOLE}
    Log    \n2.segunda_metade:${segunda_metade}    console=${LOG_CONSOLE}
    IF    '${primeira_metade}' == '${segunda_metade}'
        ${NOME_PRODUTO_TELA_PROD}   Set Variable    ${primeira_metade}
        Set Suite Variable    ${NOME_PRODUTO_TELA_PROD}
        Log    \n3 nome_produto:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}
    ELSE
        Log    \n4 NOME_PRODUTO_TELA_PROD:<${NOME_PRODUTO_TELA_PROD}>  console=${LOG_CONSOLE}
        Log    \n5 nome_produto_original:<${nome_produto_original}>    console=${LOG_CONSOLE}
        Set Suite Variable    ${NOME_PRODUTO_TELA_PROD}
        Log    \n6.: Não precisa alterar:${NOME_PRODUTO_TELA_PROD}     console=${LOG_CONSOLE}
    END
    Set Suite Variable   ${NOME_PRODUTO_TELA_PROD}
    Log    \n7.:Nome FINAL do produto:<${NOME_PRODUTO_TELA_PROD}>    console=${LOG_CONSOLE}   
    Wait Until Element Is Visible            ${PRODUCTS_LBL_SUBSCRIPTION}             timeout=${TEMPO_ESPERA}   
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${PRODUCTS_LBL_SUBSCRIPTION}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO})
    Scroll Element Into View                 ${PRODUCTS_LBL_SUBSCRIPTION} 
    Log    \nPRODUCTS_BTN_VIEW_PRODUCT_X:${PRODUCTS_BTN_VIEW_PRODUCT_X}    console=${LOG_CONSOLE}     
    Wait Until Element Is Visible            ${PRODUCTS_BTN_VIEW_PRODUCT_X}       timeout=${TEMPO_ESPERA}    
    Wait Until Element Is Enabled            ${PRODUCTS_BTN_VIEW_PRODUCT_X}       timeout=${TEMPO_ESPERA} 
    ${POSICAO_Y_DO_ELEMENTO}=    Get Vertical Position    ${PRODUCTS_BTN_VIEW_PRODUCT_X}
    Execute JavaScript    window.scrollTo(0, ${POSICAO_Y_DO_ELEMENTO}) 
    Mouse Over                               ${PRODUCTS_BTN_VIEW_PRODUCT_X}
    aguardar_e_clicar_javascript             ${PRODUCTS_BTN_VIEW_PRODUCT_X}


    
Seleciona Categoria
    [Arguments]    ${CATEGORIA} 
    Set Suite Variable    ${CATEGORIA}
    ${HOME_CATEGORIA_SELECIONAR}    Set Variable    ${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_1/2}${CATEGORIA}${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_2/2}
    Log    \nCat:${CATEGORIA}    console=${LOG_CONSOLE}  
    aguardar_e_clicar_javascript               ${HOME_CATEGORIA_SELECIONAR}
    


Seleciona Sub-Categoria
    [Arguments]    ${SUB_CATEGORIA} 
    Set Suite Variable    ${SUB_CATEGORIA}
    ${HOME_SUB_CATEGORIA_SELECIONAR}    Set Variable    ${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_SUB_1/2}${SUB_CATEGORIA}${HOME_CATEGORIA_LADO_ESQUERDO_OPCAO_SUB_2/2}
    Log    \nSub_Cat:${SUB_CATEGORIA}    console=${LOG_CONSOLE}
    aguardar_e_clicar_javascript               ${HOME_SUB_CATEGORIA_SELECIONAR}


Verificar Titulo Categoria
    ${TEXTO_TITLULO_CONSTRUIDO}    Set Variable    ${CATEGORIA}${SPACE}-${SPACE}${SUB_CATEGORIA}${SPACE}PRODUCTS
    ${TEXTO_TITLULO_CONSTRUIDO}    Retirar todos espacos    ${TEXTO_TITLULO_CONSTRUIDO}
    ${TEXTO_TITLULO_CONSTRUIDO}    Convert To Lower Case    ${TEXTO_TITLULO_CONSTRUIDO}
    Log    \nTexto para validar com TEXTO_TITLULO_CONSTRUIDO:<${TEXTO_TITLULO_CONSTRUIDO}>    console=${LOG_CONSOLE}
    ${SELENIUM_SPEED_CINCO}    Evaluate    ${SELENIUM_SPEED}*5
    Set Selenium Speed    ${SELENIUM_SPEED_CINCO} 
    Wait Until Element Is Visible              ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_INTEIRO}             timeout=${TEMPO_ESPERA}
    ${TEXTO_LBL_TITULO_SELECAO}    Get Text    ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_INTEIRO}        
    Set Selenium Speed    ${SELENIUM_SPEED}
    ${TEXTO_LBL_TITULO_SELECAO}    Retirar todos espacos    ${TEXTO_LBL_TITULO_SELECAO}
    ${TEXTO_LBL_TITULO_SELECAO}    Convert To Lower Case    ${TEXTO_LBL_TITULO_SELECAO}
    Log    \n0 Texto para validar com selecoes TEXTO_LBL_TITULO_SELECAO:<${TEXTO_LBL_TITULO_SELECAO}>    console=${LOG_CONSOLE}
    ${TEMPO_ESPERA_METADE}    Evaluate    ${TEMPO_ESPERA}/4
    Log    \nTEMPO_ESPERA_METADE:<${TEMPO_ESPERA_METADE}>    console=${LOG_CONSOLE}
    ${status}=   Run Keyword And Return Status   Wait Until Element Is Visible  ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}  timeout=${TEMPO_ESPERA_METADE}   screenshot=${LOG_CONSOLE}
        IF    '${status}' == 'True'
            ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}    Get Text    ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}
            ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}    Retirar todos espacos    ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}
            ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}    Convert To Lower Case    ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}
            ${TEXTO_LBL_TITULO_SELECAO}    Replace String    ${TEXTO_LBL_TITULO_SELECAO}    ${CATEGORY_e_BRANDS_LBL_TITULO_SELECAO_FINAL}    ${EMPTY}
        END
    Log    \nFinal previa da comparação TEXTO_TITLULO_CONSTRUIDO:<${TEXTO_TITLULO_CONSTRUIDO}>    console=${LOG_CONSOLE}
    Log    Final previa da comparação TEXTO_LBL_TITULO_SELECAO:<${TEXTO_LBL_TITULO_SELECAO}>      console=${LOG_CONSOLE}
    Should Be Equal As Strings    ${TEXTO_TITLULO_CONSTRUIDO}   ${TEXTO_LBL_TITULO_SELECAO}



Inserir dados do cartao
    [Tags]    dados_sensiveis
    Wait Until Element Is Visible     ${PAYMENT_LBL_TITULO}              timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_NAME_CARD}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_NUMBER}       timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_CVC}          timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_EXPIRATION}   timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible     ${PAYMENT_INPUT_CARD_YEAR}         timeout=${TEMPO_ESPERA}
    Input Text    ${PAYMENT_INPUT_NAME_CARD}         ${NAME_CARD}
    Input Text    ${PAYMENT_INPUT_CARD_NUMBER}       ${NUMBER_CARD}
    Input Text    ${PAYMENT_INPUT_CARD_CVC}          ${CVC_CARD}
    Input Text    ${PAYMENT_INPUT_CARD_EXPIRATION}   ${EXPIRATION_CARD}
    Input Text    ${PAYMENT_INPUT_CARD_YEAR}         ${YEAR_CARD}



Obter dados 
    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO}    Load JSON From File    ${CURDIR}/dados/dados_para_cadastro.json
    Set Suite Variable    ${NOME_ESPERADO}     ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["name"]}
    Set Suite Variable    ${EMAIL_ESPERADO}    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["email"]}    
    Set Suite Variable    ${TITULO_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["title"]}
    Set Suite Variable    ${DIA_ANIVERSARIO_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_day"]}
    Set Suite Variable    ${MES_ANIVERSARIO_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_month"]}
    Set Suite Variable    ${ANO_ANIVERSARIO_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_year"]}
    Set Suite Variable    ${PRIMEIRO_NOME_ESPERADO}     ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["first_name"]}
    Set Suite Variable    ${SOBRE_NOME_ESPERADO}      ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["last_name"]}
    Set Suite Variable    ${EMPRESA_ESPERADO}      ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["company"]}
    Set Suite Variable    ${ENDERECO1_ESPERADO}    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["address1"]}
    Set Suite Variable    ${ENDERECO2_ESPERADO}    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["address2"]}
    Set Suite Variable    ${PAIS_ESPERADO}     ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["country"]}
    Set Suite Variable    ${ESTADO_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["state"]}
    Set Suite Variable    ${CIDADE_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["city"]}
    Set Suite Variable    ${CEP_ESPERADO}      ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["zipcode"]}
    Set Suite Variable    ${PASSWORD_ESPERADO}   ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["password"]}
    Set Suite Variable    ${CELULAR_ESPERADO}    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["mobile_number"]}



Verificar se produto tem a marca selecionada no menu
    Wait Until Element Is Visible    ${HOME_BRANDS_LADO_ESQUERDO_OPCAO_1/2}${OPCAO_BRANDS}${HOME_BRANDS_LADO_ESQUERDO_OPCAO_2/2}    timeout=${TEMPO_ESPERA}
    ${texto_opcao}=    Get Text      ${HOME_BRANDS_LADO_ESQUERDO_OPCAO_1/2}${OPCAO_BRANDS}${HOME_BRANDS_LADO_ESQUERDO_OPCAO_2/2}
    ${separa_texto}=    Get Regexp Matches    ${texto_opcao}    (\\d+)    1
    ${qtde_de_itens}=   Set Variable    ${separa_texto}[0]
    Log    O número encontrado de itens foi: ${qtde_de_itens}     console=${LOG_CONSOLE}
    ${parar_exec}    Evaluate    ${qtde_de_itens} + 1
    FOR    ${exec}   IN RANGE    1    ${parar_exec}
        Log   \nEXEC:${exec}    console=${LOG_CONSOLE}
        ${VIEW_PRODUCT_X}    Set Variable    ${HOME_BRANDS_BTN_VIEW_PRODUCT_EXIBIDO_MENU_1/2}${exec}${HOME_BRANDS_BTN_VIEW_PRODUCT_EXIBIDO_MENU_2/2}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VIEW_PRODUCT_X}    timeout=${TEMPO_ESPERA}    screenshot=${LOG_CONSOLE}
        IF    '${status}' == 'True'    
            Log    \nElemento encontrado, continuando...    console=${LOG_CONSOLE}
            Execute JavaScript    document.evaluate("(//a[contains(text(),'View Product')])[${exec}]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()        
            Wait Until Element Is Visible           ${PRODUCTS_DETAILS_LBL_BRAND}          timeout=${TEMPO_ESPERA}
            ${texto_brand_desse_produto}    Get Text    ${PRODUCTS_DETAILS_LBL_BRAND}  
            ${texto_brand_desse_produto}    Retirar todos espacos    ${texto_brand_desse_produto}
            ${texto_brand_desse_produto}    Convert To Lower Case    ${texto_brand_desse_produto}
            Log    \nBRAND desse produto é:${texto_brand_desse_produto}    console=${LOG_CONSOLE}
            ${OPCAO_BRANDS}    Retirar todos espacos    ${OPCAO_BRANDS}
            ${OPCAO_BRANDS}    Convert To Lower Case    ${OPCAO_BRANDS}
            Log    \nBRAND:${OPCAO_BRANDS}    console=${LOG_CONSOLE}
            Should Contain     ${texto_brand_desse_produto}    ${OPCAO_BRANDS} 
            Go Back
        END
    END
    


Verificar endereco de entrega
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME}        timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_EMPRESA}            timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_RUA}                timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP}  timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_PAIS}               timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_DELIVERY_CELULAR}            timeout=${TEMPO_ESPERA}
    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME_TELA}            Get Text    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME}
    ${CHECKOUT_LBL_DELIVERY_EMPRESA_TELA}                Get Text    ${CHECKOUT_LBL_DELIVERY_EMPRESA}
    ${CHECKOUT_LBL_DELIVERY_RUA_TELA}                    Get Text    ${CHECKOUT_LBL_DELIVERY_RUA}
    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP_TELA}      Get Text    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP}
    ${CHECKOUT_LBL_DELIVERY_PAIS_TELA}                   Get Text    ${CHECKOUT_LBL_DELIVERY_PAIS}
    ${CHECKOUT_LBL_DELIVERY_CELULAR_TELA}                Get Text    ${CHECKOUT_LBL_DELIVERY_CELULAR}
    Obter dados
    Should Be Equal As Strings    ${TITULO_ESPERADO}.${SPACE}${PRIMEIRO_NOME_ESPERADO}${SPACE}${SOBRE_NOME_ESPERADO}    ${CHECKOUT_LBL_DELIVERY_TITULO_NOME_TELA}
    Should Be Equal As Strings    ${EMPRESA_ESPERADO}     ${CHECKOUT_LBL_DELIVERY_EMPRESA_TELA}
    Should Be Equal As Strings    ${ENDERECO1_ESPERADO}   ${CHECKOUT_LBL_DELIVERY_RUA_TELA}
    Should Be Equal As Strings    ${CIDADE_ESPERADO}${SPACE}${ESTADO_ESPERADO}${SPACE}${CEP_ESPERADO}    ${CHECKOUT_LBL_DELIVERY_CIDADE_ESTADO_CEP_TELA}
    Should Be Equal As Strings    ${PAIS_ESPERADO}     ${CHECKOUT_LBL_DELIVERY_PAIS_TELA}
    Should Be Equal As Strings    ${CELULAR_ESPERADO}  ${CHECKOUT_LBL_DELIVERY_CELULAR_TELA}



Verificar endereco de cobranca
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_TITULO_NOME}         timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_EMPRESA}             timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_RUA}                 timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP}   timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_PAIS}                timeout=${TEMPO_ESPERA}
    Wait Until Element Is Visible    ${CHECKOUT_LBL_BILLING_CELULAR}             timeout=${TEMPO_ESPERA}
    ${CHECKOUT_LBL_BILLING_TITULO_NOME_TELA}            Get Text    ${CHECKOUT_LBL_BILLING_TITULO_NOME}
    ${CHECKOUT_LBL_BILLING_EMPRESA_TELA}                Get Text    ${CHECKOUT_LBL_BILLING_EMPRESA}
    ${CHECKOUT_LBL_BILLING_RUA_TELA}                    Get Text    ${CHECKOUT_LBL_BILLING_RUA}
    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP_TELA}      Get Text    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP}
    ${CHECKOUT_LBL_BILLING_PAIS_TELA}                   Get Text    ${CHECKOUT_LBL_BILLING_PAIS}
    ${CHECKOUT_LBL_BILLING_CELULAR_TELA}                Get Text    ${CHECKOUT_LBL_BILLING_CELULAR}
    Obter dados
    Should Be Equal As Strings    ${TITULO_ESPERADO}.${SPACE}${PRIMEIRO_NOME_ESPERADO}${SPACE}${SOBRE_NOME_ESPERADO}    ${CHECKOUT_LBL_BILLING_TITULO_NOME_TELA}
    Should Be Equal As Strings    ${EMPRESA_ESPERADO}    ${CHECKOUT_LBL_BILLING_EMPRESA_TELA}
    Should Be Equal As Strings    ${ENDERECO1_ESPERADO}  ${CHECKOUT_LBL_BILLING_RUA_TELA}
    Should Be Equal As Strings    ${CIDADE_ESPERADO}${SPACE}${ESTADO_ESPERADO}${SPACE}${CEP_ESPERADO}    ${CHECKOUT_LBL_BILLING_CIDADE_ESTADO_CEP_TELA}
    Should Be Equal As Strings    ${PAIS_ESPERADO}     ${CHECKOUT_LBL_BILLING_PAIS_TELA}
    Should Be Equal As Strings    ${CELULAR_ESPERADO}  ${CHECKOUT_LBL_BILLING_CELULAR_TELA}



pausar
    [Arguments]    ${msg_complementar}
    Log    \nIniciando pausar.      console=${LOG_CONSOLE}
    ${pausar}    Get Value From User    Click OK para liberar e voltar o teste | ${msg_complementar}.
    Log    Finalizando pausar.\n    console=${LOG_CONSOLE}
    Set Suite Variable   ${pausar}    



Condicao ter usuario cadastrado: chamando api de criacao
    Cria sessao
    API 11: Dispara requisicao   /dados/dados_para_cadastro.json    /dados/API_11.json



Condicao não ter usuario cadastrado: chamando api de delecao
    Cria sessao
    API 12: Dispara requisicao    /dados/API_11.json    /dados/dados_para_cadastro.json



aguardar_e_clicar_javascript
    [Arguments]    ${elemento_alvo_do_click}
    Wait Until Element Is Visible                ${elemento_alvo_do_click}            timeout=${TEMPO_ESPERA}
    Sleep    0.5
    Execute JavaScript    document.evaluate("${elemento_alvo_do_click}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();



Limpa Preco
    [Arguments]    ${PREÇO_DE_ENTRADA}
    ${RESULTADO}    Replace String    ${PREÇO_DE_ENTRADA}    Rs.${SPACE}     ${EMPTY}
    RETURN    ${RESULTADO}



Retirar todos espacos
    [Arguments]    ${TEXTO_ORIGINAL}
    ${RESULTADO}    Replace String    ${TEXTO_ORIGINAL}    ${SPACE}     ${EMPTY}
    RETURN    ${RESULTADO}


   



Cria sessao
    Create Session      MINHA_SESSAO_API   ${BASE_URL}   verify=true 



API 01: Dispara requisicao
    ${DADOS_RETORNO_API}     GET On Session          MINHA_SESSAO_API   ${END_POINT_PRODUCTSLIST}    
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}

API 01: Verifica Status code 
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Log    \nSTATUS_CODE:<${STATUS_CODE}>    console=${LOG_CONSOLE}
    Log    \STATUS_CODE_ESPERADO:<${STATUS_CODE_ESPERADO}>    console=${LOG_CONSOLE}
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 01: Verifica tipo Schema/Contrato
    ${TIPO}    Evaluate    str(type(${DADOS_RETORNO_API.json()}))
    Should Be Equal    ${TIPO}    <class 'dict'>

API 01: Verifica o Schema/Contrato modelo no caminho
    [Arguments]    ${CAMINHO_CONTRATO_API_01-02}
    ${CAMINHO_CONTRATO_API_01-02}   Set Variable    ${CURDIR}${CAMINHO_CONTRATO_API_01-02}
    Validate Json By Schema File    ${DADOS_RETORNO_API.json()}    ${CAMINHO_CONTRATO_API_01-02}



API 02: Dispara requisicao      
    ${DADOS_RETORNO_API}      POST On Session    MINHA_SESSAO_API    ${END_POINT_PRODUCTSLIST}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}

API 02: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 02: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=     Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}

API 03: Dispara requisicao
    ${DADOS_RETORNO_API}      GET On Session    MINHA_SESSAO_API    ${END_POINT_BRANDSLIST}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}

API 03: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 03: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_STATUS}    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers    ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}

API 03: Verifica tipo Schema/Contrato
    ${TIPO}    Evaluate    str(type(${DADOS_RETORNO_API.json()}))
    Should Be Equal    ${TIPO}    <class 'dict'>

API 03: Verifica o Schema/Contrato modelo no caminho
    [Arguments]    ${CAMINHO_CONTRATO_API_03}
    ${CAMINHO_CONTRATO_API_03}    Set Variable    ${CURDIR}${CAMINHO_CONTRATO_API_03}
    Validate Json By Schema File    ${DADOS_RETORNO_API.json()}    ${CAMINHO_CONTRATO_API_03}

API 03: Verifica se no retorno vem somente valor esperado    
    [Arguments]    ${OBJETO}
    ${DADOS_RETORNO_API}   GET On Session    MINHA_SESSAO_API    ${END_POINT_BRANDSLIST}
    ${OBJETOS_JSON}    Get Dictionary Keys    ${DADOS_RETORNO_API.json()}
    ${QTDE_OBJETOS_JSON}    Get Length    ${DADOS_RETORNO_API.json()}
    Should Be Equal    "${QTDE_OBJETOS_JSON}"    "2"
    Dictionary Should Contain Key    ${DADOS_RETORNO_API.json()}    ${OBJETO} 



API 04: Dispara requisicao    
    ${DADOS_RETORNO_API}      PUT On Session    MINHA_SESSAO_API    ${END_POINT_BRANDSLIST}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}

API 04: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 04: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=     Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 05: Dispara requisicao    
    [Arguments]    ${PRODUTO_PARA_PESQUISAR}    
    Set Suite Variable  ${PRODUTO_PARA_PESQUISAR}    ${PRODUTO_PARA_PESQUISAR}    
    ${DADOS_ENVIAR}=    Evaluate    {'search_product': (None, '${PRODUTO_PARA_PESQUISAR}')}
    ${DADOS_RETORNO_API}      POST On Session    MINHA_SESSAO_API    ${END_POINT_SEARCHPRODUCT}     data=${DADOS_ENVIAR}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    
API 05: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}      
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 05: Verifica Response Code     
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}  
    ${RESPONSE_CODE_STATUS}    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers    ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}

API 05: Verifica retorno dados cadastro
    ${REGISTRO}    Get From Dictionary    ${DADOS_RETORNO_API.json()}    products
    ${QTDE_REGISTRO}    Get Length    ${REGISTRO}
    Run Keyword If    ${QTDE_REGISTRO} == 0    Fail    Nenhum produto foi retornado pela API
    FOR    ${REGISTRO}    IN    @{REGISTRO}
        ${category}    Get From Dictionary    ${REGISTRO['category']}    category        
        ${category}    Convert To Lowercase   ${category}
        ${PRODUTO_PARA_PESQUISAR}    Convert To Lowercase    ${PRODUTO_PARA_PESQUISAR}
        Should Contain     ${category}    ${PRODUTO_PARA_PESQUISAR}
    END

API 05: Verifica o Schema/Contrato modelo no caminho   
    [Arguments]    ${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}
    ${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}    Set Variable    ${CURDIR}${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}
    Validate Json By Schema File    ${DADOS_RETORNO_API.json()}    ${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}



API 06: Dispara requisicao    
    ${DADOS_RETORNO_API}      POST On Session    MINHA_SESSAO_API    ${END_POINT_SEARCHPRODUCT}  
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Log    \n Status:${DADOS_RETORNO_API}      console=${LOG_CONSOLE}
    Log    \n Dados :${DADOS_RETORNO_API.json()}      console=${LOG_CONSOLE}

API 06: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 06: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers    ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings    ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 07: Dispara requisicao
    [Arguments]    ${ARQ_API_11}    ${ARQ_DADOS_PARA_CADASTRO}
    ${ARQ_API_11}    Load JSON From File   ${CURDIR}${ARQ_API_11}
    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO}    Load JSON From File    ${CURDIR}${ARQ_DADOS_PARA_CADASTRO}
    ${EMAIL_ESPERADO}            Set Variable    ${ARQ_API_11["user"]["email"]}
    ${SENHA_ESPERADO}            Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["password"]}    
    Log    \n 1:${EMAIL_ESPERADO}/${SENHA_ESPERADO}    console=${LOG_CONSOLE}    
    ${DADOS_ENVIAR}    Evaluate    {'email': (None, '${EMAIL_ESPERADO}'), 'password': (None, '${SENHA_ESPERADO}')}
    ${DADOS_RETORNO_API}      POST On Session    MINHA_SESSAO_API    ${END_POINT_VERIFY_LOGIN}    data=${DADOS_ENVIAR}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Log    \n Status:${DADOS_RETORNO_API}      console=${LOG_CONSOLE}
    Log    \n Dados :${DADOS_RETORNO_API.json()}      console=${LOG_CONSOLE}
    
API 07: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 07: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}    ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=     Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}    
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 08: Dispara requisicao
    [Arguments]    ${ARQ_DADOS_PARA_CADASTRO}
    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO}    Load JSON From File    ${CURDIR}${ARQ_DADOS_PARA_CADASTRO}
    ${SENHA_ESPERADO}            Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["password"]}
    ${DADOS_ENVIAR}    Evaluate    {'password': (None, '${SENHA_ESPERADO}')} 
    ${DADOS_RETORNO_API}      POST On Session    MINHA_SESSAO_API    ${END_POINT_VERIFY_LOGIN}    data=${DADOS_ENVIAR}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    
API 08: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 08: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=     Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 09: Dispara requisicao
    ${DADOS_RETORNO_API}      DELETE On Session    MINHA_SESSAO_API    ${END_POINT_VERIFY_LOGIN}   
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Log    \n Status:${DADOS_RETORNO_API}      console=${LOG_CONSOLE}
    Log    \n Dados :${DADOS_RETORNO_API.json()}      console=${LOG_CONSOLE}
    
API 09: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 09: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=     Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 10: Dispara requisicao
    [Arguments]    ${ARQ_API_11}   
    ${ARQ_API_11}    Load JSON From File    ${CURDIR}${ARQ_API_11}
    ${EMAIL_ESPERADO}            Set Variable    ${ARQ_API_11["user"]["email"]}
    ${SENHA_ESPERADO}            Set Variable    email-invalido
    ${DADOS_ENVIAR}    Evaluate    {'email': (None, '${EMAIL_ESPERADO}'), 'password': (None, '${SENHA_ESPERADO}')}
    ${DADOS_RETORNO_API}      POST On Session    MINHA_SESSAO_API    ${END_POINT_VERIFY_LOGIN}    data=${DADOS_ENVIAR}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    
API 10: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 10: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=     Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 11: Dispara requisicao    
    [Arguments]    ${ARQ_DADOS_PARA_CADASTRO}    ${ARQ_API_11}
    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO}    Load JSON From File    ${CURDIR}${ARQ_DADOS_PARA_CADASTRO}
    ${NOME_ESPERADO}             Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["name"]}
    ${EMAIL_ESPERADO}            Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["email"]}    
    ${TITULO_ESPERADO}           Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["title"]}
    ${DIA_ANIVERSARIO_ESPERADO}  Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_day"]}
    ${MES_ANIVERSARIO_ESPERADO}  Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_month"]}
    ${ANO_ANIVERSARIO_ESPERADO}  Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_year"]}
    ${PRIMEIRO_NOME_ESPERADO}    Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["first_name"]}
    ${SOBRE_NOME_ESPERADO}       Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["last_name"]}
    ${EMPRESA_ESPERADO}          Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["company"]}
    ${ENDERECO1_ESPERADO}        Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["address1"]}
    ${ENDERECO2_ESPERADO}        Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["address2"]}
    ${PAIS_ESPERADO}             Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["country"]}
    ${ESTADO_ESPERADO}           Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["state"]}
    ${CIDADE_ESPERADO}           Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["city"]}
    ${CEP_ESPERADO}              Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["zipcode"]}
    ${PASSWORD_ESPERADO}         Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["password"]}
    ${CELULAR_ESPERADO}          Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["mobile_number"]}
    ${DADOS_ENVIAR}    Create Dictionary    name=${NOME_ESPERADO}  email=${EMAIL_ESPERADO}  title=${TITULO_ESPERADO}  birth_date=${DIA_ANIVERSARIO_ESPERADO}  
    ...  birth_month=${MES_ANIVERSARIO_ESPERADO}  birth_year=${ANO_ANIVERSARIO_ESPERADO}  firstname=${PRIMEIRO_NOME_ESPERADO}  lastname=${SOBRE_NOME_ESPERADO}  
    ...  company=${EMPRESA_ESPERADO}  address1=${ENDERECO1_ESPERADO}  address2=${ENDERECO2_ESPERADO}  country=${PAIS_ESPERADO}  state=${ESTADO_ESPERADO}  
    ...  city=${CIDADE_ESPERADO}  zipcode=${CEP_ESPERADO}  password=${PASSWORD_ESPERADO}  mobile_number=${CELULAR_ESPERADO}
    Log    \n101:${DADOS_ENVIAR}    console=${LOG_CONSOLE}
    ${DADOS_RETORNO_API}    POST On Session    MINHA_SESSAO_API    ${END_POINT_CREATEACCOUNT}    data=${DADOS_ENVIAR}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    ${RESPONSE_CODE_STATUS}    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode    
    &{PARAMS}           Create Dictionary    email=${EMAIL_ESPERADO}
    ${uri}     Set Variable  /getUserDetailByEmail?email=${PARAMS.email}
    ${$DADOS_RETORNO_API_GET}        GET On Session          MINHA_SESSAO_API   ${uri}    params=${PARAMS}
    Set Suite Variable    ${$DADOS_RETORNO_API_GET}    ${$DADOS_RETORNO_API_GET}
    Set Suite Variable    ${STATUS_CODE}    ${$DADOS_RETORNO_API_GET.status_code}
    Log    \n Status:${$DADOS_RETORNO_API_GET}      console=${LOG_CONSOLE}
    Log    \n 102 :${$DADOS_RETORNO_API_GET.json()}      console=${LOG_CONSOLE}
    ${ID_RETORNADO}    Get Value From Json    ${$DADOS_RETORNO_API_GET.json()}    $.user.id
    ${ID_RETORNADO}    Convert To String    ${ID_RETORNADO}
    ${ID_RETORNADO}    Replace String    ${ID_RETORNADO}    [    ${EMPTY}
    ${ID_RETORNADO}    Replace String    ${ID_RETORNADO}    ]    ${EMPTY}
    ${ID_RETORNADO}    Convert To Integer    ${ID_RETORNADO}
    Log    \n _ID_ :${ID_RETORNADO}      console=${LOG_CONSOLE}
    ${CONTEUDO_ARQ_API_11}   Load JSON From File     ${CURDIR}${ARQ_API_11}    
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.responseCode    ${STATUS_CODE}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.id    ${ID_RETORNADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.name    ${NOME_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.email    ${EMAIL_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.title    ${TITULO_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.birth_day    ${DIA_ANIVERSARIO_ESPERADO}  
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.birth_month    ${MES_ANIVERSARIO_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.birth_year    ${ANO_ANIVERSARIO_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.first_name    ${PRIMEIRO_NOME_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.last_name    ${SOBRE_NOME_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.company    ${EMPRESA_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.address1    ${ENDERECO1_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.address2    ${ENDERECO2_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.country    ${PAIS_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.state    ${ESTADO_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.city    ${CIDADE_ESPERADO}
    ${CONTEUDO_ARQ_API_11}   Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.zipcode    ${CEP_ESPERADO}
    Dump Json To File     ${CURDIR}${ARQ_API_11}     ${CONTEUDO_ARQ_API_11}

API 11: Verifica Status code 
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Log    \nSTATUS_CODE:<${STATUS_CODE}>    console=${LOG_CONSOLE}
    Log    \STATUS_CODE_ESPERADO:<${STATUS_CODE_ESPERADO}>    console=${LOG_CONSOLE}
    Should Be Equal As Numbers     ${STATUS_CODE_ESPERADO}    ${STATUS_CODE}   

API 11: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}      Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers   ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}     Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings   ${RESPONSE_CODE_MESSAGE_ESPERADO}    ${RESPONSE_CODE_MESSAGE}    



API 12: Dispara requisicao
    [Arguments]    ${ARQ_API_11}    ${ARQ_DADOS_PARA_CADASTRO}
    ${ARQ_API_11}    Load JSON From File    ${CURDIR}${ARQ_API_11}
    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO}    Load JSON From File    ${CURDIR}${ARQ_DADOS_PARA_CADASTRO}
    ${EMAIL_ESPERADO}            Set Variable    ${ARQ_API_11["user"]["email"]}
    ${SENHA_ESPERADO}            Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["password"]}
    ${DADOS_ENVIAR}    Evaluate    {'email': (None, '${EMAIL_ESPERADO}'), 'password': (None, '${SENHA_ESPERADO}')}
    ${DADOS_RETORNO_API}      DELETE On Session    MINHA_SESSAO_API    ${END_POINT_DELETEACCOUNT}    data=${DADOS_ENVIAR}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    
API 12: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 12: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers    ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings    ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 13: Dispara requisicao de atualização de endereco   
    [Arguments]    ${NOVO_ENDERECO1_ESPERADO}    ${ARQ_DADOS_PARA_CADASTRO}    ${ARQ_API_11}    ${ARQ_API_13}    
    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO}    Load JSON From File    ${CURDIR}${ARQ_DADOS_PARA_CADASTRO}
    ${NOME_ESPERADO}             Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["name"]}
    ${EMAIL_ESPERADO}            Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["email"]}    
    ${TITULO_ESPERADO}           Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["title"]}
    ${DIA_ANIVERSARIO_ESPERADO}  Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_day"]}
    ${MES_ANIVERSARIO_ESPERADO}  Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_month"]}
    ${ANO_ANIVERSARIO_ESPERADO}  Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["birth_year"]}
    ${PRIMEIRO_NOME_ESPERADO}    Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["first_name"]}
    ${SOBRE_NOME_ESPERADO}       Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["last_name"]}
    ${EMPRESA_ESPERADO}          Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["company"]}
    ${ENDERECO1_ESPERADO}        Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["address1"]}
    ${ENDERECO2_ESPERADO}        Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["address2"]}
    ${PAIS_ESPERADO}             Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["country"]}
    ${ESTADO_ESPERADO}           Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["state"]}
    ${CIDADE_ESPERADO}           Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["city"]}
    ${CEP_ESPERADO}              Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["zipcode"]}
    ${PASSWORD_ESPERADO}         Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["password"]}
    ${CELULAR_ESPERADO}          Set Variable    ${CONTEUDO_ARQ_DADOS_PARA_CADASTRO["user"]["mobile_number"]}
    ${DADOS_ENVIAR}    Create Dictionary    name=${NOME_ESPERADO}  email=${EMAIL_ESPERADO}  title=${TITULO_ESPERADO}  birth_date=${DIA_ANIVERSARIO_ESPERADO}  
    ...    birth_month=${MES_ANIVERSARIO_ESPERADO}   birth_year=${ANO_ANIVERSARIO_ESPERADO}  firstname=${PRIMEIRO_NOME_ESPERADO}  lastname=${SOBRE_NOME_ESPERADO}  
    ...  company=${EMPRESA_ESPERADO}  address1=${NOVO_ENDERECO1_ESPERADO}  address2=${ENDERECO2_ESPERADO}  country=${PAIS_ESPERADO}  state=${ESTADO_ESPERADO}  
    ...  city=${CIDADE_ESPERADO}  zipcode=${CEP_ESPERADO}  password=${PASSWORD_ESPERADO}  mobile_number=${CELULAR_ESPERADO}
    Log    \n103:${DADOS_ENVIAR}    console=${LOG_CONSOLE}
    ${DADOS_RETORNO_API}    PUT On Session    MINHA_SESSAO_API    ${END_POINT_UPDATEACCOUNT}    data=${DADOS_ENVIAR}
    Log    \n 6:<${DADOS_RETORNO_API}>    console=${LOG_CONSOLE}
    Log    \n 7:<${DADOS_RETORNO_API.json()}>    console=${LOG_CONSOLE}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    ${RESPONSE_CODE_STATUS}    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode    
    ${CONTEUDO_ARQ_API_11}    Load JSON From File     ${CURDIR}${ARQ_API_11}    
    ${CONTEUDO_ARQ_API_11}    Update Value To Json    ${CONTEUDO_ARQ_API_11}    $.user.address1    ${NOVO_ENDERECO1_ESPERADO}
    Dump Json To File       ${CURDIR}${ARQ_API_11}    ${CONTEUDO_ARQ_API_11}

API 13: Verifica Status code 
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Log    \nSTATUS_CODE:<${STATUS_CODE}>    console=${LOG_CONSOLE}
    Log    \STATUS_CODE_ESPERADO:<${STATUS_CODE_ESPERADO}>    console=${LOG_CONSOLE}
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 13: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}   ${RESPONSE_CODE_MESSAGE_ESPERADO}
    ${RESPONSE_CODE_STATUS}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers    ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_MESSAGE}=    Get From Dictionary    ${DADOS_RETORNO_API.json()}    message
    Should Be Equal As Strings    ${RESPONSE_CODE_MESSAGE}    ${RESPONSE_CODE_MESSAGE_ESPERADO}



API 14: Dispara requisicao
    [Arguments]   ${ARQ_API_11}
    ${ARQ_API_11}    Load JSON From File    ${CURDIR}${ARQ_API_11}
    ${EMAIL_ESPERADO}            Set Variable    ${ARQ_API_11["user"]["email"]}
    Log    \n 1:${EMAIL_ESPERADO}    console=${LOG_CONSOLE}
    &{PARAMS}           Create Dictionary    email=${EMAIL_ESPERADO}
    ${uri}     Set Variable  /getUserDetailByEmail?email=${PARAMS.email}
    ${DADOS_RETORNO_API}        GET On Session          MINHA_SESSAO_API   ${uri}    params=${PARAMS}
    Set Suite Variable    ${DADOS_RETORNO_API}    ${DADOS_RETORNO_API}
    Set Suite Variable    ${STATUS_CODE}    ${DADOS_RETORNO_API.status_code}
    
API 14: Verifica Status code     
    [Arguments]  ${STATUS_CODE_ESPERADO}    
    Should Be Equal As Numbers    ${STATUS_CODE}    ${STATUS_CODE_ESPERADO}

API 14: Verifica Response Code 
    [Arguments]  ${RESPONSE_CODE_STATUS_ESPERADO}
    ${RESPONSE_CODE_STATUS}    Get From Dictionary    ${DADOS_RETORNO_API.json()}    responseCode
    Should Be Equal As Numbers    ${RESPONSE_CODE_STATUS}    ${RESPONSE_CODE_STATUS_ESPERADO}

API 14: Verifica retorno dados cadastro    
    [Arguments]    ${CAMINHO_DADOS_CADASTRO_USUARIO}
    ${DADOS_PARA_CADASTRAR}    Load Json From File    ${CURDIR}${CAMINHO_DADOS_CADASTRO_USUARIO}
    Should Be Equal As Strings   ${DADOS_PARA_CADASTRAR}     ${DADOS_RETORNO_API.json()}
    
API 14: Verifica o Schema/Contrato modelo no caminho   
    [Arguments]    ${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}
    ${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}    Set Variable    ${CURDIR}${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}
    Validate Json By Schema File    ${DADOS_RETORNO_API.json()}    ${CAMINHO_CONTRATO_DADOS_CADASTRO_USUARIO}







### Apoio web ###
Executa teste usando    
    @{LISTA_BROWSER}   Set Variable      Chrome   Firefox   Edge   HeadlessFirefox   HeadlessEdge    HeadlessChrome   #    
    FOR    ${exec}    IN RANGE    1    4
        Log    \nExecucao de número.....:${exec}    console=${LOG_CONSOLE}
        FOR    ${execucao}    IN    @{LISTA_BROWSER}
            # Pre condições: descomente conforme a necessidade
            # Condicao ter usuario cadastrado: chamando api de criacao
            # Condicao não ter usuario cadastrado: chamando api de delecao
            # Colcar abaixo so CT desejados no loop

           



            Fechar browser
        END
    END