level HasWintersWail(player) {
    if (player hasPerk("winters_wail")) {
        return true;
    }
    return false;
}

level ApplyWintersWailEffect(player) {
    if (HasWintersWail(player)) {
        player onTakeDamage( function() {
            if (player.health <= 0) {
                return;
            }
            
            vector playerPosition = player.origin;
            zombies = GetNearbyZombies(playerPosition, 10);

            foreach (zombie in zombies) {
                zombie freeze();
                zombie iPrintLn("Zombie gelé par Winter's Wail !");
            }
            
            spawnFx("winters_wail_explosion_fx", playerPosition);
            player playSoundAtPos("winters_wail_explosion_sound", playerPosition);
            player iPrintLn("Explosion de Winter's Wail activée !");
        });
    }
}

level BuyWintersWail(player) {
    if (player.getPoints() >= 4000) {
        if (!HasWintersWail(player)) {
            player givePerk("winters_wail");
            player takePoints(4000);
            player iPrintLn("Vous avez acheté Winter's Wail pour 4000$ !");
        } else {
            player iPrintLn("Vous avez déjà la perk Winter's Wail.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Winter's Wail pour 4000$ !");
    wait(1);
    BuyWintersWail(player);
}

level CheckPlayerDamage(player) {
    if (HasWintersWail(player)) {
        ApplyWintersWailEffect(player);
    }
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onPlayerUpdate = function(player) {
        if (HasWintersWail(player)) {
            CheckPlayerDamage(player);
        }
    };
}

main() {
    init();
}