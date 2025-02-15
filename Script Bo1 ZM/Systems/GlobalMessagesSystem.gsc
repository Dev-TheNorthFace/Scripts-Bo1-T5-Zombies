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

function get_player_level(player)
{
    return player getPlayerData("level");
}

function get_player_rank(player)
{
    return player getTeam();
}

function show_global_message(player, message)
{
    server_name = "NomDuServeur";
    current_map = getCurrentMap();
    player_level = get_player_level(player);
    player_rank = get_player_rank(player);
    player_name = player.name;

    global_message = "^1[GlobalMessage] ^7" + server_name + " ^7(" + current_map + ") - " + player_name + " ^7[Level: " + player_level + " | Rank: " + player_rank + "] : ^3" + message;
    
    for (i = 0; i < getPlayerCount(); i++)
    {
        current_player = getPlayerByIndex(i);
        if (isDefined(current_player))
        {
            current_player iprintln(global_message);
        }
    }
}

function player_command(player, cmd, args)
{
    if (cmd == "!globalmessage")
    {
        if (is_admin(player))
        {
            if (sizeof(args) > 0)
            {
                message = joinargs(args);
                
                show_global_message(player, message);
            }
            else
            {
                player iprintln("^1[Erreur] ^7Vous devez entrer un message.");
            }
        }
        else
        {
            player iprintln("^1[Erreur] ^7Vous devez être un administrateur pour utiliser cette commande.");
        }
    }
}

level.onPlayerCommand = player_command;