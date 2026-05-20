//Ao atingir o personagem, irá fazer a variável que controla
//a paralisia dele fazer efeito, com toda a lógica sendo feita
//no personagem
obj_personagem.paralisado = true;

//Deixa o jogador paralisado por cerca de 90 frames
obj_personagem.alarm[0] = 90;

//Altera a cor do personagem a fim de deixar com aparência cagada e fudida
obj_personagem.image_blend = c_green;