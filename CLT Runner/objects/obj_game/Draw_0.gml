//Desenha a pontuação no canto superior esquerdo da tela
draw_set_font(fnt_pontuacao);

//Variáveis que armazenam a posição X e Y desejadas pro placar
var pos_x = 20;
var pos_y = 20;

//Função definida no scr_text_functions que serve para criar um
//texto com borda
draw_text_with_border(pos_x, pos_y, obj_personagem.pontuacao, c_white, c_black, 3);

