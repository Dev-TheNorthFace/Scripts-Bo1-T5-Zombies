initLevelSystem()
{
    if (!isDefined(level.playerLevels))
    {
        level.playerLevels = {};
    }
    level thread monitorLevelCommands();
}

monitorLevelCommands()
{
    for(;;)
    {
        self waittill("say", message);
        
        if(message == "!levels")
        {
            checkLevel(self);
        }
        else if(message.startswith("!nextlevels"))
        {
            buyLevel(self);
        }
    }
}

checkLevel(player)
{
    if (!isDefined(level.playerLevels[player getGUID()]))
    {
        level.playerLevels[player getGUID()] = 1;
    }
    player iPrintLnBold("^3Niveau actuel : " + level.playerLevels[player getGUID()]);
}

buyLevel(player)
{
    currentLevel = level.playerLevels[player getGUID()];
    cost = currentLevel * 10000;
    
    if (player.score >= cost && currentLevel < 100)
    {
        player.score -= cost;
        level.playerLevels[player getGUID()] += 1;
        player iPrintLnBold("^2Niveau augmenté ! Nouveau niveau : " + level.playerLevels[player getGUID()]);
    }
    else
    {
        player iPrintLnBold("^1Fonds insuffisants ou niveau max atteint !");
    }
}