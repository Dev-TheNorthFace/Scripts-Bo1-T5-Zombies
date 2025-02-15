shatter_blast_damage = 100;
chance_of_shatter_blast = 1 / 7;
shatter_blast_radius = 200;
shatter_blast_explosion_effect = "scripts/zm_fx/shatter_blast_explosion.fx";

apply_shatter_blast_effect( zombie ) {
    zombies_in_range = GetZombiesInRange(zombie.origin, shatter_blast_radius);
    for (i = 0; i < zombies_in_range.size; i++) {
        target = zombies_in_range[i];
        target ApplyDamage(shatter_blast_damage);
        spawn(shatter_blast_explosion_effect, target.origin);
    }
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("shatter_blast_ammo");
            weapon AttachEvent("fire", ::on_fire_shatter_blast, player);
            player iPrintLn("Vous avez obtenu les munitions Shatter Blast !");
        } else {
        }
    }
}

on_fire_shatter_blast( player, weapon ) {
    target = weapon GetTarget();
    if (target IsZombie()) {
        apply_shatter_blast_effect(target);
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