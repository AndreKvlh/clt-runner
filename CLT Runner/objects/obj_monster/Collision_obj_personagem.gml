//Se caso o jogador tiver tomado dois e for tomar o terceiro
//aí é caixão e vela preta. Vai começar a tocar One Last Breath
//do Creed e Jesus leva pra perto
if (obj_personagem.qtd_monster == 2) {
	global.hiscore = obj_personagem.pontuacao;
	global.vspeed_geral = 4;
	room_restart();
	return;
}

//No uso normal, ele vai te deixar imune por uns 120 frames
obj_personagem.qtd_monster++;
obj_personagem.monster = true;
obj_personagem.alarm[1] = 120;

//Vamos alterar a cor do personagem enquanto estiver no efeito
//do Monster
obj_personagem.image_blend = c_orange;

//Destrói a instância do Monster
instance_destroy();