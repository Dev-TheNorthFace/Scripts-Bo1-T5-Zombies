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

function spawn_zombie(admin)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    position = admin getOrigin();  

    num_zombies = 5;  

    for (i = 0; i < num_zombies; i++)
    {
        zombie = spawn("zombie", position + (random() * 10, random() * 10, random() * 10));  
        zombie.target = admin;
    }

    admin iprintln("^2[Admin] ^7Des zombies ont été spawnés près de vous.");
}

function player_command(player, cmd, args)
{
    if (cmd == "!spawnzombie")
    {
        spawn_zombie(player);
    }
}

level.onPlayerCommand = player_command;