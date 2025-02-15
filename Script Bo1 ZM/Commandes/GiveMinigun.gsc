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

function give_minigun(admin, target_player)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (!isDefined(target_player))
    {
        admin iprintln("^1[Erreur] ^7Le joueur spécifié n'est pas valide.");
        return;
    }

    target_player giveWeapon("weapon_death_machine");

    admin iprintln("^7Vous avez donné la Death Machine à " + target_player.name + "^7.");
    target_player iprintln("^2[Admin] ^7Vous avez reçu la Death Machine");
}

function player_command(player, cmd, args)
{
    if (cmd == "!give-minigun")
    {
        if (!is_admin(player))
        {
            player iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
            return;
        }

        if (sizeof(args) < 1)
        {
            player iprintln("^1[Erreur] ^7Veuillez spécifier le joueur à qui donner la Death Machine.");
            return;
        }

        target_player = getPlayerByName(args[0]);

        give_minigun(player, target_player);
    }
}

level.onPlayerCommand = player_command;