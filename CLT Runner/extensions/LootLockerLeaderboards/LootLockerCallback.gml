```gml
#define LootLockerCallback

// Get values
ini_open("LootLockerConfiguration.ini");
playerIdentifier = ini_read_string("playerIdentifier","id"," ");
sessionToken = ini_read_string("sessionToken","token"," ");
loginMapID = ini_read_string("loginMapID","id","0");
getHighscoresTopMapID = ini_read_string("getHighscoresTopMapID","id","0");
getHighscoresCenteredMapID1 = ini_read_string("getHighscoresCenteredMapID1","id","0");
getHighscoresCenteredMapID2 = ini_read_string("getHighscoresCenteredMapID2","id","0");
resetMapID = ini_read_string("resetMapID","id","-1");
leaderboardID = ini_read_string("leaderboardID","id"," ");
autoRefreshLeaderboards = ini_read_string("autoRefreshLeaderboard","bool","true");
autoRefreshLeaderboardsAmount = ini_read_string("autoRefreshLeaderboardAmount","count","10");
global.LootLockerPlayerID = ini_read_string("playerID","id"," ");
global.LootLockerPlayerName = ini_read_string("playerName","name"," ");
global.LootLockerPlayerRank = ini_read_string("LootLockerPlayerRank","rank"," ");
global.LootLockerPlayerScore = ini_read_string("LootLockerPlayerScore","score"," ");
global.LootLockerPlayerMetadata = ini_read_string("LootLockerPlayerMetadata","metadata"," ");
playerNameMapID = ini_read_string("playerNameMapID","id","0");
submitScoreMapID = ini_read_string("submitScoreMapID","id","0");
ini_close();

// 0 == sucess, < 0 == fail, 1 == downloading data
asyncStatus = ds_map_find_value(async_load, "status");

if(asyncStatus == 0)
{
    asyncID = ds_map_find_value(async_load, "id");

    // Result
    var text = ds_map_find_value(async_load, "result");
    var data = json_parse(text);

    if(global.LLdevelopmentMode == true)
    {
        show_debug_message(string(data));
    }

    // Login Session
    if(asyncID == loginMapID)
    {
        global.LootLockerInitialized = true;

        // Store data
		ini_open("LootLockerConfiguration.ini");

		if (variable_struct_exists(data, "player_identifier")) {
			playerIdentifier = data.player_identifier;
		} else if (variable_struct_exists(data, "id")) { 
			playerIdentifier = data.id;
		} else {
			playerIdentifier = "unknown_player";
		}
        if (variable_struct_exists(data, "session_token")) {
			session_token = data.session_token;
		} else if (variable_struct_exists(data, "token")) {
			session_token = data.token;
		} else {
			session_token = "no_token";
		}
		ini_write_string("playerIdentifier","id", playerIdentifier);
        ini_write_string("sessionToken","token", session_token);
        if (variable_struct_exists(data, "player_id")) {
			global.LootLockerPlayerID = data.player_id;
		} else if (variable_struct_exists(data, "id")) {
			global.LootLockerPlayerID = data.id;
		} else if (variable_struct_exists(data, "player_identifier")) {
			global.LootLockerPlayerID = data.player_identifier;
		} else {
			global.LootLockerPlayerID = "0";
		}
        ini_write_string("playerID","id", global.LootLockerPlayerID);
		ini_close();

        if(autoRefreshLeaderboards == "true" && leaderboardID != " ")
        {
            LootLockerGetHighscoresTop(string(leaderboardID), string(autoRefreshLeaderboardsAmount));
            LootLockerGetHighscoresCentered(string(leaderboardID), string(autoRefreshLeaderboardsAmount));
        }
    }
    else if(global.LootLockerInitialized == true)
    {
		if(asyncID == getHighscoresTopMapID)
		{
			global.LootLockerHighscoresTopRankList = array_create(100, " ");
			global.LootLockerHighscoresTopNamesList = array_create(100, " ");
			global.LootLockerHighscoresTopMetadataList = array_create(100, " ");
			global.LootLockerHighscoresTopScoreList = array_create(100, " ");
			global.LootLockerHighscoresTopIDList = array_create(100, " ");

			global.LootLockerHighscoresTopFormatted = "";
			if (variable_struct_exists(data, "items") && is_array(data.items)) 
			{
				for(var i = 0; i < array_length(data.items); i++)
				{
					// Garante que o item atual existe e tem os dados necessários
					var _item = data.items[i];
					if (!is_struct(_item)) continue;
					
					// Armazena os dados básicos tratando valores nulos/vazios
					var _rank     = variable_struct_exists(_item, "rank") ? string(_item.rank) : string(i + 1);
					var _score    = variable_struct_exists(_item, "score") ? string(_item.score) : "0";
					var _metadata = variable_struct_exists(_item, "metadata") ? string(_item.metadata) : "";
					
					// Trata os dados do jogador (player) de forma segura
					var _p_name = "Anonimo";
					var _p_id   = "0";
					if (variable_struct_exists(_item, "player") && is_struct(_item.player)) {
						if (variable_struct_exists(_item.player, "name") && string(_item.player.name) != "") _p_name = string(_item.player.name);
						if (variable_struct_exists(_item.player, "id")) _p_id = string(_item.player.id);
					}
					
					// Salva nas variáveis globais da extensão
					global.LootLockerHighscoresTopRankList[i]     = _rank;
					global.LootLockerHighscoresTopNamesList[i]    = _p_name;
					global.LootLockerHighscoresTopMetadataList[i] = _metadata;
					global.LootLockerHighscoresTopScoreList[i]    = _score;
					global.LootLockerHighscoresTopIDList[i]       = _p_id;

					// Monta a string formatada visual (Código original adaptado com as variáveis seguras)
					var fullyFormatted = _rank + ". ";
					if (_p_name == "Anonimo") {
						fullyFormatted += _p_id;
					} else {
						fullyFormatted += _p_name;
					}
					
					// Corta a string se for maior que 16 caracteres
					while(string_length(fullyFormatted) > 16) {
						fullyFormatted = string_delete(fullyFormatted, string_length(fullyFormatted), 1);
					}
					// Preenche com espaços até 22 caracteres
					while(string_length(fullyFormatted) < 22) {
						fullyFormatted += " ";
					}
					
					// Insere o score no final da linha
					var scoreLength = string_length(_score);
					var pos = string_length(fullyFormatted) - scoreLength;
					var fullyFormattedWithScore = string_insert(_score, fullyFormatted, pos);
					
					while(string_length(fullyFormattedWithScore) > 22) {
						fullyFormattedWithScore = string_delete(fullyFormattedWithScore, string_length(fullyFormattedWithScore), 1);
					}
					
					global.LootLockerHighscoresTopFormatted += fullyFormattedWithScore + "\n";
				}
			}
			else 
			{
				// Se o servidor não mandou a lista 'items', pode ser que a tabela esteja vazia!
				global.LootLockerHighscoresTopFormatted = "Nenhum recorde encontrado.\nSeja o primeiro!";
				show_debug_message("LootLocker: Propriedade 'items' nao encontrada ou tabela vazia.");
			}
			ini_open("LootLockerConfiguration.ini");
			ini_write_string("getHighscoresTopMapID","id","0");
			ini_close();
		}
		else if(asyncID == playerNameMapID)
		{
			global.LootLockerPlayerName = variable_struct_exists(data, "name") ? data.name : "Anonimo";
			ini_open("LootLockerConfiguration.ini");
			ini_write_string("playerName","name", global.LootLockerPlayerName);
			ini_close();
			if(global.LLdevelopmentMode == true)
			{
				show_debug_message("LootLocker changed players name to "+string(global.LootLockerPlayerName));
			}
			if(autoRefreshLeaderboards == "true" && leaderboardID != "")
			{
				LootLockerGetHighscoresTop(string(leaderboardID), string(autoRefreshLeaderboardsAmount));
				LootLockerGetHighscoresCentered(string(leaderboardID), string(autoRefreshLeaderboardsAmount));
			}
		}
		else if(asyncID == submitScoreMapID)
		{
			var _id_retornado = "";
			if (variable_struct_exists(data, "member_id")) {
				_id_retornado = string(data.member_id);
			} else if (variable_struct_exists(data, "player_id")) {
				_id_retornado = string(data.player_id);
			} else if (variable_struct_exists(data, "player") && is_struct(data.player) && variable_struct_exists(data.player, "id")) {
				_id_retornado = string(data.player.id);
			}

			if (_id_retornado == "") {
				show_debug_message("LootLocker: Score submitted successfully (Anonymous/No ID)");
			} else {
				show_debug_message("LootLocker: Score submitted successfully for member " + _id_retornado);
			}

			if (variable_struct_exists(data, "rank")) {
				global.LootLockerPlayerRank = string(data.rank);
			} else {
				global.LootLockerPlayerRank = "-";
			}

			if (variable_struct_exists(data, "score")) {
				global.LootLockerPlayerScore = string(data.score);
			} else {
				global.LootLockerPlayerScore = variable_instance_exists(id, "hiscore") ? string(global.hiscore) : "0";
			}

			if (variable_struct_exists(data, "player") && is_struct(data.player) && variable_struct_exists(data.player, "name")) {
				global.LootLockerPlayerName = string(data.player.name);
			} else if (variable_struct_exists(data, "name")) {
				global.LootLockerPlayerName = string(data.name);
			} else if (variable_instance_exists(id, "nome_digitado")) {
				global.LootLockerPlayerName = nome_digitado;
			}

			global.LootLockerPlayerMetadata = variable_struct_exists(data, "metadata") ? string(data.metadata) : "";
			
			ini_open("LootLockerConfiguration.ini");
			ini_write_string("submitScoreMapID","id","0");
			ini_write_string("LootLockerPlayerRank","rank", global.LootLockerPlayerRank);
			ini_write_string("LootLockerPlayerScore","score", global.LootLockerPlayerScore);
			ini_write_string("LootLockerPlayerMetadata","metadata", global.LootLockerPlayerMetadata);
			ini_close();

			if(global.LLdevelopmentMode == true)
			{
				show_debug_message("LootLocker submitted score to leaderboard");
			}
			if(autoRefreshLeaderboards == "true" && leaderboardID != "")
			{
				LootLockerGetHighscoresTop(string(leaderboardID), "10");
				LootLockerGetHighscoresCentered(string(leaderboardID), "10");
			}
		}
		else if(asyncID == getHighscoresCenteredMapID1)
		{
			var _id_retornado = "";
			if (variable_struct_exists(data, "member_id")) {
				_id_retornado = string(data.member_id);
			} else if (variable_struct_exists(data, "player_id")) {
				_id_retornado = string(data.player_id);
			} else if (variable_struct_exists(data, "player") && is_struct(data.player) && variable_struct_exists(data.player, "id")) {
				_id_retornado = string(data.player.id);
			}

			if (_id_retornado == "") {
				show_debug_message("LootLocker: Score submitted successfully (Anonymous/No ID)");
			} else {
				show_debug_message("LootLocker: Score submitted successfully for member " + _id_retornado);
			}
			
			if (variable_struct_exists(data, "rank")) {
				global.LootLockerPlayerRank = string(data.rank);
			} else {
				global.LootLockerPlayerRank = "-";
			}

			if (variable_struct_exists(data, "score")) {
				global.LootLockerPlayerScore = string(data.score);
			} else {
				global.LootLockerPlayerScore = variable_instance_exists(id, "hiscore") ? string(global.hiscore) : "0";
			}
			
			if (variable_struct_exists(data, "player") && is_struct(data.player) && variable_struct_exists(data.player, "name")) {
				global.LootLockerPlayerName = string(data.player.name);
			} else if (variable_struct_exists(data, "name")) {
				global.LootLockerPlayerName = string(data.name);
			} else if (variable_instance_exists(id, "nome_digitado")) {
				global.LootLockerPlayerName = nome_digitado;
			}
			
			global.LootLockerPlayerMetadata = variable_struct_exists(data, "metadata") ? string(data.metadata) : "";
			
			if (variable_struct_exists(data, "player") && is_struct(data.player) && variable_struct_exists(data.player, "id")) {
				global.LootLockerPlayerID = string(data.player.id);
			} else if (_id_retornado != "") {
				global.LootLockerPlayerID = _id_retornado;
			} else {
				global.LootLockerPlayerID = "0";
			}
			
			ini_open("LootLockerConfiguration.ini");
			ini_write_string("getHighscoresCenteredMapID1","id","-1");
			sessionToken = ini_read_string("sessionToken","token","");
			count = ini_read_string("getHighscoresCenteredCount","count",string(autoRefreshLeaderboardsAmount));
			
			ini_write_string("playerID","id",string(global.LootLockerPlayerID));
			ini_write_string("playerName","name",string(global.LootLockerPlayerName));
			ini_write_string("LootLockerPlayerRank","id",string(global.LootLockerPlayerRank));
			ini_write_string("LootLockerPlayerScore","id",string(global.LootLockerPlayerScore));
			ini_write_string("LootLockerPlayerMetadata","id",string(global.LootLockerPlayerMetadata));
			ini_close();

			rank = (global.LootLockerPlayerRank != "-") ? real(global.LootLockerPlayerRank) : 1;
			
			if(rank < real(count/2)+1)
			{
				after = 0;
			}
			else
			{
				after = rank-real(count/2);
				after = ceil(after);
			}
			if(global.LLdevelopmentMode == true)
			{
				show_debug_message("After:"+string(after));
			}

			var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboardID+"/list?count="+string(count)+"&after="+string(after);
			var map = ds_map_create();
			ds_map_add(map, "Content-Type","application/json");
			ds_map_add(map,"x-session-token", session_token);
			if(global.LLdevelopmentMode == true)
			{
				show_debug_message("LootLocker getting highscores for leaderboard:"+string(leaderboardID));
			}
			getHighscoresCenteredMapID2 = http_request(url, "GET", map, "");

			ini_open("LootLockerConfiguration.ini");
			ini_write_string("getHighscoresCenteredMapID1","id","-1");
			ini_write_string("getHighscoresCenteredMapID2","id", string(getHighscoresCenteredMapID2));
			ini_close();

			if(global.LLdevelopmentMode == true)
			{
				show_debug_message("LootLocker auto refreshing latest leaderboard");
			}
		}
		else if(asyncID == getHighscoresCenteredMapID2)
		{
			global.LootLockerHighscoresCenteredRankList = array_create(100, " ");
			global.LootLockerHighscoresCenteredNamesList = array_create(100, " ");
			global.LootLockerHighscoresCenteredMetadataList = array_create(100, " ");
			global.LootLockerHighscoresCenteredScoreList = array_create(100, " ");
			global.LootLockerHighscoresCenteredIDList = array_create(100, " ");

			global.LootLockerHighscoresCenteredFormatted = "";

			if (variable_struct_exists(data, "items") && is_array(data.items))
			{
				for(var i = 0; i < array_length(data.items); i++)
				{
					var _item = data.items[i];
					if (!is_struct(_item)) continue;

					var _rank     = variable_struct_exists(_item, "rank") ? string(_item.rank) : string(i + 1);
					var _score    = variable_struct_exists(_item, "score") ? string(_item.score) : "0";
					var _metadata = variable_struct_exists(_item, "metadata") ? string(_item.metadata) : "";

					var _p_name = "Anonimo";
					var _p_id   = "0";
					if (variable_struct_exists(_item, "player") && is_struct(_item.player)) {
						if (variable_struct_exists(_item.player, "name") && string(_item.player.name) != "") _p_name = string(_item.player.name);
						if (variable_struct_exists(_item.player, "id")) _p_id = string(_item.player.id);
					}

					global.LootLockerHighscoresCenteredRankList[i] = _rank;
					global.LootLockerHighscoresCenteredNamesList[i] = _p_name;
					global.LootLockerHighscoresCenteredMetadataList[i] = _metadata;
					global.LootLockerHighscoresCenteredScoreList[i] = _score;
					global.LootLockerHighscoresCenteredIDList[i] = _p_id;

					fullyFormatted = _rank + ". ";
					if(_p_name == "Anonimo")
					{
						fullyFormatted += _p_id;
					}
					else
					{
						fullyFormatted += _p_name;
					}
					
					while(string_length(fullyFormatted) > 16)
					{
						fullyFormatted = string_delete(fullyFormatted, string_length(fullyFormatted), 1);
					}
					
					while(string_length(fullyFormatted) < 22)
					{
						fullyFormatted += " ";
					}
					
					scoreLength = string_length(_score);
					pos = string_length(fullyFormatted)-scoreLength;
					
					fullyFormattedWithScore = string_insert(_score, fullyFormatted, pos);
					
					while(string_length(fullyFormattedWithScore) > 22)
					{
						fullyFormattedWithScore = string_delete(fullyFormattedWithScore, string_length(fullyFormattedWithScore), 1);
					}
					global.LootLockerHighscoresCenteredFormatted += fullyFormattedWithScore+"\n";
				}
			}
			else
			{
				global.LootLockerHighscoresCenteredFormatted = "Nenhum recorde encontrado.";
			}
			ini_open("LootLockerConfiguration.ini");
			ini_write_string("getHighscoresCenteredMapID2","id","-1");
			ini_close();
		}
		else if(asyncID == resetMapID)
		{
			LootLockerInitialize(string(global.gameAPIkey), string(global.gameVersion), string(global.LLdevelopmentMode), string(leaderboardID));
			ini_open("LootLockerConfiguration.ini");
			ini_write_string("resetMapID","id","-1");
			ini_close();
		}
    }
	else
	{
		show_debug_message("LootLocker has not been initialized, check if global.LootLockerInitialized is true before calling other functions")
	}
}
else if(asyncStatus < 0)
{
    if(global.LLdevelopmentMode == true)
    {
        show_debug_message("LootLocker failed async, error: "+string(asyncStatus));
    }
}
