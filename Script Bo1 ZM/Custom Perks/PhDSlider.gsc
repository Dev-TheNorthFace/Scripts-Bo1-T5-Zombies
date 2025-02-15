level HasPhDSlider(player) {
    if (player hasPerk("phd_slider")) {
        return true;
    }
    return false;
}

level ApplySlideEffect(player) {
    if (player.isSliding()) {
        player setClientDvar("player_damage", 0);
    }
}

level TriggerSlideExplosion(player) {
    if (!player.isSliding()) {
        vector slidePosition = player.origin;
        zombies = GetNearbyZombies(slidePosition, 10);
        foreach (zombie in zombies) {
            zombie takeDamage(50);
            zombie iPrintLn("Explosion de PhD Slider");
        }

        spawnFx("phd_slider_explosion_fx", slidePosition);
        player playSoundAtPos("explosion_sound", slidePosition);
    }
}

level BuyPhDSlider(player) {
    if (player.getPoints() >= 3000) {
        if (!HasPhDSlider(player)) {
            player givePerk("phd_slider");
            player takePoints(3000);
            player iPrintLn("Vous avez acheté PhD Slider pour 3000$");
        } else {
            player iPrintLn("Vous avez déjà la perk PhD Slider.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez PhD Slider pour 3000$");
    wait(1);
    BuyPhDSlider(player);
}

level CheckSlideStatus(player) {
    if (player.isSliding()) {
        ApplySlideEffect(player);
    }
    TriggerSlideExplosion(player);
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onPlayerUpdate = function(player) {
        if (HasPhDSlider(player)) {
            CheckSlideStatus(player);
        }
    };
}

main() {
    init();
}