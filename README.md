# Projeto Fechadura SMART

* Feita em React com bootstrap
* Possui um barramento de Micro Serviços e 2 serviços
* Os MicroS tem o intuito de simular o comportamento do Hardware do nosso outro projeto de Micro Controladores e Sistemas Embarcados, o qual faz uso de 2 microControladores, 1 para gerenciar os perifeicos como:
###### [ ] Leitor de Digital
###### [ ] RFID 
###### [ ] Teclado numerico
###### [ ] Giroscopio com acelerometro, para detectar arrombamento
###### [ ] Visor Oled
###### [ ] comunicação serial com o outro Microcontrolador ESP32 via UART
###### [ ] abertura e fechamento do solenoid

*Já o ESP32 teria a função defornecer ao front as funcionalidades e informações, por meio de atuação como um ponto de acesso e envio de JSONs, nesse caso representado pelo Micro serviço Cadastros.js

* O Front faz atualizaçoes constantes sobre o estado da fechadura por meio de chamdas de conexao com o barramento a cada 1 segundo. Recebendo numero de usuarios cadastrados,nomes,tipos de autenticações. E também o nome do ultimo usuario a desbloquear a fechadura.

* O desbloqueio so pode ser feito mediante previa autenticação 

* O cadastro de usuarios deve ser feito manualmente no banco de dados local volatil, bem como requisiçoes POST ao barramento /ADD

* O acesso as funcionalidades que podem ser feitas devem ser acessadas via barramento, pelas seguintes partes:

[ ] http://127.0.0.1:5000/GET -> para recebimento dos usuarios com senhas e ids (não deve ser utilizado pelo front por questao de segurança dos dados, é apenas para uso interno e autenticação entre os MiroSrviços)

* ao se fazer a requisição para esse endereço via metodo GET é retornado a lista completa do banco de dados, isso inclui nomes, senhas etc.
* Com metodo POST, o Json retornado contem as mesmas partes que o riginal, porem, as senhas,IDs, e outras formas de autenticações sao substituidas por um vazio ('')

[ ] http://127.0.0.1:5000/ADD -> feito para cadastramento de usuarios novos ao banco de dados, o envio deve ser um Json, contendo (Nome,ID,SENHA,RFID,DIGITAL), no caso da fechadura real, tanto o RFID como a a Digital sao codigos templates, no RFID representa o codigo contido no cartao, e na Digital, representa o id da digital salva internamente no leitor.

[ ] http://127.0.0.1:5000/DEST -> Utilizado para o destravamento da fechadura, deve ser utilizado mandando um JSON, contendo o nome do usuario e uma das maneiras de autenticação, podendo ser Senha, RFID ou digital.

[ ] http://127.0.0.1:5000/TRANC -> Utilizado para o travamento da fechadura, na fechadura real, isso nao cabe ao front, o controlador que gerencia o tempo de abertura, pois como a abertura é feita por meio de um solenoid, o mesmo consome muita corrente, e caso permaneça muito tempo aberto causara danos ao sistema. no caso da simulação o gerenciamento é feito no proprio front, esperando 3 segundos antes de mandar a requisição de fechamento.

[ ] http://127.0.0.1:5000/ULT -> Feito para utilização interna entre os Serviçoes para alertar quem foi o ultimo a dsbloquear a fechadura, por meio de um JSON contendo o nome da pessoa.
