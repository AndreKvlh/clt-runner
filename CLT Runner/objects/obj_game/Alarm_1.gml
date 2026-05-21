//Iremos escolher um lado para gerar o objeto e posicionar fora
//da sala
var pos_x = choose(POSICAO_DIR, POSICAO_ESQ);
var pos_y = -100;

//Após definirmos a posição, iremos escolher qual objeto de comida
//instanciar
var obj_selecionado = choose(obj_batata, obj_chocolate, obj_coxinha, obj_hamburguer);

//No caso de estar acima de 300 pontos, há uma chance da comida vir vencida (20%)
var rolagem = random_range(1, 100);
if(level >= 4 && rolagem >= 80) obj_selecionado = obj_comida_vencida;	
if(rolagem >= 95) obj_selecionado = obj_monster;

//Com isso, vamos gerar o objeto na sala
instance_create_layer(pos_x, pos_y, "Comidas", obj_selecionado);

alarm[1] = random_range(30,90);