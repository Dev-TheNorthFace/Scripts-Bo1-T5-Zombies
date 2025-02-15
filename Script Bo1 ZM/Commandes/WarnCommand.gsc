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

function warn_player(admin, target, message)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    if (!isDefined(target))
    {
        admin iprintln("^1[Erreur] ^7Joueur introuvable");
        return;
    }

    if (!isDefined(message) || message == "")
    {
        message = "Attention";
    }

    target [[ "scr_outofbounds", 5, message ]];

    admin iprintln("^2[Admin] ^7Vous avez averti ^1" + target.name + "^7: " + message);
    
    foreach (player in getPlayers())
    {
        if (is_admin(player))
        {
            player iprintln("^3[Admin] ^7" + target.name + " a reçu un avertissement: ^1" + message);
        }
    }
}

level thread warn_player(getPlayer(), getTargetPlayer(), getWarnMessage());