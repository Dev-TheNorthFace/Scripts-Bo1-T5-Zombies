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

function force_round_change(admin, new_round)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (!isDefined(new_round) || new_round < 1)
    {
        admin iprintln("^1[Erreur] ^7Veuillez spécifier un numéro de manche valide");
        return;
    }

    level setCurrentRound(new_round);
    level notifyAll("^1[Admin] ^7" + admin.name + " a forcé le changement de manche au round ^3" + new_round + "^7.");

    thread maps\_zombie_mode::start_new_round(new_round);
}

function player_command(player, cmd, args)
{
    if (cmd == "!force-round-change")
    {
        new_round = atoi(args[0]);
        force_round_change(player, new_round);
    }
}

level.onPlayerCommand = player_command;