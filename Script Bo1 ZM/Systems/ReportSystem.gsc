function is_admin(player)
{
    player_grade = player getTeam();

    if (player_grade == "admin")  
    {
        return true;
    }
    else
    {
        return false;
    }
}

function show_connected_players(player)
{
    players_list = [];
    for (i = 0; i < getPlayerCount(); i++)
    {
        current_player = getPlayerByIndex(i);
        if (isDefined(current_player) && current_player != player)
        {
            players_list[i] = current_player;
            player iprintln("^7" + i + ". ^2" + current_player.name);
        }
    }
    return players_list;
}

function select_report_player(player)
{
    player iprintln("^7Tapez le numéro du joueur que vous souhaitez signaler :");
    
    player waitForCommand("report_player_number");
    
    report_player_index = player getLastCommand();
    players_list = show_connected_players(player);

    if (report_player_index < 0 || report_player_index >= sizeof(players_list))
    {
        player iprintln("^1[Erreur] ^7Numéro de joueur invalide.");
        return;
    }

    target_player = players_list[report_player_index];
    
    player iprintln("^7Entrez une raison pour le signalement :");
    player waitForCommand("report_reason");
    
    report_reason = player getLastCommand();
    
    send_report_to_admins(player, target_player, report_reason);
}

function send_report_to_admins(player, target_player, report_reason)
{
    report_message = "^1[Report] ^7Le joueur ^2" + player.name + "^7 a signalé le joueur ^2" + target_player.name + "^7 pour la raison : ^3" + report_reason;
    
    for (i = 0; i < getPlayerCount(); i++)
    {
        current_player = getPlayerByIndex(i);
        if (isDefined(current_player) && is_admin(current_player))
        {
            current_player iprintln(report_message);
        }
    }

    player iprintln("^7Votre report a été envoyé aux administrateurs.");
}

function player_command(player, cmd, args)
{
    if (cmd == "!report")
    {
        select_report_player(player);
    }
}

level.onPlayerCommand = player_command;