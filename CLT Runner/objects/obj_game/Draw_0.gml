//No caso de game over, irá ser acionado uma outra ação a fim de criar o texto
//do menu, controlado por outra variável
if(menu_game_over) {
	draw_text_with_border(CENTRO_SALA, 50, "GAME OVER", c_red, c_black, 3);
	draw_text_with_border(CENTRO_SALA, 120, "Sua maior\npontuacao foi:", c_white, c_black, 3);
	draw_text_with_border(CENTRO_SALA, 180, global.hiscore, c_yellow, c_black, 3);
	draw_text_with_border(CENTRO_SALA, 220, "Digite o seu nome:", c_white, c_black, 3);
}

//Por algum motivo o draw continua mesmo após o return, trava de segurança
if(game_over) return;

//Desenha a pontuação no canto superior esquerdo da tela
draw_set_font(fnt_pontuacao);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

//Variáveis que armazenam a posição X e Y desejadas pro placar
var pos_x = 20;
var pos_y = 20;

//Função definida no scr_text_functions que serve para criar um
//texto com borda
draw_text_with_border(pos_x, pos_y, obj_personagem.pontuacao, c_white, c_black, 3);

//Iremos desenhar o hiscore somente se ele for maior que zero
if (global.hiscore > 0) draw_text_with_border(CENTRO_SALA, pos_y, global.hiscore, c_yellow, c_black, 3);

