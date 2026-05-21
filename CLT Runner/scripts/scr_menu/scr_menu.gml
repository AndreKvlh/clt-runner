function create_gameover_menu() {
	//Se estiver tocando música, para tudo
	audio_stop_all()
	
	//Criaremos o input
	instance_create_layer(CENTRO_SALA, (room_height / 2) -40, "Menu", obj_input);
	
	//Iremos criar os botões interativos
	instance_create_layer(CENTRO_SALA, (room_height / 2) +30, "Menu", obj_botao_reiniciar);
	instance_create_layer(CENTRO_SALA, (room_height / 2) +110, "Menu", obj_botao_submeter);
	
	//Alteraremos dentro do obj_game a variável de controle do menu
	obj_game.menu_game_over = true;
}