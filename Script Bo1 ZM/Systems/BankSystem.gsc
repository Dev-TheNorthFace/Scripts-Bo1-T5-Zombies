initBankSystem()
{
    if (!isDefined(level.bank))
    {
        level.bank = {};
    }
    level thread monitorBankCommands();
}

monitorBankCommands()
{
    for(;;)
    {
        self waittill("say", message);
        
        if(message.startswith("!depot "))
        {
            amount = int(message.substring(7));
            depositMoney(self, amount);
        }
        else if(message.startswith("!retrait "))
        {
            amount = int(message.substring(9));
            withdrawMoney(self, amount);
        }
        else if(message == "!solde")
        {
            checkBalance(self);
        }
    }
}

depositMoney(player, amount)
{
    if (player.score >= amount && amount > 0)
    {
        player.score -= amount;
        level.bank[player getGUID()] += amount;
        player iPrintLnBold("^2Déposé : " + amount + " points");
    }
    else
    {
        player iPrintLnBold("^1Fonds insuffisants !");
    }
}

withdrawMoney(player, amount)
{
    if (level.bank[player getGUID()] >= amount && amount > 0)
    {
        level.bank[player getGUID()] -= amount;
        player.score += amount;
        player iPrintLnBold("^2Retiré : " + amount + " points");
    }
    else
    {
        player iPrintLnBold("^1Fonds insuffisants en banque !");
    }
}

checkBalance(player)
{
    balance = level.bank[player getGUID()];
    player iPrintLnBold("^3Solde en banque : " + balance + " points");
}