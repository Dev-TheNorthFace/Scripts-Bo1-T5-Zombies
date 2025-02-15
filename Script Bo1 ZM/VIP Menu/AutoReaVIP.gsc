level VIPCheck(player) {
    if (isVIP(player)) {
        return true;
    } else {
        return false;
    }
}

level AutoRevive(player) {
    if (VIPCheck(player)) {
        if (player.getField("autoReviveUsed") == undefined || player.getField("autoReviveUsed") == false) {
            weapons = player getWeapons();
            perks = player getPerks();
            score = player getScore();
            player revive();
            player giveWeapons(weapons);
            player givePerks(perks);
            player setScore(score);
            player setField("autoReviveUsed", true);
            player iPrintLn("Vous avez utilisé votre auto-réanimation VIP et gardé vos armes et atouts");
        } else {
            player iPrintLn("Vous avez déjà utilisé votre auto-réanimation VIP.");
        }
    }
}

level OnPlayerDown(player) {
    if (VIPCheck(player)) {
        AutoRevive(player);
    }
}

init() {
    level.onPlayerDown = OnPlayerDown;
}

main() {
    init();
}