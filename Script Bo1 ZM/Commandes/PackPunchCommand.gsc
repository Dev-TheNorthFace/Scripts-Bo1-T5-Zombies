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

function pack_a_punch(player)
{
    if ( !is_admin(player) )
    {
        player iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    weapon = player getCurrentWeapon();

    if (weapon == "")
    {
        player iprintln("^1[Erreur] ^7Vous ne tenez aucune arme");
        return;
    }

    upgraded_weapon = weapon + "_upgraded";

    if (!isDefined(upgraded_weapon))
    {
        player iprintln("^1[Erreur] ^7Cette arme ne peut pas être améliorée");
        return;
    }

    player takeWeapon(weapon);
    player giveWeapon(upgraded_weapon);
    player switchToWeapon(upgraded_weapon);
    player iprintln("^2[Admin] ^7Votre arme a été améliorée en version Pack-a-Punch");
}

level thread pack_a_punch(getPlayer());