### Robotframework ###

----------

Este conteúdo é o resultado da intenção de demonstrar na prática como realizo teste em interface WEB (UI) e API utilizando Robotframework.

Vale reforçar que para os testes utilizei um Site público do qual não sou autor de URL: https://automationexercise.com e foram realizados todos os desafios contidos na lista do referido Site.


![Site_Teste_WEB](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Site_lista_teste.png)

Aproveito para agradecer aos autores a publicação do Site e dos serviços nele contidos.

-------------

Para a escrita e execução dos testes foi necessário 4 software/ferramentas: VS Code, Python, Robotframework e Webdrivers (e suas bibliotecas opcionais)

VS Code, para escrever o script de teste.

Pyhon, pois os scripts de testes são interpretados pelo interpretador Python.

Robotframework, que é o framework no qual escrevemos os comandos de execução do teste.

Webdrivers, são drivers que possibilitam controle dos Browser ao Robotframework.

- **VS Code**:
  
Para instalar o VS Code em seu computador, consulte: https://code.visualstudio.com/download  
Na data deste post, a versão utilizada é: 1.95.2

- **Python**:

Para instalar o Python em seu computador, consulte: https://www.python.org/downloads

:information_source: Importante: Durane a instalação, marque as opções: 'Use admin privileges when installing py.exe' e 'Add python.exe to PATH'.


Para verificar se a instalação ocorreu com sucesso, execute o comando abaixo, onde deve ser exibida a versão do Python instalado:


```bash
python --version
```

Na data deste post, a versão utilizada é: 3.12.6

- **Robotframework**:

Para instalar o Robotframework em seu computador, execute o comando abaixo em um console aberto com permissões Admin

```bash
pip install robotframework
```

Para instalar as bibliotécas segue abaixo as que tenho instalado. Da mesma forma execute o comando abaixo em um console aberto com permissões Admin:

```bash
pip install robotframework-assertion-engine
```

```bash
pip install robotframework-browser
```

```bash
pip install robotframework-difflibrary
```

```bash
pip install robotframework-seleniumlibrary
```

```bash
pip install robotframework-jsonlibrary
```

```bash
pip install robotframework-jsonschemalibrary
```

```bash
pip install robotframework-requests
```

:information_source: Caso esteja instalando em Linux (snap) considere adicionar o sufixo '--break-system-packages' em todos os comandos descritos, dessa forma o comando de instação do robotframework, ficaria como descrito abaixo: 

```bash
pip install robotframework --break-system-packages
```

Na data deste post, as versões utilizadas: 

robotframework==7.1 | robotframework-assertion-engine==3.0.3 | robotframework-browser==18.8.0 | robotframework-difflibrary==0.1.0 | robotframework-jsonlibrary==0.5 | robotframework-jsonschemalibrary==1.0 | robotframework-requests==0.9.7 | robotframework-seleniumlibrary==6.6.1


- **Webdrivers**:

Para instalar os Webdrivers em seu computador, devemos baixar cada um deles (Chrome, Firefox e Edge) e salvar em uma pasta, como veremos mais abaixo.

- Chrome: Para baixar devemos acessar o endereço https://developer.chrome.com/docs/chromedriver/downloads?hl=pt-br e depois, caso sua versão não seja exibida, deverá clicar em uma opção da página com o texto 'painel de disponibilidade do Chrome for Testing'. Recomendo baixar versão 'Stable' e para isso, click no link ao lado da identificação da 'Platforma' equivalente ao seu computador. 
Na data deste post, a versão utilizada é: 130.0.6723.116
  
- Firefox: Para baixar devemos acessar o endereço https://github.com/mozilla/geckodriver/releases e clicar baixar o arquivo de plataforma/formato equivalente ao seu computador (no caso de windows 64bits escolha por exemplo: geckodriver-v0.35.0-win-aarch64.zip). 
  Na data deste post, a versão utilizada é: 0.35.0

- Edge: Para baixar devemos acessar o endereço https://developer.microsoft.com/pt-br/microsoft-edge/tools/webdriver/?form=MA13LH e click para baixar o arquivo, dê prederência a versões estáveis. 
Na data deste post, a versão utilizada é: 130.0.2849.80

Abaixo demonstro uma sugestão de pasta para levar os 3 executateis de webdriver.
Abra a opção de 'Variaveis de Ambiente', depois descubra qual o caminho da variavél 'Path', pois a recomendação é colocar os executavéis na mesma pasta.

![Pasta_webdriver](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Pasta_webdriver.png)

:white_check_mark: Com isso, temos um ambiente configurado para escrever e executar os scripts de testes com Robotframework.

---------------

textook

