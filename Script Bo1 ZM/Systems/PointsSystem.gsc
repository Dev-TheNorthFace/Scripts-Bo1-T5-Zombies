init()
{
    level.admins = [];
    level.adminRank = "admin";
    level.onPlayerConnect = ::onPlayerConnect;
}

onPlayerConnect()
{
    self waittill("spawned_player");
    self thread monitorChatCommands();
}

monitorChatCommands()
{
    while (1)
    {
        self waittill("say", player, message);
        if (isAdmin(self))
        {
            tokens = strTok(message, " ");
            if (tokens.size > 1)
            {
                if (tokens[0] == "!givepoints" && tokens.size == 3)
                    self thread modifyPlayerPoints(tokens[1], int(tokens[2]));
                else if (tokens[0] == "!delpoints" && tokens.size == 3)
                    self thread modifyPlayerPoints(tokens[1], -int(tokens[2]));
            }
        }
    }
}

modifyPlayerPoints(targetName, points)
{
    target = getPlayerByName(targetName);
    if (!isDefined(target))
    {
        self iPrintLn("Joueur non trouvé.");
        return;
    }
    target zm_score += points;
    target iPrintLn("Vous avez reçu " + points + " points");
    self iPrintLn("Vous avez modifié les points de " + targetName);
}

getPlayerByName(name)
{
    foreach (player in getEntArray("player", "classname"))
    {
        if (player.name == name)
            return player;
    }
    return undefined;
}

isAdmin(player)
{
    return (player getRank() == level.adminRank);
}