level.custom_weapon_aphotic_servant = ::create_custom_weapon("aphotic_servant", "aphotic_servant", "black_hole_projectile");
level.custom_weapon_aphotic_servant.damage = 500;
level.custom_weapon_aphotic_servant.hole_radius = 10;
level.custom_weapon_aphotic_servant.hole_duration = 5;
level.custom_weapon_aphotic_servant.pull_strength = 20;

create_black_hole = 
{
    origin = self.origin;
    black_hole = spawn_black_hole_effect(origin);
    
    zombies_in_range = GetZombiesInRange(origin, level.custom_weapon_aphotic_servant.hole_radius);
    
    for( zombie in zombies_in_range )
    {
        zombie.ApplyDamage(level.custom_weapon_aphotic_servant.damage);
        ApplyBlackHoleForce(zombie, origin);
    }

    wait(level.custom_weapon_aphotic_servant.hole_duration);
    
    black_hole delete();
};

spawn_black_hole_effect = 
{
    origin = argument;
    black_hole_effect = PlayEffectAtPosition("black_hole_effect", origin);
    return black_hole_effect;
};

ApplyBlackHoleForce = 
{
    zombie = argument;
    origin = zombie.origin;

    direction = (origin - zombie.origin).Normalize();
    
    zombie.SetMoveSpeed(level.custom_weapon_aphotic_servant.pull_strength);
    zombie.SetOrigin(zombie.origin + direction * level.custom_weapon_aphotic_servant.pull_strength);
    
    if( (origin - zombie.origin).Length() < 2 )
    {
        zombie.ApplyDamage(level.custom_weapon_aphotic_servant.damage);
        PlayBlackHoleSound(zombie.origin);
    }
};

PlayBlackHoleSound = 
{
    position = argument;
    PlaySoundAtPosition("black_hole_sound", position);
};

level.on_box_spawn = 
{
    AddWeaponToMysteryBox(level.custom_weapon_aphotic_servant);
};

AddWeaponToMysteryBox = 
{
    player = GetClosestPlayer();
    player.GiveWeapon(level.custom_weapon_aphotic_servant);
};