level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level SpawnLightningEffect(player) {
    if (VIPCheck(player)) {
        player iPrintLn("Effet de Lightning activé pour montrer votre statut VIP.");
        pos = player getOrigin();
        pos[2] = pos[2] + 50;
        level.playSoundAtPosition("lightning_sound", pos);
        level.fx("lightning", pos);
    }
}

level StartLightningEffectTimer(player) {
    if (VIPCheck(player)) {
        while (true) {
            wait(300); 
            SpawnLightningEffect(player);
        }
    }
}

init() {
    level.onPlayerSpawn = StartLightningEffectTimer;
}

main() {
    init();
}