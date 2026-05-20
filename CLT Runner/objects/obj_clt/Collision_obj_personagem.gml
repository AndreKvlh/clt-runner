//Iremos incrementar o hiscore com a pontuação atual do jogador
//apenas se a pontuação do jogador for maior que o hiscore
if (obj_personagem.pontuacao > global.hiscore) global.hiscore = obj_personagem.pontuacao;

//Reseta a velocidade global
global.vspeed_geral = 4;

//Ao colidir com o nosso personagem, a room será reiniciada
room_restart();