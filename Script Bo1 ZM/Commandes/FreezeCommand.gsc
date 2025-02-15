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

function freeze_player(admin, target)
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

    target freezeControls(true);

    admin iprintln("^2[Admin] ^7Vous avez gelé ^1" + target.name + "^7");
    target iprintln("^1[Freeze] ^7Vous avez été gelé par un administrateur");
}

function unfreeze_player(admin, target)
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

    target freezeControls(false);

    admin iprintln("^2[Admin] ^7Vous avez dégelé ^1" + target.name + "^7");
    target iprintln("^2[Unfreeze] ^7Vous pouvez de nouveau bouger");
}

level thread freeze_player(getPlayer(), getTargetPlayer());
level thread unfreeze_player(getPlayer(), getTargetPlayer());