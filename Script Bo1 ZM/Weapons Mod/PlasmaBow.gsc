init()
{
    level.plasma_bow_damage = 800;
    level.plasma_bow_radius = 4;
    level.plasma_bow_dot = 100;
    level.plasma_bow_duration = 10;
    level.plasma_bow_fx = loadfx("fx/plasma_trail");
    level.plasma_bow_explosion_fx = loadfx("fx/plasma_explosion");
    level.plasma_bow_plasma_fx = loadfx("fx/plasma_pool");
    level.plasma_bow_sound = "plasma_bow_fire";
    level.plasma_bow_explosion_sound = "plasma_explosion";
    add_weapon_to_box();
}

add_weapon_to_box()
{
    level.weapons["plasma_bow"] = spawnPlasmaBow;
}

spawnPlasmaBow(player)
{
    player.has_plasma_bow = true;
    player.giveWeapon("plasma_bow");
    player iprintlnbold("Vous avez obtenu le Plasma Bow");
    player thread plasma_bow_logic();
}

plasma_bow_logic()
{
    self endon("disconnect");

    while(self.has_plasma_bow)
    {
        if(self AttackButtonPressed())
        {
            self thread fire_plasma_arrow();
            wait(2);
        }
        wait(0.1);
    }
}

fire_plasma_arrow()
{
    start_origin = self getTagOrigin("j_gun");
    end_origin = self getEye() + anglesToForward(self getPlayerAngles()) * 1000;
    direction = vectorNormalize(end_origin - start_origin);
    playfx(level.plasma_bow_fx, start_origin);
    self playsound(level.plasma_bow_sound);
    trace = bulletTrace(start_origin, end_origin, true, self);
        
    if(isDefined(trace["ent"]))
    {
        plasma_explosion(trace["position"]);
    }
    else
    {
        plasma_explosion(end_origin);
    }
}

plasma_explosion(origin)
{
    playfx(level.plasma_bow_explosion_fx, origin);
    playsoundatposition(level.plasma_bow_explosion_sound, origin);
    radius_damage(origin, level.plasma_bow_radius, level.plasma_bow_damage);
    plasma_pool(origin);
}

plasma_pool(origin)
{
    fx = playfx(level.plasma_bow_plasma_fx, origin);
    end_time = level.time + (level.plasma_bow_duration * 1000);
    while(level.time < end_time)
    {
        zombies = getEntArray("zombie", "classname");
        foreach(zombie in zombies)
        {
            if(distance(zombie.origin, origin) <= level.plasma_bow_radius)
            {
                zombie.health -= level.plasma_bow_dot;
                zombie playfx(level.plasma_bow_fx);

                if(zombie.health <= 0)
                {
                    zombie notify("death");
                }
            }
        }
        wait(1);
    }

    fx delete();
}

radius_damage(origin, radius, damage)
{
    zombies = getEntArray("zombie", "classname");
    foreach(zombie in zombies)
    {
        if(distance(zombie.origin, origin) <= radius)
        {
            zombie.health -= damage;
            if(zombie.health <= 0)
            {
                zombie notify("death");
            }
        }
    }
}