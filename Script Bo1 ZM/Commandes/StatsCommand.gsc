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

function show_player_stats(admin, target_player)
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

    player_level = target_player getStat("level");
    player_rank = target_player getTeam();
    player_money = target_player getScore();
    player_id = target_player getPlayerID();
    admin iprintln("^2[Stats de " + target_player.name + "] :");
    admin iprintln("^7Niveau: ^3" + player_level);
    admin iprintln("^7Rank: ^3" + player_rank);
    admin iprintln("^7Argent dans la banque: ^3" + player_money);
    admin iprintln("^7ID du joueur: ^3" + player_id);
}

function player_command(player, cmd, args)
{
    if (cmd == "!stats")
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

        show_player_stats(player, target_player);
    }
}

level.onPlayerCommand = player_command;