cryo_freeze_duration = 5;
cryo_freeze_slowdown = 0.5;
chance_of_cryo_freeze = 1 / 7;

apply_cryo_freeze_effect( zombie ) {
    zombie ApplyFrozen(cryo_freeze_duration);
    zombie SetSpeed(zombie GetSpeed() * cryo_freeze_slowdown);
    spawn("scripts/zm_fx/cryo_freeze.fx", zombie.origin);
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("cryo_freeze_ammo");
            weapon AttachEvent("fire", ::on_fire_cryo_freeze, player);
            player iPrintLn("Vous avez obtenu les munitions Cryo Freeze !");
        } else {
        }
    }
}

on_fire_cryo_freeze( player, weapon ) {
    target = weapon GetTarget();
    if (target IsZombie()) {
        apply_cryo_freeze_effect(target);
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