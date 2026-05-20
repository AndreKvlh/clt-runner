//Para gerar o carro, precisamos determinar a posição y já que
//ele virá da parte inferior direita ou da parte superior esquerda
var pos_x = choose(POSICAO_ESQ + 22,POSICAO_DIR - 22);
var pos_y = pos_x > CENTRO_SALA ? room_height + 128 : -128;

//Aqui iremos então criar o carro e setar um alarme num espaço aleatório
instance_create_layer(pos_x, pos_y, "Obstaculos", obj_carro);
alarm[2] = random_range(200, 300);