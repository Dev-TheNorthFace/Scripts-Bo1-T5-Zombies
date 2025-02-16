level.custom_weapon_slingficateur = ::create_custom_weapon("slingficateur", "slingficateur", "violet_liquid_projectile");
level.custom_weapon_slingficateur.damage = 200;
level.custom_weapon_slingficateur.explosion_delay = 2;
level.custom_weapon_slingficateur.explosion_radius = 4;
level.custom_weapon_slingficateur.projectile_speed = 400;
level.custom_weapon_slingficateur.slippery_surface_radius = 5;
level.custom_weapon_slingficateur.chain_damage_radius = 3;

level.custom_weapon_slingficateur.on_hit = ::slingficateur_explosion;

level.custom_weapon_slingficateur.on_hit = 
{
    explosion_point = self.origin + self.forward * level.custom_weapon_slingficateur.projectile_speed;
    CreateExplosion(explosion_point, level.custom_weapon_slingficateur.explosion_radius);
    surfaces = GetSurfacesInRange(explosion_point, level.custom_weapon_slingficateur.slippery_surface_radius);
    for( surface in surfaces )
    {
        ApplySlipperyEffect(surface);
    }

    zombies = GetZombiesInRange(explosion_point, level.custom_weapon_slingficateur.chain_damage_radius);
    for( zombie in zombies )
    {
        zombie.ApplyDamage(level.custom_weapon_slingficateur.damage);
        if( zombie.IsAlive() )
        {
            zombies_in_chain = GetZombiesInRange(zombie.origin, level.custom_weapon_slingficateur.chain_damage_radius);
            for( chained_zombie in zombies_in_chain )
            {
                chained_zombie.ApplyDamage(level.custom_weapon_slingficateur.damage);
            }
        }
    }
};

ApplySlipperyEffect = 
{
    surfaces_in_radius = GetSurfacesInRange(self.origin, level.custom_weapon_slingficateur.slippery_surface_radius);
    for( surface in surfaces_in_radius )
    {
        surface.SetSlippery(true);
        entities_in_radius = GetEntitiesInRange(surface.origin, level.custom_weapon_slingficateur.slippery_surface_radius);
        for( entity in entities_in_radius )
        {
            if( entity is player )
            {
                entity.ApplySlipperyEffect();
            }
            if( entity is zombie )
            {
                entity.ApplySlipperyEffect();
            }
        }
    }
};

level.on_box_spawn = 
{
    AddWeaponToMysteryBox(level.custom_weapon_slingficateur);
};