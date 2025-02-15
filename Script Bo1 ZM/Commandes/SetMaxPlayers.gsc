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

function set_max_players(admin, new_max)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (new_max < 1 || new_max > 18)
    {
        admin iprintln("^1[Erreur] ^7Le nombre de joueurs doit être entre 1 et 18.");
        return;
    }

    level.maxplayers = new_max;
    
    admin iprintln("^2[Admin] ^7Le nombre maximal de joueurs a été changé à ^3" + new_max + "^7.");
}

function player_command(player, cmd, args)
{
    if (cmd == "!maxplayers")
    {
        if (sizeof(args) < 1)
        {
            player iprintln("^1[Erreur] ^7Veuillez spécifier un nombre.");
            return;
        }

        new_max_players = tonumber(args[0]);

        set_max_players(player, new_max_players);
    }
}

level.onPlayerCommand = player_command;