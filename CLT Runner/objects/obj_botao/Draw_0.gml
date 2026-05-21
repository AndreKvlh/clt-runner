//Método que permite escrever no botão
draw_self();

//Vamos usar a mesma fonte da pontuação
draw_set_font(fnt_pontuacao);

//Iremos alinhar o texto para caber na caixa
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Agora vamos usar o método que criamos para criar a mensagem
//do botão
draw_text_with_border(x, y, texto, c_white, c_black, 3);
