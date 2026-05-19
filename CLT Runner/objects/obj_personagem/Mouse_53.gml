//Condição de escape caso jogador esteja paralisado
if (paralisado) return;

//Com o mouse, como é só um botão, para alternarmos entre ruas, iremos usar o operador
//ternário pois diferente dos botões, cada clique vai alternar o jogador de lado
x = x > CENTRO_SALA ? POSICAO_ESQ : POSICAO_DIR;

//Aqui iremos inverter a imagem sempre que clicar. Como não temos botões distintos para
//isso como a versão do teclado, aqui cada clique é uma posição diferente
image_xscale *= -1;