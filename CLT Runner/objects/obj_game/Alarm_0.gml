//Iremos escolher um lado para gerar o objeto e posicionar fora
//da sala
var pos_x = choose(POSICAO_DIR, POSICAO_ESQ);
var pos_y = -100;

//Com isso, vamos gerar o objeto na sala
instance_create_layer(pos_x, pos_y, "Obstaculos", obj_clt);

alarm[0] = random_range(60,120);