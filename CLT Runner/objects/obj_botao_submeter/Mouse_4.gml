//Pressionando o botão ele irá salvar as informações do jogador
//no leaderboard do LootLocker
LootLockerSetPlayerName(obj_input.nome_digitado);
LootLockerSubmitScore("34581", global.hiscore);

//Vamos zerar a pontuação
global.hiscore = 0;

//Resetar a velocidade também
global.vspeed_geral = 4;

//POR ENQUANTO vamos apenas resetar a room
room_goto(rm_menu);