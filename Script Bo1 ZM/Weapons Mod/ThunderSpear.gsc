init()
{
    level.thunder_spear_damage = 1000;
    level.thunder_spear_radius = 5;
    level.thunder_spear_penetration = 5;
    level.thunder_spear_fx = loadfx("fx/electric_trail");
    level.thunder_spear_impact_fx = loadfx("fx/electric_explosion");
    level.thunder_spear_sound = "thunder_spear_fire";
    level.thunder_spear_impact_sound = "thunder_spear_impact";
    add_weapon_to_box();
}

add_weapon_to_box()
{
    level.weapons["thunder_spear"] = spawnThunderSpear;
}

spawnThunderSpear(player)
{
    player.has_thunder_spear = true;
    player.giveWeapon("thunder_spear");
    player iprintlnbold("Vous avez obtenu le Thunder Spear");
    player thread thunder_spear_logic();
}

thunder_spear_logic()
{
    self endon("disconnect");

    while(self.has_thunder_spear)
    {
        if(self AttackButtonPressed())
        {
            self thread fire_thunder_spear();
            wait(1.5);
        }
        wait(0.1);
    }
}

fire_thunder_spear()
{
    start_origin = self getTagOrigin("j_gun");
    end_origin = self getEye() + anglesToForward(self getPlayerAngles()) * 1000;
    direction = vectorNormalize(end_origin - start_origin);
    playfx(level.thunder_spear_fx, start_origin);
    self playsound(level.thunder_spear_sound);

    penetration = 0;
    hit_zombies = [];

    while(penetration < level.thunder_spear_penetration)
    {
        trace = bulletTrace(start_origin, end_origin, true, self);
        
        if(isDefined(trace["ent"]))
        {
            hit = trace["ent"];
            if(isAlive(hit) && isZombie(hit) && !(isDefined(hit_zombies[hit])))
            {
                hit_zombies[hit] = true;
                penetration++;
                hit.health -= level.thunder_spear_damage;
                playfx(level.thunder_spear_impact_fx, hit.origin);
                hit playsound(level.thunder_spear_impact_sound);
                electric_explosion(hit.origin);

                if(hit.health <= 0)
                {
                    hit notify("death");
                }
            }
        }
        else
        {
            break;
        }
        
        start_origin = trace["position"] + direction * 10;
    }
}

electric_explosion(origin)
{
    playfx(level.thunder_spear_impact_fx, origin);
    playsoundatposition(level.thunder_spear_impact_sound, origin);
    radius_damage(origin, level.thunder_spear_radius, level.thunder_spear_damage / 2);
    for(i = 0; i < 5; i++)
    {
        offset = (randomfloat() - 0.5) * level.thunder_spear_radius;
        pos = origin + (0, offset, offset);
        playfx(level.thunder_spear_fx, pos);
    }
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