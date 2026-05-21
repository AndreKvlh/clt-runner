//Se o jogador estiver sob o efeito de Monster, ele é imune a colisão abaixo
if (obj_personagem.monster) return;

//Ao colidir com o personagem, ele irá tornar verdadeiro a condição de 
//game over do objeto controlador do jogo
obj_game.game_over = true;

//Iremos incrementar o hiscore com a pontuação atual do jogador
//apenas se a pontuação do jogador for maior que o hiscore
if (obj_personagem.pontuacao > global.hiscore) global.hiscore = obj_personagem.pontuacao;

//E irá destruir o personagem;
instance_destroy(other);


/*
//Reseta a velocidade global
global.vspeed_geral = 4;
*/