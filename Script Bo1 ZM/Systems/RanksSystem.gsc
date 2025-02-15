rank_system = [];
rank_file = "maps/mp/gametypes/ranks.txt";

init()
{
    loadRanksFromFile();
    
    level.onPlayerConnect = ::onPlayerConnect;
    level.onChat = ::onPlayerChat;
}

loadRanksFromFile()
{
    if(fileExists(rank_file))
    {
        file = openFile(rank_file, "r");
        while(file.eof() == false)
        {
            line = file.readLine();
            parts = split(line, ":");
            if(size(parts) == 2)
            {
                guid = parts[0];
                rank = parts[1];
                rank_system[guid] = rank;
            }
        }
        file.close();
    }
}

saveRanksToFile()
{
    file = openFile(rank_file, "w");
    foreach(guid, rank in rank_system)
    {
        file.writeLine(guid + ":" + rank);
    }
    file.close();
}

onPlayerConnect(player)
{
    player endon("disconnect");
    
    if(!isDefined(rank_system[player getGuid()]))
    {
        rank_system[player getGuid()] = "Joueur";
    }
    
    player thread updateRankDisplay();

    player setClientCommand("!setrank", ::setRank);
    player setClientCommand("!derank", ::derank);
}

updateRankDisplay()
{
    self endon("disconnect");

    for(;;)
    {
        wait 1;
        self setRankText();
    }
}

setRankText()
{
    rank = rank_system[self getGuid()];

    if(rank == "Admin")
        self setClientName("^1[Admin] ^7" + self.name);
    else if(rank == "VIP")
        self setClientName("^3[VIP] ^7" + self.name);
    else
        self setClientName(self.name);
}

setRank(admin, args)
{
    if(!(admin getRank() == "Admin"))
    {
        admin iPrintln("Vous n'avez pas les permissions pour exécuter cette commande !");
        return;
    }

    if(size(args) < 2)
    {
        admin iPrintln("Utilisation: !setrank <joueur> <rank>");
        return;
    }

    player = getPlayerByName(args[0]);
    rank = args[1];

    if(!isDefined(player))
    {
        admin iPrintln("Joueur non trouvé !");
        return;
    }

    if(rank != "Admin" && rank != "VIP" && rank != "Joueur")
    {
        admin iPrintln("Rang invalide ! Utilisez: Admin, VIP ou Joueur.");
        return;
    }

    if(player == admin && rank == "Joueur")
    {
        admin iPrintln("Vous ne pouvez pas vous retirer votre rang d'admin !");
        return;
    }

    rank_system[player getGuid()] = rank;
    player setRankText();

    admin iPrintln("^2Rang mis à jour: " + player.name + " est maintenant " + rank + " !");
    player iPrintln("^2Votre nouveau rang est : " + rank + " !");
    
    saveRanksToFile();
}

derank(admin, args)
{
    if(!(admin getRank() == "Admin"))
    {
        admin iPrintln("Vous n'avez pas les permissions pour exécuter cette commande !");
        return;
    }

    if(size(args) < 1)
    {
        admin iPrintln("Utilisation: !derank <joueur>");
        return;
    }

    player = getPlayerByName(args[0]);

    if(!isDefined(player))
    {
        admin iPrintln("Joueur non trouvé !");
        return;
    }

    if(player == admin)
    {
        admin iPrintln("Vous ne pouvez pas vous retirer votre rang d'admin !");
        return;
    }

    rank_system[player getGuid()] = "Joueur";
    player setRankText();

    admin iPrintln("^2Le rang de " + player.name + " a été réinitialisé à Joueur.");
    player iPrintln("^1Votre rang a été réinitialisé à Joueur.");
    
    saveRanksToFile();
}

onPlayerChat(player, message)
{
    rank = rank_system[player getGuid()];

    if(rank == "Admin")
        message = "^1[Admin] ^7" + player.name + ": " + message;
    else if(rank == "VIP")
        message = "^3[VIP] ^7" + player.name + ": " + message;
    else
        message = player.name + ": " + message;

    level notify("chat", message);
}

getPlayerByName(name)
{
    foreach(player in get_players())
    {
        if(player.name == name)
            return player;
    }
    return undefined;
}

getRank()
{
    return rank_system[self getGuid()];
}