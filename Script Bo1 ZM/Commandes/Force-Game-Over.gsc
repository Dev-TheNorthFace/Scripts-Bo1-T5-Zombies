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

function force_game_over(admin)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    level notifyAll("^1[Admin] ^7" + admin.name + " a forcé la fin de la partie");
    
    wait 2;

    thread maps\_zombie_mode::game_over();
}

function player_command(player, cmd, args)
{
    if (cmd == "!force-game-over")
    {
        force_game_over(player);
    }
}

level.onPlayerCommand = player_command;

    }
}

function force_game_over(admin)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    level notifyAll("^1[Admin] ^7" + admin.name + " a forcé la fin de la partie");
    
    wait 2;

    thread maps\_zombie_mode::game_over();
}

level thread force_game_over(getPlayer());