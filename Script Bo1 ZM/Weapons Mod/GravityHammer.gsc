init()
{
    level.gravity_hammer_radius = 10;
    level.gravity_hammer_damage = 500;
    level.gravity_hammer_knockback = 400;
    level.gravity_hammer_fx = loadfx("fx/gravity_wave");
    level.gravity_hammer_shock_fx = loadfx("fx/gravity_shock");
    level.gravity_hammer_sound = "gravity_hammer_smash";
    level.gravity_hammer_vibration_sound = "gravity_vibration";
    add_weapon_to_box();
}

add_weapon_to_box()
{
    level.weapons["gravity_hammer"] = spawnGravityHammer;
}

spawnGravityHammer(player)
{
    player.has_gravity_hammer = true;
    player.giveWeapon("gravity_hammer");
    player iprintlnbold("Vous avez obtenu le Gravity Hammer");
    player thread gravity_hammer_logic();
}

gravity_hammer_logic()
{
    self endon("disconnect");

    while(self.has_gravity_hammer)
    {
        if(self AttackButtonPressed())
        {
            self thread smash_ground();
            wait(8);
        }
        wait(0.1);
    }
}

smash_ground()
{
    start_origin = self getTagOrigin("j_gun");
    playfx(level.gravity_hammer_fx, start_origin);
    self playsound(level.gravity_hammer_sound);
    self playsound(level.gravity_hammer_vibration_sound);
    zombies = getEntArray("zombie", "classname");
    foreach(zombie in zombies)
    {
        if(distance(zombie.origin, start_origin) <= level.gravity_hammer_radius)
        {
            dir = vectorNormalize(zombie.origin - start_origin);
            zombie.velocity = dir * level.gravity_hammer_knockback;
            zombie.health -= level.gravity_hammer_damage;
            zombie playfx(level.gravity_hammer_shock_fx);
        }
    }
}