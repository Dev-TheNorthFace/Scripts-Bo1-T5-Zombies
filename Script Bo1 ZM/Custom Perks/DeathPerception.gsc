main()
{
    level.death_perception_cost = 5000;
    level.death_perception_perk = "death_perception";
    
    wait 1;
    thread setup_perk_machine();
}

setup_perk_machine()
{
    death_perception_machine = Spawn("script_model", (100, 200, 50));
    death_perception_machine SetModel("p6_zm_perk");
    death_perception_machine.angles = (0, 90, 0);
    trigger = Spawn("trigger_use", death_perception_machine.origin);
    trigger SetBounds((-32, -32, 0), (32, 32, 80));
    trigger SetHintString("Appuyez sur ^3[F]^7 pour acheter Death Perception [^2$5000^7]");
    trigger SetCursorHint("HINT_NOICON");
    trigger.targetname = "death_perception_trigger";
    
    trigger waittill("trigger", player);
    
    if(player GetPoints() >= level.death_perception_cost)
    {
        player SetPoints(player GetPoints() - level.death_perception_cost);
        player notify("purchased_death_perception");
    }
    else
    {
        player iPrintLnBold("Pas assez de points");
    }
    
    wait 0.1;
    thread setup_perk_machine();
}

player_death_perception()
{
    self endon("disconnect");
    
    self waittill("purchased_death_perception");

    for(;;)
    {
        zombies = GetEntArray("actor_zombie", "classname");
        
        foreach(zombie in zombies)
        {
            if(IsValid(zombie))
            {
                zombie SetGlow("red", 1);
            }
        }
        
        wait 0.1;
    }
}