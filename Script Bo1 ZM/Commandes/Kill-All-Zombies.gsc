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

function kill_all_zombies()
{
    player = getPlayer();
    if ( !is_admin(player) )
    {
        player iprintln("Vous n'avez pas la permission d'utiliser cette commande.");
        return;
    }

    zombies = GetEntArray("zombie");

    for (i = 0; i < zombies.size; i++)
    {
        zombie = zombies[i];
        zombie TakeDamage(1000000, player);
    }

    player iprintln("Tous les zombies ont été tués");
}

level thread kill_all_zombies();