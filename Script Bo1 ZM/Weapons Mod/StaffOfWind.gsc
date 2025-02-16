level.custom_weapon_staff_of_wind = ::create_custom_weapon("staff_of_wind", "staff_of_wind", "wind_tornado_projectile");
level.custom_weapon_staff_of_wind.damage = 100;
level.custom_weapon_staff_of_wind.tornado_radius = 8;
level.custom_weapon_staff_of_wind.tornado_duration = 5;
level.custom_weapon_staff_of_wind.tornado_pull_strength = 15;

create_wind_tornado = 
{
    origin = self.origin;
    tornado = spawn_tornado_effect(origin);
    zombies_in_range = GetZombiesInRange(origin, level.custom_weapon_staff_of_wind.tornado_radius);
    
    for( zombie in zombies_in_range )
    {
        zombie.ApplyDamage(level.custom_weapon_staff_of_wind.damage);
        ApplyTornadoForce(zombie, origin);
    }

    wait(level.custom_weapon_staff_of_wind.tornado_duration);
    tornado delete();
};

spawn_tornado_effect = 
{
    origin = argument;
    tornado_effect = PlayEffectAtPosition("tornado_effect", origin);
    return tornado_effect;
};

ApplyTornadoForce = 
{
    zombie = argument;
    origin = zombie.origin;
    direction = (origin - zombie.origin).Normalize();
    zombie.SetMoveSpeed(level.custom_weapon_staff_of_wind.tornado_pull_strength);
    zombie.SetOrigin(zombie.origin + direction * level.custom_weapon_staff_of_wind.tornado_pull_strength);
    if( (origin - zombie.origin).Length() < 2 )
    {
        zombie.ApplyDamage(level.custom_weapon_staff_of_wind.damage);
        PlayTornadoSound(zombie.origin);
    }
};

PlayTornadoSound = 
{
    position = argument;
    PlaySoundAtPosition("tornado_sound", position);
};

level.on_box_spawn = 
{
    AddWeaponToMysteryBox(level.custom_weapon_staff_of_wind);
};

AddWeaponToMysteryBox = 
{
    player = GetClosestPlayer();
    player.GiveWeapon(level.custom_weapon_staff_of_wind);
};