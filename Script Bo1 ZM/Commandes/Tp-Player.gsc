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

function tp_player_to_admin(admin, target)
{
    if ( !is_admin(admin) )
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (!isDefined(target))
    {
        admin iprintln("^1[Erreur] ^7Joueur introuvable");
        return;
    }

    admin_position = admin getOrigin();

    target setOrigin(admin_position);

    admin iprintln("^2[Admin] ^7Vous avez téléporté ^1" + target.name + " ^7vers vous");
    target iprintln("^2[Admin] ^7Un administrateur vous a téléporté à sa position");
}

level thread tp_player_to_admin(getPlayer(), getTargetPlayer());