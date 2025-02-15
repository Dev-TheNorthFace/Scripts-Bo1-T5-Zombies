fire_bomb_damage_per_second = 15;
fire_bomb_duration = 5;
chance_of_fire_bomb = 1 / 7;

apply_fire_bomb_effect( zombie ) {
    zombie ApplyBurn(fire_bomb_duration);
    zombie ApplyDamage(fire_bomb_damage_per_second);
    spawn("scripts/zm_fx/fire_bomb_explosion.fx", zombie.origin);
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("fire_bomb_ammo");
            weapon AttachEvent("fire", ::on_fire_fire_bomb, player);
            player iPrintLn("Vous avez obtenu les munitions Fire Bomb");
        } else {
        }
    }
}

on_fire_fire_bomb( player, weapon ) {
    target = weapon GetTarget();
    if (target IsZombie()) {
        apply_fire_bomb_effect(target);
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