init()
{
    level thread onPlayerConnected();
}

onPlayerConnected()
{
    for(;;)
    {
        level waittill("connecting", player);
        player thread monitorChat();
    }
}

monitorChat()
{
    self endon("disconnect");
    
    for(;;)
    {
        self waittill("say", message);
        
        if(message.startswith("!annonce "))
        {
            if(isAdmin(self.name))
            {
                annonce = message.substring(9);
                announceMessage(self, annonce);
            }
            else
            {
                self iPrintLnBold("Vous n'avez pas la permission d'utiliser cette commande");
            }
        }
    }
}

isAdmin(name)
{
    return name.startswith("[Admin] ");
}

announceMessage(player, message)
{
    level notify("chat", "^1[Annonce] " + message);
}