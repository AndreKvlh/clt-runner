//A cada frame, será verificado se a pontuação do jogador é igual ou maior
//ao level multiplicado por 100
if(obj_personagem.pontuacao >= level * 100) {
	//Coletar a ID atual da sala
	var bg_id = layer_get_id("Background");
	
	//Aumenta a variável global de velocidade;
	global.vspeed_geral += 0.2;
	layer_vspeed(bg_id, global.vspeed_geral);
	
	//Aumenta a variável level a fim de aumentar a barreira para um
	//novo incremento
	level++;
	show_debug_message(level);
}

//Condição que começa a gerar carros no cenário a partir de 500
//pontos
if(level == 6 && !gerar_carro) {
	alarm[2] = 300;
	gerar_carro = true;
}
