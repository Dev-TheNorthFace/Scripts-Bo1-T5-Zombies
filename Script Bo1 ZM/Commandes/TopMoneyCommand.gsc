player_money = map();

function initialize_player_money(player)
{
    if (!isDefined(player_money[player])) {
        player_money[player] = 1000;
    }
}

function get_player_money(player)
{
    if (isDefined(player_money[player])) {
        return player_money[player];
    } else {
        return 0;
    }
}

function sort_players_by_money()
{
    players = getPlayers();
    player_list = array();

    for (i = 0; i < sizeof(players); i++) {
        player = players[i];
        player_list[i] = (player, get_player_money(player));
    }

    sorted_player_list = sortArray(player_list, 1);

    return sorted_player_list;
}

function display_topmoney()
{
    sorted_list = sort_players_by_money();
    top10 = "";

    for (i = 0; i < 10; i++) {
        if (i >= sizeof(sorted_list)) {
            break;
        }
        
        player = sorted_list[i][0];
        money = sorted_list[i][1];

        top10 += "^3" + (i + 1) + ". " + player.name + " - $" + money + "\n";
    }

    iprintln("^7Top 10 des joueurs avec le plus d'argent dans leur banque :\n" + top10);
}

function on_player_chat(player, message)
{
    if (stricmp(message, "!topmoney") == 0)
    {
        display_topmoney();
    }
}

level onPlayerChat = on_player_chat;
level onPlayerConnect = initialize_player_money;