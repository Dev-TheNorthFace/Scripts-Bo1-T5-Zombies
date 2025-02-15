level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level AdjustDoorPrice(player, door) {
    if (VIPCheck(player)) {
        originalPrice = door getPrice();
        reducedPrice = originalPrice / 2;
        door setPrice(reducedPrice);
        player iPrintLn("Le prix de la porte est réduit de moitié grâce à votre statut VIP.");
    } else {
    }
}

level OnDoorInteraction(player, door) {
    AdjustDoorPrice(player, door);
}


init() {
    level.onPlayerInteractWithDoor = OnDoorInteraction;
}

main() {
    init();
}