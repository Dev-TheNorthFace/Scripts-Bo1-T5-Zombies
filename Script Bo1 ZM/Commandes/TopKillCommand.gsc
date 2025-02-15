player_kills = map();

function initialize_player_kills(player)
{
    if (!isDefined(player_kills[player])) {
        player_kills[player] = 0;
    }
}

function get_player_kills(player)
{
    if (isDefined(player_kills[player])) {
        return player_kills[player];
    } else {
        return 0;
    }
}

function sort_players_by_kills()
{
    players = getPlayers();
    player_list = array();

    for (i = 0; i < sizeof(players); i++) {
        player = players[i];
        player_list[i] = (player, get_player_kills(player));
    }

    sorted_player_list = sortArray(player_list, 1);

    return sorted_player_list;
}

function display_topkill()
{
    sorted_list = sort_players_by_kills();
    top10 = "";

    for (i = 0; i < 10; i++) {
        if (i >= sizeof(sorted_list)) {
            break;
        }
        
        player = sorted_list[i][0];
        kills = sorted_list[i][1];

        top10 += "^3" + (i + 1) + ". " + player.name + " - " + kills + " kills\n";
    }

    iprintln("^7Top 10 des joueurs avec le plus de kills :\n" + top10);
}

function on_zombie_killed(player)
{
    if (isDefined(player_kills[player])) {
        player_kills[player] += 1;
    }
}

function on_player_chat(player, message)
{
    if (stricmp(message, "!topkill") == 0)
    {
        display_topkill();
    }
}

level onPlayerChat = on_player_chat;
level onZombieKilled = on_zombie_killed;
level onPlayerConnect = initialize_player_kills;