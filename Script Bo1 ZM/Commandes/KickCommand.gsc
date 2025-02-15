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

function kick_player(admin, target, reason)
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

    if (!isDefined(reason) || reason == "")
    {
        reason = "Non spécifiée";
    }

    target iprintln("^1[KICK] ^7Vous avez été expulsé du serveur");
    target iprintln("^3Raison: ^7" + reason);
    level notifyAll("^1[Admin] " + target.name + " a été expulsé du serveur. Raison: " + reason);

    wait 2;
    target kick(reason);
}

level thread kick_player(getPlayer(), getTargetPlayer(), getReason());