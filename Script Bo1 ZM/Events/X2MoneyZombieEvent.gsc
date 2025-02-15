monitorZombieKills()
{
    self endon("disconnect");
    
    for(;;)
    {
        self waittill("zombie_killed", zombie, points);
        
        if(randomInt(10) == 0)
        {
            points *= 2;
            self iPrintLnBold("^2Bonus x2 Argent!");
        }
        
        self.score += points;
    }
}