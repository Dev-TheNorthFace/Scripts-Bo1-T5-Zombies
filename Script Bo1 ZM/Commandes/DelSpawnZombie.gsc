spawned_zombies = [];

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

function del_spawned_zombies(admin)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (sizeof(spawned_zombies) == 0)
    {
        admin iprintln("^1[Erreur] ^7Aucun zombie à supprimer");
        return;
    }

    for (i = 0; i < sizeof(spawned_zombies); i++)
    {
        zombie = spawned_zombies[i];
        if (isDefined(zombie))
        {
            zombie delete();
        }
    }

    spawned_zombies = [];
    admin iprintln("^7Tous les zombies spawnés ont été supprimés.");
}

function player_command(player, cmd, args)
{
    else if (cmd == "!delspawnzombies")
    {
        del_spawned_zombies(player);
    }
}

level.onPlayerCommand = player_command;