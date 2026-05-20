//Iremos escolher um lado para gerar o objeto e posicionar fora
//da sala
var pos_x = choose(POSICAO_DIR, POSICAO_ESQ);
var pos_y = -100;

//Após definirmos a posição, iremos escolher qual objeto de comida
//instanciar
var obj_selecionado = choose(obj_batata, obj_chocolate, obj_coxinha, obj_hamburguer);

//Com isso, vamos gerar o objeto na sala
instance_create_layer(pos_x, pos_y, "Obstaculos", obj_selecionado);

alarm[1] = random_range(30,90);