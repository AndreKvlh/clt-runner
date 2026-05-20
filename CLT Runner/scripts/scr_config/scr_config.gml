//Função para criar uma nova seed para de fato randomizar o jogo
randomise();

//Constante que ajudará a gente posicionar os objetos na sala. Ao usar eles, irá posicionar
//O eixo na posição X dita
#macro POSICAO_ESQ 32
#macro POSICAO_DIR room_get_info(rm_jogo).width - 32
#macro CENTRO_SALA room_get_info(rm_jogo).width / 2
