level.banned_players = [];

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

function ban_player(admin, target, reason, duration)
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

    if (!isDefined(reason) || reason == "")
    {
        reason = "Non spécifiée";
    }

    if (!isDefined(duration) || int(duration) <= 0)
    {
        duration = 60;
    }

    level.banned_players[target getGuid()] = getTime() + int(duration) * 60;

    target iprintln("^1[BAN] ^7Vous avez été banni du serveur");
    target iprintln("^3Raison: ^7" + reason);
    target iprintln("^2Durée: ^7" + duration + " minutes");
    
    level notifyAll("^1[Admin] " + target.name + " a été banni pour ^3" + duration + " minutes. ^7Raison: " + reason);

    wait 2;
    target kick(reason);
}

function unban_player(admin, target_name)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    foreach (guid, ban_time in level.banned_players)
    {
        if (level.banned_players[guid] > getTime())
        {
            level.banned_players[guid] = 0;
            admin iprintln("^2[Admin] ^7Le joueur ^1" + target_name + " ^7a été débanni");
            level notifyAll("^2[Admin] ^1" + target_name + " ^7a été débanni");
            return;
        }
    }

    admin iprintln("^1[Erreur] ^7Le joueur ^1" + target_name + " ^7n'est pas banni");
}

level thread ban_player(getPlayer(), getTargetPlayer(), getReason(), getDuration());
level thread unban_player(getPlayer(), getTargetName());