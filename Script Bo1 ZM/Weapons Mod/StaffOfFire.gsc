level.custom_weapon_staff_of_fire = ::create_custom_weapon("staff_of_fire", "staff_of_fire", "fireball_projectile");
level.custom_weapon_staff_of_fire.damage = 1000;
level.custom_weapon_staff_of_fire.explosion_delay = 1.5;
level.custom_weapon_staff_of_fire.explosion_radius = 6;
level.custom_weapon_staff_of_fire.projectile_speed = 600;
level.custom_weapon_staff_of_fire.on_hit = ::staff_of_fire_explosion;
level.custom_weapon_staff_of_fire.on_hit = 
{
    explosion_point = self.origin + self.forward * level.custom_weapon_staff_of_fire.projectile_speed;
    CreateExplosion(explosion_point, level.custom_weapon_staff_of_fire.explosion_radius);
    zombies_in_range = GetZombiesInRange(explosion_point, level.custom_weapon_staff_of_fire.explosion_radius);
    for( zombie in zombies_in_range )
    {
        zombie.ApplyDamage(level.custom_weapon_staff_of_fire.damage);
    }

    PlayEffectAtPosition("fire_explosion", explosion_point);
};

create_fireball_projectile = 
{
    fireball = CreateProjectile(self.origin, self.forward, "fireball_projectile", level.custom_weapon_staff_of_fire.projectile_speed);
    fireball.on_hit = level.custom_weapon_staff_of_fire.on_hit;
};

level.on_box_spawn = 
{
    AddWeaponToMysteryBox(level.custom_weapon_staff_of_fire);
};

PlayFireballEffect = 
{
    fireball_effect = "fireball_effect";
    PlayEffectAtPosition(fireball_effect, self.origin);
};