init()
{
    level.tempus_cooldown = 300;
    level.tempus_duration = 8;
    level.tempus_slow_percent = 0.3;
    level.tempus_speed_boost = 1.25;
    level.tempus_radius = 12;
    level.tempus_fx = loadfx("fx/time_distortion");
    level.tempus_fx_trail = loadfx("fx/time_trail");
    level.tempus_fx_weapon = loadfx("fx/time_weapon_lightning");
    level.tempus_ambient_distort = "time_ambient_distort";
    level.tempus_blue_tint = "time_blue_tint";
    level.tempus_sound = "time_slowdown_sound";
    level.tempus_groan = "zombie_slow_groan";
    add_weapon_to_box();
}

add_weapon_to_box()
{
    level.weapons["tempus_manipulator"] = spawnTempusManipulator;
}

spawnTempusManipulator(player)
{
    player.has_tempus = true;
    player.giveWeapon("tempus_manipulator");
    player iprintlnbold("Vous avez obtenu le Tempus Manipulator");
    player thread tempus_logic();
}

tempus_logic()
{
    self endon("disconnect");
    self.tempus_ready = true;

    while(self.has_tempus)
    {
        if(self UseButtonPressed() && self.tempus_ready)
        {
            self.tempus_ready = false;
            self iprintlnbold("Tempus Manipulator activé");
            self thread tempus_effect();
            self VibrateWeapon(0.2, 0.2, 0.2, 0.5); 
            playfxattachtotag(level.tempus_fx_weapon, self, "j_gun");
            wait(level.tempus_cooldown);
            self.tempus_ready = true;
            self iprintlnbold("Tempus Manipulator rechargé");
        }
        wait(0.1);
    }
}

tempus_effect()
{
    origin = self getTagOrigin("j_head");
    effect_radius = level.tempus_radius;
    playfx(level.tempus_fx, origin);
    playsoundatposition(level.tempus_sound, origin);
    self VisionSetNaked(level.tempus_blue_tint, 0.2);
    self thread removeVisualEffects(level.tempus_duration);
    AmbientStopAll();
    self playsound(level.tempus_ambient_distort);
    zombies = getEntArray("zombie", "classname");
    affected_zombies = [];
    foreach(zombie in zombies)
    {
        distance = distance(zombie.origin, origin);
        if(distance <= effect_radius)
        {
            affected_zombies[zombie] = true;
            zombie.time_trail = spawn("script_model", zombie.origin);
            zombie.time_trail SetModel("tag_origin");
            playfxattachtotag(level.tempus_fx_trail, zombie, "j_spine4");
            zombie playsound(level.tempus_groan);
            zombie.thread slow_zombie();
        }
    }

    num_zombies = maps\_zombiemode_utility::array_size(affected_zombies);
    if(num_zombies <= 5)
    {
        slow_percent = 0.3;
    }
    else if(num_zombies <= 10)
    {
        slow_percent = 0.5;
    }
    else
    {
        slow_percent = 0.7;
    }

    self.speed_multiplier = level.tempus_speed_boost;
    self iprintlnbold("Vitesse augmentée");
    foreach(zombie in affected_zombies)
    {
        zombie.speed_multiplier = slow_percent;
        zombie iprintlnbold("Ralentissement du temps");
    }
    
    wait(level.tempus_duration);

    self.speed_multiplier = 1.0;
    foreach(zombie in affected_zombies)
    {
        if(isDefined(zombie.speed_multiplier))
        {
            zombie.speed_multiplier = 1.0;
            if(isDefined(zombie.time_trail))
            {
                zombie.time_trail delete();
            }
        }
    }

    AmbientStartAll();
}

removeVisualEffects(duration)
{
    wait(duration);
    self VisionSetNaked("none", 0.5);
}

slow_zombie()
{
    self endon("death");
    while(isDefined(self.speed_multiplier))
    {
        self.velocity = self.velocity * self.speed_multiplier;
        wait(0.05);
    }
}