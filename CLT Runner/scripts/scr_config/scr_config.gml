//Devido ao HTML bugar o randomise, iremos usar esta função para inicializar
//uma seed no controlador universal do jogo (o mesmo que roda o LootLocker)
function inicializar_seed() {
	var datetime = date_current_datetime();
	random_set_seed(datetime);
}


//Constante que ajudará a gente posicionar os objetos na sala. Ao usar eles, irá posicionar
//O eixo na posição X dita
#macro POSICAO_ESQ 32
#macro POSICAO_DIR room_get_info(rm_jogo).width - 32
#macro CENTRO_SALA room_get_info(rm_jogo).width / 2

//Variáveis globais
global.hiscore = 0;
global.vspeed_geral = 4;
global.audio_on = true;