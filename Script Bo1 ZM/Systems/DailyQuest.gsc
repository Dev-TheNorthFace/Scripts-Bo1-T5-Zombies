initDailyQuests()
{
    self endon("disconnect");
    assignDailyQuest();
}

assignDailyQuest()
{
    quests = [
        "Tuer 50 zombies",
        "Réanimer 3 coéquipiers",
        "Gagner 5000 points",
        "Survivre 10 manches sans tomber"
    ];
    
    self.dailyQuest = quests[randomInt(quests.size)];
    self iPrintLnBold("^2Quête du jour : " + self.dailyQuest);
}

completeQuest()
{
    self iPrintLnBold("^3Quête terminée, Récompense reçue.");
    giveReward();
}

giveReward()
{
    self.level += 1;
    self iPrintLnBold("^5+1 Niveau !");
}