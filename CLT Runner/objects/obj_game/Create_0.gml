//Iremos criar um alarme que irá ter um valor randômico de frames para ser ativado
//este alarme servirá para gerar randomicamente instância de obstáculos
alarm[0] = random_range(60, 120);

//Já o alarme abaixo irá gerar os consumíveis;
alarm[1] = random_range(30, 90);

//Por fim vamos colocar uma soundtrack durante toda a
//gameplay
audio_sound_gain(snd_jogo, 0.1);
if (!audio_is_playing(snd_jogo)) audio_play_sound(snd_jogo, 0, true);