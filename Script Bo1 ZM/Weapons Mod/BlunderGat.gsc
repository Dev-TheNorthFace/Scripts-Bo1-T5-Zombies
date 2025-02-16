level.custom_weapon_acidgat = ::create_custom_weapon("acidgat", "acidgat", "acidsplash");
level.custom_weapon_acidgat.damage = 1000;
level.custom_weapon_acidgat.explosion_delay = 1;
level.custom_weapon_acidgat.explosion_radius = 5;
level.custom_weapon_acidgat.projectile_speed = 500;

level.custom_weapon_acidgat.on_hit = ::acid_explosion;

level.custom_weapon_acidgat.on_hit = 
{
    explosion_point = self.origin + self.forward * level.custom_weapon_acidgat.projectile_speed;
    CreateExplosion(explosion_point, level.custom_weapon_acidgat.explosion_radius);
    zombies = GetZombiesInRange(explosion_point, level.custom_weapon_acidgat.explosion_radius);
    for( zombie in zombies )
    {
        zombie.ApplyDamage(level.custom_weapon_acidgat.damage);
        zombie.ApplyAcidDebuff();
    }
};

level.custom_weapon_acidgat_vitriolic = ::create_custom_weapon("vitriolic", "vitriolic_withering", "acid_splash_vitriolic");
level.custom_weapon_acidgat_vitriolic.damage = 2000;
level.custom_weapon_acidgat_vitriolic.explosion_delay = 0.5;
level.custom_weapon_acidgat_vitriolic.explosion_radius = 7;
level.custom_weapon_acidgat_vitriolic.projectile_speed = 700;
level.custom_weapon_acidgat_vitriolic.zombie_attraction_radius = 15; 

level.custom_weapon_acidgat_vitriolic.on_hit = 
{
    explosion_point = self.origin + self.forward * level.custom_weapon_acidgat_vitriolic.projectile_speed;
    CreateExplosion(explosion_point, level.custom_weapon_acidgat_vitriolic.explosion_radius);
    zombies = GetZombiesInRange(explosion_point, level.custom_weapon_acidgat_vitriolic.zombie_attraction_radius);
    for( zombie in zombies )
    {
        zombie.MoveTowards(explosion_point);
        zombie.ApplyDamage(level.custom_weapon_acidgat_vitriolic.damage);
    }
};

level.on_packapunch = 
{
    if(self weapon == level.custom_weapon_acidgat)
    {
        self weapon = level.custom_weapon_acidgat_vitriolic;
        player.GivePoints(-5000);
    }
};