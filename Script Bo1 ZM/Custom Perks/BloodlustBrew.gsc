init()
{
    level.berserker_brew_cost = 5000;
    level.berserker_brew_boost = 1.5;
    level.berserker_speed_boost = 1.3;
    level.berserker_health_threshold = 0.5;
    level.berserker_glow_duration = 3;

    level thread monitor_players();
}

monitor_players()
{
    for(;;)
    {
        foreach(player in level.players)
        {
            if(!isDefined(player.has_berserker))
            {
                player.has_berserker = false;
            }
            if(player.has_berserker)
            {
                player thread berserker_effects();
            }
        }
        wait(1);
    }
}

berserker_effects()
{
    self endon("disconnect");

    while(self.has_berserker)
    {
        if(self.health / self.maxhealth <= level.berserker_health_threshold)
        {
            self.damage_multiplier = level.berserker_brew_boost;
            self.speed_multiplier = level.berserker_speed_boost;
            self SetVisionSetNaked("zombie_berseker_vision", 0);

        }
        else
        {
            self.damage_multiplier = 1;
            self.speed_multiplier = 1;
            self ClearVisionSet();
        }

        wait(0.1);
    }
}

add_berserker_brew(player)
{
    if(!isDefined(player.has_berserker) || !player.has_berserker)
    {
        player.has_berserker = true;
        player iprintlnbold("Vous avez acheté Berserker Brew");
    }
    else
    {
        player iprintlnbold("Vous avez déjà cet atout");
    }
}

on_kill()
{
    self endon("disconnect");

    for(;;)
    {
        self waittill("killed_enemy");
        self GiveWeaponGlow("red");
        wait(level.berserker_glow_duration);
        self RemoveWeaponGlow();
    }
}