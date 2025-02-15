init()
{
    level.spectral_crossbow_damage = 800;
    level.spectral_crossbow_speed = 4000;
    level.spectral_crossbow_fx = loadfx("fx/spectral_arrow_trail");
    level.spectral_crossbow_impact_fx = loadfx("fx/spectral_impact");
    level.spectral_crossbow_sound = "spectral_arrow_flyby";
    level.spectral_crossbow_impact_sound = "spectral_impact_sound";
    add_weapon_to_box();
}

add_weapon_to_box()
{
    level.weapons["spectral_crossbow"] = spawnSpectralCrossbow;
}

spawnSpectralCrossbow(player)
{
    player.has_spectral_crossbow = true;
    player.giveWeapon("spectral_crossbow");
    player iprintlnbold("Vous avez obtenu le Spectral Crossbow");
    player thread spectral_crossbow_logic();
}

spectral_crossbow_logic()
{
    self endon("disconnect");

    while(self.has_spectral_crossbow)
    {
        if(self AttackButtonPressed())
        {
            self thread fire_spectral_bolt();
            wait(1.5);
        }
        wait(0.1);
    }
}

fire_spectral_bolt()
{
    start_origin = self getTagOrigin("j_gun");
    dir = anglestoforward(self getplayerangles());
    end_origin = start_origin + (dir * 100000);
    bolt = spawn("script_model", start_origin);
    bolt setmodel("tag_origin");
    bolt.angles = self.angles;
    bolt.velocity = dir * level.spectral_crossbow_speed;
    bolt playfx(level.spectral_crossbow_fx, bolt.origin);
    bolt playsound(level.spectral_crossbow_sound);

    bolt thread spectral_bolt_trajectory(dir);
}

spectral_bolt_trajectory(dir)
{
    self endon("hit");
    
    while(1)
    {
        self movez(dir, 0.1);
        zombies = getEntArray("zombie", "classname");
        foreach(zombie in zombies)
        {
            if(distance(zombie.origin, self.origin) < 50)
            {
                zombie.health -= level.spectral_crossbow_damage;
                playfx(level.spectral_crossbow_impact_fx, self.origin);
                zombie playsound(level.spectral_crossbow_impact_sound);
                self notify("hit");
                self delete();
                return;
            }
        }
        wait(0.05);
    }
}