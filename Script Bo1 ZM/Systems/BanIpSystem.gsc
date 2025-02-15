level.banned_ips = [];

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

function get_player_ip(player)
{
    if (!isDefined(player))
    {
        return "0.0.0.0";
    }
    return player getGuid();
}

function ban_ip(admin, target, reason, duration)
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

    ip = get_player_ip(target);

    level.banned_ips[ip] = getTime() + int(duration) * 60;

    target iprintln("^1[BAN-IP] ^7Vous avez été banni du serveur");
    target iprintln("^3Raison: ^7" + reason);
    target iprintln("^2Durée: ^7" + duration + " minutes");

    level notifyAll("^1[Admin] " + target.name + " a été banni par IP pour ^3" + duration + " minutes. ^7Raison: " + reason);

    wait 2;
    target kick(reason);
}

function unban_ip(admin, target_name)
{
    if (!is_admin(admin))
    {
        admin iprintln("^1[Erreur] ^7Vous n'avez pas la permission d'utiliser cette commande");
        return;
    }

    foreach (ip, ban_time in level.banned_ips)
    {
        if (level.banned_ips[ip] > getTime())
        {
            level.banned_ips[ip] = 0;
            admin iprintln("^2[Admin] ^7Le joueur avec l'IP ^1" + ip + " ^7a été débanni");
            level notifyAll("^2[Admin] ^1" + target_name + " ^7a été débanni par IP");
            return;
        }
    }

    admin iprintln("^1[Erreur] ^7Le joueur ^1" + target_name + " ^7n'est pas banni par IP");
}

level thread ban_ip(getPlayer(), getTargetPlayer(), getReason(), getDuration());
level thread unban_ip(getPlayer(), getTargetName());