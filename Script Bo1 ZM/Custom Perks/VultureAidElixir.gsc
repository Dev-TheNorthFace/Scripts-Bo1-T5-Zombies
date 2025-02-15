level HasVultureAid(player) {
    if (player hasPerk("vulture_aid")) {
        return true;
    }
    return false;
}

level SpawnVultureAidBonuses(player, zombie) {
    if (HasVultureAid(player)) {
        pos = zombie getOrigin();
        offset = vector(0, 0, 50);
        spawn_pos = pos + offset + vector(random() * 10, random() * 10, random() * 10);
        randomBonus = randomInt(1, 4);

        switch (randomBonus) {
            case 1:
                player giveAmmo(100);
                zombie iPrintLn("Débris : Munitions récupérées !");
                break;
            case 2:
                player givePoints(500);
                zombie iPrintLn("Débris : 500 points récupérés !");
                break;
            case 3:
                player giveGrenades(1);
                zombie iPrintLn("Débris : Grenades récupérées !");
                break;
        }

        level.fx("vulture_aid_debris", spawn_pos);
        level.playSoundAtPosition("vulture_aid_sound", spawn_pos);
    }
}

level BuyVultureAid(player) {
    if (player.getPoints() >= 5000) {
        if (!HasVultureAid(player)) {
            player givePerk("vulture_aid");
            player takePoints(5000);
            player iPrintLn("Vous avez acheté Vulture Aid Elixir pour 5000$ !");
            ApplyVultureAidEffect(player);
        } else {
            player iPrintLn("Vous avez déjà la perk Vulture Aid Elixir.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level ApplyVultureAidEffect(player) {
    player iPrintLn("Vulture Aid Elixir est activé ! Les zombies laissent des débris !");
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Vulture Aid Elixir pour 5000$");

    wait(1);
    BuyVultureAid(player);
}

level OnZombieKill(player, zombie) {
    if (HasVultureAid(player)) {
        SpawnVultureAidBonuses(player, zombie);
    }
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onZombieKill = OnZombieKill;
}

main() {
    init();
}