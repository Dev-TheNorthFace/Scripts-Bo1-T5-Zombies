thunder_wall_damage = 100;
thunder_wall_radius = 200;
thunder_wall_knockback = 500;
chance_of_thunder_wall = 1 / 7;

apply_thunder_wall_effect( zombie ) {
    zombie ApplyDamage(thunder_wall_damage);
    direction = (zombie.origin - player.origin);
    direction Normalize();
    zombie ApplyKnockback(direction * thunder_wall_knockback);
    spawn("scripts/zm_fx/thunder_wall.fx", zombie.origin);
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("thunder_wall_ammo");
            weapon AttachEvent("fire", ::on_fire_thunder_wall, player);
            player iPrintLn("Vous avez obtenu les munitions Thunder Wall !");
        } else {
        }
    }
}

on_fire_thunder_wall( player, weapon ) {
    target = weapon GetTarget();
    if (target IsZombie()) {
        apply_thunder_wall_effect(target);
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