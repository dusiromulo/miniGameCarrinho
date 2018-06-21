# Mini Game Carrinho

Projeto escrito em Lua para löve2d que utiliza Node MCU para controlar os carrinhos e desviar dos obstáculos da pista.

O player que não conseguir desviar de um obstáculo perde e tem de esperar o próximo jogo para participar novamente.

## Conectando os Nodes

Antes de subir os arquivos, é necessário informar o SSID e senha da rede wifi para conexão com o servidor em wificonnect.lua.

Caso o wifi não possua uma conexão com internet, é preciso alterar o host que a aplicação utilizará. É preciso alterar para o IP da instância do servidor do Mosquitto na rede local.

Após feitas verificações acima, suba arquivos existentes dentro da pasta node para o node.

Execute o arquivo wificonnect.

## Executando o cliente

Usuários Windows: Arraste a pasta love para o ícone do LOVE que aplicação abrirá.

Usuários Linux: Execute num terminal de comando (substituindo $DIR pelo caminho até a pasta love/): "love $DIR"