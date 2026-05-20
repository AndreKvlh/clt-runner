//Iremos tocar um som quando pegar o objeto para depois
//destruí-lo

audio_sound_gain(snd_pickup, 0.1);
audio_play_sound(snd_pickup, 0, false);

//Também iremos adicionar a pontuação equivalente do alimento a
//pontuação do jogador

obj_personagem.pontuacao += pontos;

instance_destroy();