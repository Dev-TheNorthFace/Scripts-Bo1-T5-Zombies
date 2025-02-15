level HasDeadshot(player) {
    if (player hasPerk("deadshot_daiquiri")) {
        return true;
    }
    return false;
}

level ApplyDeadshotEffect(player) {
    player setClientDvar("cg_fov", 80);
    player setClientDvar("cg_crosshairSize", 2);
    player setClientDvar("cg_crosshairColor", "1"); 
    player setClientDvar("aim_assist", 1);
    player iPrintLn("Deadshot Daiquiri activé : Précision augmentée et visée tête améliorée !");
}

level BuyDeadshot(player) {
    if (player.getPoints() >= 3000) {
        if (!HasDeadshot(player)) {
            player givePerk("deadshot_daiquiri");
            player takePoints(3000);
            ApplyDeadshotEffect(player);
            player iPrintLn("Vous avez acheté Deadshot Daiquiri pour 3000$");
        } else {
            player iPrintLn("Vous avez déjà la perk Deadshot Daiquiri.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Deadshot Daiquiri pour 3000$");
    wait(1);
    BuyDeadshot(player);
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
}

main() {
    init();
}