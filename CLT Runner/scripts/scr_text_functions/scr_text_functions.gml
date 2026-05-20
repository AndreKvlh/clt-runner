//Função que serve como uma alternativa ao draw_text a fim de desenhar um contorno
//no texto.

function draw_text_with_border(pos_x, pos_y, texto, cor_texto, cor_borda, offset = 1) {
	//Para desenhar a borda irá ser desenhado quatro vezes o texto com um offset para
	//cada lado a fim de deixá-lo maior para o texto de fato
	draw_set_colour(cor_borda);
	draw_text(pos_x - offset, pos_y, texto);
	draw_text(pos_x + offset, pos_y, texto);
	draw_text(pos_x, pos_y - offset, texto);
	draw_text(pos_x, pos_y + offset, texto);

	//Desenha o texto central, agora com borda
	draw_set_colour(cor_texto);
	draw_text(pos_x, pos_y, texto);
}