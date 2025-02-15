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

function give_raygun(player)
{
    if ( !is_admin(player) )
    {
        player iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    weapon = "ray_gun";  
    player takeAllWeapons();
    player giveWeapon(weapon);
    player switchToWeapon(weapon);
    player iprintln("^2[Admin] ^7Vous avez reçu un Ray Gun");
}

level thread give_raygun(getPlayer());