level HasWidowsWine(player) {
    if (player hasPerk("widows_wine")) {
        return true;
    }
    return false;
}

level CreateWebEffect(player, zombie) {
    if (randomInt(0, 100) < 50) {
        vector webPosition = zombie.origin;
        webFx = spawnFx("widows_wine_web_fx", webPosition);
        zombies = GetNearbyZombies(webPosition, 10);
        foreach (zombie in zombies) {
            zombie setMoveSpeed(0.5);
            zombie takeDamage(10);
            zombie iPrintLn("Empoisonné et ralenti");
        }
    }
}

level BuyWidowsWine(player) {
    if (player.getPoints() >= 4000) {
        if (!HasWidowsWine(player)) {
            player givePerk("widows_wine");
            player takePoints(4000);
            player iPrintLn("Vous avez acheté Widow's Wine pour 4000$");
        } else {
            player iPrintLn("Vous avez déjà la perk Widow's Wine.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level GiveSpecialGrenades(player) {
    player giveWeapon("special_grenade", 1);
    player iPrintLn("Grenades spéciales disponibles ! Elles ralentiront les zombies.");
}

level HandleSpecialGrenadeExplosion(player, grenade) {
    zombies = GetNearbyZombies(grenade.origin, 10);
    foreach (zombie in zombies) {
        zombie setMoveSpeed(0.25)
        zombie takeDamage(10);
    }
    grenade explode();
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Widow's Wine pour 4000$");
    wait(1);
    BuyWidowsWine(player);
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onPlayerBuyPerk = function(player) {
        if (HasWidowsWine(player)) {
            GiveSpecialGrenades(player);
        }
    };
    
    level.onZombieHitPlayer = function(zombie, player) {
        if (HasWidowsWine(player)) {
            CreateWebEffect(player, zombie);
        }
    };
}

main() {
    init();
}