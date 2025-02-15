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

function god_mode(admin, status)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (status == "on")
    {
        admin iprintln("^2[Admin] ^7Vous êtes maintenant en God Mode");
        admin setclientdvar("god", 1);
    }
    else if (status == "off")
    {
        admin iprintln("^2[Admin] ^7Le God Mode a été désactivé.");
        admin setclientdvar("god", 0);
    }
    else
    {
        admin iprintln("^1[Erreur] ^7Veuillez spécifier 'on' ou 'off' pour activer/désactiver le God Mode.");
    }
}

function player_command(player, cmd, args)
{
    if (cmd == "!god")
    {
        if (sizeof(args) < 1)
        {
            player iprintln("^1[Erreur] ^7Veuillez spécifier 'on' ou 'off'.");
            return;
        }

        status = args[0];
        god_mode(player, status);
    }
}

level.onPlayerCommand = player_command;