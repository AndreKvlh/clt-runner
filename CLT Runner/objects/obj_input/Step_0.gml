//A cada frame, irá ser atualizado o nome exibido corrigindo para o limite
if(campo_ativo) {
	if(string_length(keyboard_string) > lim_char) keyboard_string = string_copy(keyboard_string, 1, lim_char);
	nome_digitado = keyboard_string;
}
