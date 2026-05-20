//A instância do obstáculo já começará com uma velocidade vertical fazendo-o seguir
//de cima para baixo
vspeed = global.vspeed_geral;

//Variável para controle da velocidade da animação
image_speed = 0.5;

//Iremos inverter a imagem caso ele fique a direita
if (x > CENTRO_SALA) image_xscale *= -1;