blast_furnace_radius = 300;
blast_furnace_damage = 150;
burn_damage = 10;
burn_duration = 5;
chance_of_blast_furnace = 1 / 7;

apply_burn_damage( zombie ) {
    zombie ApplyDamage(burn_damage);
    zombie Burn(burn_duration);
}

blast_furnace_explosion( zombie ) {
    zombie Explode(blast_furnace_radius);
    zombie ApplyDamage(blast_furnace_damage);
    spawn("scripts/zm_fx/blast_furnace_explosion.fx", zombie.origin);
}

on_pack_a_punch_weapon( weapon, player ) {
    if (weapon IsPackaPunched()) {
        random_chance = randomInt(1, 7);
        if (random_chance == 1) {
            weapon SetAmmoType("blast_furnace_ammo");
            weapon AttachEvent("fire", ::on_fire_blast_furnace, player);
            player iPrintLn("Vous avez obtenu les munitions Blast Furnace");
        } else {
        }
    }
}

on_fire_blast_furnace( player, weapon ) {
    target = weapon GetTarget();
    if (target IsZombie()) {
        apply_burn_damage(target);
        wait(burn_duration);
        blast_furnace_explosion(target);
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