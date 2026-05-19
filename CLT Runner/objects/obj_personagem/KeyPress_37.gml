//Condição de escape caso jogador esteja paralisado
if (paralisado) return;

//Aqui irá ocorrer uma inversão da imagem caso ele esteja abaixo do centro delimitado
//a fim de colocar os pés de acordo com a parte da calçada
if(x > CENTRO_SALA) image_xscale *= -1;

//A movimentação aqui não será uma movimentação aditiva mas sim colocar o jogador
//em determinado lugar. Neste caso, colocar ele a esquerda. 
x = POSICAO_ESQ;



