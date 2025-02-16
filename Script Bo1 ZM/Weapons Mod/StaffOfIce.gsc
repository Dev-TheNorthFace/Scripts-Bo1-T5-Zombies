level.custom_weapon_staff_of_ice = ::create_custom_weapon("staff_of_ice", "staff_of_ice", "ice_projectile");
level.custom_weapon_staff_of_ice.freeze_duration = 5;
level.custom_weapon_staff_of_ice.projectile_speed = 500;
level.custom_weapon_staff_of_ice.freeze_radius = 3;

apply_freeze_effect = 
{
    zombie = argument;
    zombie.SetMoveSpeed(0);
    zombie.SetCanAttack(false);
    PlayFreezeEffect(zombie.origin);
    wait(level.custom_weapon_staff_of_ice.freeze_duration);
    zombie.SetMoveSpeed(100);
    zombie.SetCanAttack(true);
};

PlayFreezeEffect = 
{
    position = argument;
    PlayEffectAtPosition("freeze_effect", position);
};

create_ice_projectile = 
{
    ice_projectile = CreateProjectile(self.origin, self.forward, "ice_projectile", level.custom_weapon_staff_of_ice.projectile_speed);
    ice_projectile.on_hit = ::staff_of_ice_freeze_on_hit;
};

staff_of_ice_freeze_on_hit = 
{
    hit_point = self.origin + self.forward * level.custom_weapon_staff_of_ice.projectile_speed;
    zombies_in_range = GetZombiesInRange(hit_point, level.custom_weapon_staff_of_ice.freeze_radius);
    for( zombie in zombies_in_range )
    {
        apply_freeze_effect(zombie);
    }

    PlayFreezeEffect(hit_point);
};

level.on_box_spawn = 
{
    AddWeaponToMysteryBox(level.custom_weapon_staff_of_ice);
};

AddWeaponToMysteryBox = 
{
    player = GetClosestPlayer();
    player.GiveWeapon(level.custom_weapon_staff_of_ice);
};