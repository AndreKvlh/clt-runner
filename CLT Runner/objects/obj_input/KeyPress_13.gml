if (!campo_ativo) return;

//Aqui ao dar enter ele irá inativar o campo até ser clicado novamente
if (nome_digitado == "") nome_digitado = "Anonimo";
campo_ativo = false;

show_debug_message(nome_digitado);