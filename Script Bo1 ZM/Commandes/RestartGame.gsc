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

function restart_game(admin)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    level notifyAll("^1[Admin] ^7" + admin.name + " a redémarré la partie");
    
    wait 2;

    level reset(); 
    level onRestart();
}

function player_command(player, cmd, args)
{
    if (cmd == "!restartgame")
    {
        restart_game(player);
    }
}

level.onPlayerCommand = player_command;