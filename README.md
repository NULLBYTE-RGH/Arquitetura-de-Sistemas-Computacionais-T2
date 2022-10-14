# Projeto Fechadura SMART

### Front em React com bootstrap e Fontawesome
![FrontEnd](https://github.com/NULLBYTE-RGH/Arquitetura-de-Sistemas-Computacionais-T2/blob/92e824de3a616be7479e22cee170b40187b5cd5f/foto/Front.PNG)
* Possui um barramento de Micro Serviços e 2 serviços
* Os MicroS tem o intuito de simular o comportamento do Hardware do nosso outro projeto de [Micro Controladores e Sistemas Embarcados](https://github.com/NULLBYTE-RGH/Microcontroladores-e-Sistemas-Embarcados), o qual faz uso de 2 microControladores, 1 para gerenciar os perifeicos como:
###### [X] Leitor de Digital
###### [X] RFID 
###### [X] Teclado numerico
###### [X] Giroscopio com acelerometro, para detectar arrombamento
###### [X] Visor Oled
###### [X] comunicação serial com o outro Microcontrolador ESP32 via UART
###### [X] abertura e fechamento do solenoid

![Trilhas](https://github.com/NULLBYTE-RGH/Microcontroladores-e-Sistemas-Embarcados/blob/734ec019039ff5427eab8e21dd8d972c1e32a424/foto/Esquematico.png)

* Já o outro teria a função de fornecer ao front as funcionalidades e informações, por meio de atuação como um ponto de acesso WIFI e envio de JSONs, nesse caso representado pelo Micro serviço Cadastros.js

* O Front faz atualizaçoes constantes sobre o estado da fechadura por meio de chamadas de conexao com o barramento a cada 1 segundo. Recebendo numero de usuarios cadastrados,nomes e tipos de autenticações. Juntamente com o nome do ultimo usuario a desbloquear a fechadura.

* O desbloqueio so pode ser feito mediante previa autenticação 

* O cadastro de usuarios deve ser feito manualmente no banco de dados local volatil, bem como requisiçoes POST ao barramento /ADD

* O acesso as funcionalidades que podem ser feitas devem ser acessadas via barramento, pelas seguintes partes:

[X] http://127.0.0.1:5000/GET -> para recebimento dos usuarios com senhas e ids (não deve ser utilizado pelo front por questao de segurança dos dados, é apenas para uso interno e autenticação entre os MiroSrviços)

+ ***A variavel Usuarios, dentro de Cadastro.js, esta com o Json formatado de maneira errada, pois é a forma como chega ao ser trasmitida via UART no sistema real, e por conta disso foi decidido fazer o tratamento posterior deixando o "Json" em sua forma original de recebimento.***

* Ao se fazer a requisição para esse endereço via metodo *GET* é retornado a lista completa do banco de dados, isso inclui nomes, senhas etc.
* Com metodo *POST*, o Json retornado contem as mesmas partes que o riginal, porem, as senhas,IDs, e outras formas de autenticações sao substituidas por um * ('*')

[X] http://127.0.0.1:5000/ADD -> feito para cadastramento de usuarios novos ao banco de dados, o envio deve ser um Json, contendo (Nome,ID,SENHA,RFID,DIGITAL), no caso da fechadura real, tanto o RFID como a a Digital sao codigos templates, no RFID representa o codigo contido no cartao, e na Digital, representa o id da digital salva internamente no leitor.

[X] http://127.0.0.1:5000/DEST -> Utilizado para o destravamento da fechadura, deve ser utilizado mediante envio de um JSON, contendo o nome do usuario e uma das maneiras de autenticação, podendo ser Senha, RFID ou digital.

[X] http://127.0.0.1:5000/TRANC -> Utilizado para o travamento da fechadura, na fechadura real, isso nao cabe ao front, o controlador que gerencia o tempo de abertura, pois como a abertura é feita por meio de um solenoid, o mesmo consome muita corrente, e caso permaneça muito tempo aberto causara danos ao sistema. no caso da simulação o gerenciamento é feito no proprio front, esperando 3 segundos antes de mandar a requisição de fechamento.

[X] http://127.0.0.1:5000/ULT -> Feito para utilização interna entre os Serviçoes para alertar quem foi o ultimo a desbloquear a fechadura, por meio de um JSON contendo o nome da pessoa.

## Uso:
- Inicar o *Barramento* dentro da pasta MicroServiços/Barramento.js com o comando (node ./Barramento.js)
- Inicar o MicroServiço *Cadastro* dentro da pasta MicroServiços/Cadastro.js com o comando (node ./Cadastro.js)
- Inicar o MicroServiço *Fechadura* dentro da pasta MicroServiços/Fechadura.js com o comando (node ./Fechadura.js)
- Iniciar o servidor React dentro da pasta Raiz, com o comando (npm start)
