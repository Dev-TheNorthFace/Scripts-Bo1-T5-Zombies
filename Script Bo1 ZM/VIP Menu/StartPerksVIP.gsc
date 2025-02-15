level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level GiveVIPPerks(player) {
    if (VIPCheck(player)) {
        player givePerk("juggernog");
        player givePerk("fast_reload");
        player givePerk("quick_recharge");
        player givePerk("marathon");
        player givePerk("quick_revive");
        player iPrintLn("Vous avez reçu tous les perks VIP: Juggernog, Tir Rapide, Recharge Rapide, Marathon et Quick Revive.");
    } else {
    }
}

level OnGameStart(player) {
    GiveVIPPerks(player);
}

init() {
    level.onGameStart = OnGameStart;
}

main() {
    init();
}