#define LootLockerGetHighscoresTop

// Converte os argumentos para string automaticamente para evitar erros de execução (DoAdd)
var _leaderboard_id = string(argument0);
var _count          = string(argument1);

// Get values
ini_open("LootLockerConfiguration.ini");
var _session_token = ini_read_string("sessionToken","token","");
ini_close();

var url = "https://api.lootlocker.io/game/leaderboards/" + _leaderboard_id + "/list?count=" + _count;
var map = ds_map_create();
ds_map_add(map, "Content-Type", "application/json");
ds_map_add(map, "x-session-token", _session_token);

show_debug_message("LootLocker getting highscores for leaderboard: " + _leaderboard_id);
getHighscoresTopMapID = http_request(url, "GET", map, "");

ini_open("LootLockerConfiguration.ini");
ini_write_string("getHighscoresTopMapID", "id", string(getHighscoresTopMapID));
ini_write_string("leaderboardID", "id", _leaderboard_id);
ini_close();
