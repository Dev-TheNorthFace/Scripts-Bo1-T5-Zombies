level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level HandlePackAPunch(player) {
    if (VIPCheck(player)) {
        if (player.cash >= 2500) {
            player.cash -= 2500;
            player iPrintLn("Vous avez payé 2500$ pour utiliser le Pack-a-Punch.");
            player setWeaponDamage("packapunch_weapon", 999);
        } else {
            player iPrintLn("Vous n'avez pas assez d'argent pour utiliser le Pack-a-Punch.");
        }
    } else {
    }
}

level OnPackAPunchUsed(player) {
    HandlePackAPunch(player);
}

level OnPlayerInteractWithPackAPunch(player) {
    OnPackAPunchUsed(player);
}

init() {
    level.onPlayerInteractWithPackAPunch = OnPlayerInteractWithPackAPunch;
}

main() {
    init();
}