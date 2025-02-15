level HasDyingWish(player) {
    if (player hasPerk("dying_wish")) {
        return true;
    }
    return false;
}

level ApplyDyingWish(player) {
    if (player.isDead() && HasDyingWish(player)) {
        vector playerPosition = player.origin;
        zombies = GetNearbyZombies(playerPosition, 10);  
        foreach (zombie in zombies) {
            zombie takeDamage(9999);  
            zombie iPrintLn("Zombie tué par la Dernière Volonté !");
        }
        player iPrintLn("Dernière Volonté activée ! Tous les zombies à proximité sont tués.");
        wait(5);  
        player revive();  
        player setHealth(100);  
        player iPrintLn("Vous avez été réanimé grâce à la Dernière Volonté !");
    }
}

level BuyDyingWish(player) {
    if (player.getPoints() >= 4000) {  
        if (!HasDyingWish(player)) {
            player givePerk("dying_wish");  
            player takePoints(4000);  
            player iPrintLn("Vous avez acheté Dying Wish pour 4000$ !");
        } else {
            player iPrintLn("Vous avez déjà la perk Dying Wish.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Dying Wish pour 4000$ !");
    wait(1);
    BuyDyingWish(player);
}

level CheckPlayerDeath(player) {
    if (player.isDead()) {
        ApplyDyingWish(player);  
    }
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onPlayerUpdate = function(player) {
        if (HasDyingWish(player)) {
            CheckPlayerDeath(player);
        }
    };
}

main() {
    init();  
}