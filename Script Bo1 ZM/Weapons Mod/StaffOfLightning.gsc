level.custom_weapon_staff_of_lightning = ::create_custom_weapon("staff_of_lightning", "staff_of_lightning", "lightning_projectile");
level.custom_weapon_staff_of_lightning.damage = 200;
level.custom_weapon_staff_of_lightning.lightning_radius = 10;
level.custom_weapon_staff_of_lightning.lightning_duration = 0.1;
level.custom_weapon_staff_of_lightning.projectile_speed = 1000;

generate_lightning_strike = 
{
    origin = self.origin;
    zombies_in_range = GetZombiesInRange(origin, level.custom_weapon_staff_of_lightning.lightning_radius);
    for( zombie in zombies_in_range )
    {
        zombie.ApplyDamage(level.custom_weapon_staff_of_lightning.damage);
        PlayLightningEffect(zombie.origin);
        wait(level.custom_weapon_staff_of_lightning.lightning_duration);
    }
};

PlayLightningEffect = 
{
    position = argument;
    PlayEffectAtPosition("lightning_effect", position);

create_lightning_projectile = 
{
    lightning_projectile = CreateProjectile(self.origin, self.forward, "lightning_projectile", level.custom_weapon_staff_of_lightning.projectile_speed);
    lightning_projectile.on_hit = ::staff_of_lightning_on_hit;
};

staff_of_lightning_on_hit = 
{

    generate_lightning_strike(self.origin);
};

level.on_box_spawn = 
{
    AddWeaponToMysteryBox(level.custom_weapon_staff_of_lightning);
};

AddWeaponToMysteryBox = 
{
    player = GetClosestPlayer();
    player.GiveWeapon(level.custom_weapon_staff_of_lightning);
};