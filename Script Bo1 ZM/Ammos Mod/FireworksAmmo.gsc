fireworks_radius = 300;
fireworks_damage = 100;
chance_of_fireworks = 1 / 7;

fireworks_explosion( zombie ) {
    zombie Explode(fireworks_radius);
    zombie ApplyDamage(fireworks_damage);
    spawn("scripts/zm_fx/fireworks.fx", zombie.origin);
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("fireworks_ammo");
            weapon AttachEvent("fire", ::on_fire_fireworks, player);
            player iPrintLn("Vous avez obtenu les munitions de feu d'artifice");
        } else {
        }
    }
}

on_fire_fireworks( player, weapon ) {
    target = weapon GetTarget();

    if (target IsZombie()) {
        fireworks_explosion(target);
    }
}

on_player_spawn( player ) {
    player AttachEvent("weapon_change", ::on_weapon_change, player);
}

on_weapon_change( player, weapon ) {
    if (weapon IsPackaPunched()) {
        on_pack_a_punch_weapon( weapon, player );
    }
}