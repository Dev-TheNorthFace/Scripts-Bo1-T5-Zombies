level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level AwardPoints(player, points) {
    if (VIPCheck(player)) {
        points = points * 4;
        player iPrintLn("Vous avez gagné 4x plus de points grâce à votre statut VIP.");
    }
    player givePoints(points);
}

level OnZombieKill(player, zombie) {
    points = 100;
    AwardPoints(player, points);
}

level OnPieceCollected(player, piece) {
    points = 50;
    AwardPoints(player, points);
}

init() {
    level.onZombieKill = OnZombieKill;
    level.onPieceCollected = OnPieceCollected;
}

main() {
    init();
}