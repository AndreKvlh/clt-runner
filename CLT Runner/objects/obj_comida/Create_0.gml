//Primeiramente, ao ser criado irá ser criado um sprite randômico
//dentre os quatro disponíveis
sprite_index = choose(spr_batata, spr_chocolate, spr_coxinha, spr_hamburguer);

//Terá também uma velocidade vertical
vspeed = 4;

//Também o objeto será transformado conforme sua posição X
if(x > CENTRO_SALA) image_xscale *= -1;