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

function give_max_ammo(player)
{
    if ( !is_admin(player) )
    {
        player iprintln("Vous n'avez pas la permission d'utiliser cette commande.");
        return;
    }

    weapons = player getWeapons();

    for (i = 0; i < weapons.size; i++)
    {
        weapon = weapons[i];
        player giveAmmo(weapon, player getMaxAmmoForWeapon(weapon));
    }

    player iprintln("Vous avez reçu des munitions maximales.");
}

level thread give_max_ammo(getPlayer());