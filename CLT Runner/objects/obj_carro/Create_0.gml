//A instância do obstáculo já começará com uma velocidade vertical fazendo-o seguir
//de cima para baixo
vspeed = global.vspeed_geral + 4;

//Iremos inverter a imagem caso ele fique a direita
if (x > CENTRO_SALA) {
	image_yscale *= -1;
	image_xscale *= -1;
	vspeed *= -1;
}