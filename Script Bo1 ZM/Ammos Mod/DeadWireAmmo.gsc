dead_wire_radius = 300;
dead_wire_damage = 150;
chance_of_dead_wire = 1 / 7;
electric_shock_radius = 150;

apply_electric_shock( zombie ) {
    zombies_in_range = GetZombiesInRange(zombie.origin, electric_shock_radius);
    for (i = 0; i < zombies_in_range.size; i++) {
        target = zombies_in_range[i];
        target ApplyDamage(dead_wire_damage);
        spawn("scripts/zm_fx/electric_shock.fx", target.origin);
    }
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("dead_wire_ammo");
            weapon AttachEvent("fire", ::on_fire_dead_wire, player);
            player iPrintLn("Vous avez obtenu les munitions Dead Wire !");
        } else {
        }
    }
}

on_fire_dead_wire( player, weapon ) {
    target = weapon GetTarget();
    if (target IsZombie()) {
        apply_electric_shock(target);
        spawn("scripts/zm_fx/electric_shock.fx", target.origin);
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