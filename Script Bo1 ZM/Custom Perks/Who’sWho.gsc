level HasWhosWho(player) {
    if (player hasPerk("whos_who")) {
        return true;
    }
    return false;
}

level ActivateGhostMode(player) {
    player takeAllWeapons();
    player takeAllPerks();
    player playFx("whos_who_ghost_effect", player.origin);
    player setAlpha(0.5);
    
    player.ghostPosition = player.origin;
    player iPrintLn("Vous êtes un fantôme. Courez pour revenir à votre position !");
}

level CheckGhostReturn(player) {
    if (player.origin distanceTo(player.ghostPosition) < 10) {
        player revive();
        player giveAllWeapons();
        player giveAllPerks();
        player setAlpha(1);
        player iPrintLn("Vous êtes revenu à la vie");
    }
}

level OnPlayerDeath(player) {
    if (HasWhosWho(player)) {
        ActivateGhostMode(player);
        wait(1);
        while (player.isAlive() == false) {
            CheckGhostReturn(player);
            wait(0.1);
        }
    }
}

level BuyWhosWho(player) {
    if (player.getPoints() >= 4000) {
        if (!HasWhosWho(player)) {
            player givePerk("whos_who");
            player takePoints(4000);
            player iPrintLn("Vous avez acheté Who's Who pour 4000$");
        } else {
            player iPrintLn("Vous avez déjà la perk Who's Who.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Who's Who pour 4000$");
    wait(1);

    BuyWhosWho(player);
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onPlayerDeath = OnPlayerDeath;
}

main() {
    init();
}