level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level ActivateSpeedBoost(player) {
    if (VIPCheck(player)) {
        if (!player.hasActivatedSpeedBoost) {
            player.hasActivatedSpeedBoost = true;
            player iPrintLn("Vous avez activé le boost de vitesse, vous aurez 5 minutes de vitesse accrue.");
            
            player setMoveSpeed(2.0);
            player wait(300);
            player setMoveSpeed(2.0);
            player iPrintLn("Votre boost de vitesse est terminé.");
        } else {
            player iPrintLn("Vous avez déjà activé votre boost de vitesse une fois cette partie.");
        }
    } else {
    }
}

level OnActivateSpeedBoost(player) {
    ActivateSpeedBoost(player);
}

init() {
    level.onPlayerPressBoostButton = OnActivateSpeedBoost;
}

main() {
    init();
}