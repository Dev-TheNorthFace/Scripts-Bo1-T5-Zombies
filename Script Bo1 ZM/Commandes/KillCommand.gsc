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

function kill_player(admin, target_player)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (!isDefined(target_player))
    {
        admin iprintln("^1[Erreur] ^7Veuillez spécifier un joueur valide.");
        return;
    }

    target_player takeDamage(target_player.health, target_player);

    admin iprintln("^7Le joueur ^3" + target_player.name + "^7 a été tué.");
}

function player_command(player, cmd, args)
{
    if (cmd == "!kill")
    {
        if (sizeof(args) < 1)
        {
            player iprintln("^1[Erreur] ^7Veuillez spécifier un joueur.");
            return;
        }

        target_player_name = args[0];

        target_player = getPlayerByName(target_player_name);

        if (!isDefined(target_player))
        {
            player iprintln("^1[Erreur] ^7Le joueur spécifié n'a pas été trouvé.");
            return;
        }

        kill_player(player, target_player);
    }
}

level.onPlayerCommand = player_command;