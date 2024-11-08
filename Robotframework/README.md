# Robotframework #

### Objetivo ###

Este conteúdo é o resultado da intenção de demonstrar na prática como realizo teste em interface WEB (UI) e API utilizando Robotframework.

Vale reforçar que para os testes utilizei um Site público do qual não sou autor de URL: https://automationexercise.com e foram realizados todos os desafios contidos na lista do referido Site.


![Site_Teste_WEB](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Site_lista_teste.png)

Aproveito para agradecer aos autores a publicação do Site e dos serviços nele contidos.

-------------

### Preparação do ambiente ###

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

### Execução do teste ###

Para executar um script Robot, temos de abrir um console ou o terminal do VS Code, ir até a pasta onde se encontra os scripts e executar o comando 'robot [nome do script]', nos testes que estou disponibilizando, fica como descrito abaixo:

```bash
robot Caso_Teste.robot 
```

No entanto, o Robot permite realizar alguns parametros como veremos.

Gerando uma pasta de Log para receber os arquivos de report que o Robot gera. Para tanto, basta adicionar o parâmetro -d [nome da pasta].

```bash
robot -d Logs Caso_Teste.robot 
```

Abaixo o relatório gerado de todos os Casos de Testes (WEB + API):

![Robot_Report_Geral](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Robot_Report_Geral.png)


Um outro parametro interassante disponível que foi configurado é executar somente alguns Casos de Testes espefíficos, onde para tanto, basta adicionar tags no código '[tags] TC_WEB_01 TC_WEB'. 
Desta forma, temos como executar todos os Casos de Testes WEB passando somente o parâmetro '-i "tag desejada"', como abaixo:

```bash
robot -d Logs -i "TC_WEB"  Caso_Teste.robot
```

![Robot_Report_WEB](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Robot_Report_WEB.png)

Agora se desejarmos executar somente o Caso de Teste WEB 25, para isso o comando ficaria:

```bash
robot -d Logs -i "TC_WEB_25"  Caso_Teste.robot
```

![Robot_Report_WEB_25](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Robot_Report_WEB_25.png)


Reforçando que neste script, além de todos os testes contidos na lista do Site sobre teste de interface WEB (UI), implementei também todos os  Casos de Testes contidos na lista de teste API e com as mesmas validações escritos para API com Postman. Desta maneira, para executar somente os Casos de Testes API podemos passar o comando:

```bash
robot -d Logs -i "TC_API"  Caso_Teste.robot
```

![Robot_Report_API](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Robot_Report_API.png)

Ainda se desejarmos executar somente um Caso de Tesde de API, então podemos passar o comando:

```bash
robot -d Logs -i "TC_API_03"  Caso_Teste.robot
```

![Robot_Report_API_03](https://github.com/adielpereiramachado/Robot_Postman_Automationexercise_WEB_API/blob/main/Arquivos%20de%20apoio/Robot_Report_API_03.png)

O Robot permite ainda passar na linha de comando de execução do teste um parametro mudando valor de variaveis dentro do script, assim sendo desnecessário abrir, alterar e salvar o código para executar com o novo valor, ao invé disso, basta passar o parâmetro -v [nome da variavel:valor] e com isso somente nessa execução a variavel terá o valor conforme passado na linha de comando.

No código foi previsto algumas variaveis que podemos mudar o valor pela linha de comando, são elas:

'${BROWSER}' -> Indica o Browser usado no testes, podendo ser Chrome; HeadlessChrome; Firefox; HeadlessFirefox; Edge; HeadlessEdge. Valor pardão 'Chrome'.

'${TEMPO_ESPERA}'   -> Especifica o tempo de espera para encontrar um elemento esperado na página. Valor pardão '10'.

'${SELENIUM_SPEED}' -> Especifica o 'rápido' os testes serão atrasados quanto a velocidade máxima padrão. No caso configurei para ter 0.2 de atraso.

'${LOG_CONSOLE}'    -> Especifica se haverá exibição de log no console de execução ou não. No caso configurei como padrão para não exibir, ou seja, valor 'false')

Assim, um exemplo pontual, se quiser executar o código de teste passando para ser aberto o Firefox, ao invés do Chrome que é o padrão e não quer abrir o código, alterar o valor e salvar, basta passa no comando de execução:

```bash
robot -d Logs -i "TC_WEB" -v BROWSER:Firefox Caso_Teste.robot
```

A escolha de uma variável pode ser utilizada em combinação com outra, por exemplo abaixo demonstro como ficaria se desejasse passar para abrir o Firefox e logando informações no console:


```bash
robot -d Logs -i "TC_WEB" -v BROWSER:Firefox -v LOG_CONSOLE:True Caso_Teste.robot
```


