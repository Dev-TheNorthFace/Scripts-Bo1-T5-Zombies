player_rounds = map();
player_time = map();

function initialize_player_data(player)
{
    if (!isDefined(player_rounds[player])) {
        player_rounds[player] = 0;
    }
    if (!isDefined(player_time[player])) {
        player_time[player] = 0;
    }
}

function get_player_rounds(player)
{
    if (isDefined(player_rounds[player])) {
        return player_rounds[player];
    } else {
        return 0;
    }
}

function get_player_time(player)
{
    if (isDefined(player_time[player])) {
        return player_time[player] / 60;
    } else {
        return 0;
    }
}

function on_round_end(player)
{
    if (isDefined(player_rounds[player])) {
        player_rounds[player] += 1;
    }
    
    player_time[player] += 60;
}

function display_toprounds()
{
    players = getPlayers();
    top_rounds = "";

    sorted_players = sort_players_by_rounds(players);

    for (i = 0; i < sizeof(sorted_players); i++) {
        player = sorted_players[i][0];
        rounds = sorted_players[i][1];
        time_in_minutes = get_player_time(player);

        top_rounds += "^3" + (i + 1) + ". " + player.name + " - " + rounds + " rounds - " + time_in_minutes + " min\n";
    }

    iprintln("^7Top des joueurs avec le plus de rounds et le temps passé :\n" + top_rounds);
}

function sort_players_by_rounds(players)
{
    player_list = array();

    for (i = 0; i < sizeof(players); i++) {
        player = players[i];
        player_list[i] = (player, get_player_rounds(player));
    }

    sorted_list = sortArray(player_list, 1);

    return sorted_list;
}

function on_player_chat(player, message)
{
    if (stricmp(message, "!toprounds") == 0) {
        display_toprounds();
    }
}

level onPlayerChat = on_player_chat;
level onRoundEnd = on_round_end;
level onPlayerConnect = initialize_player_data;