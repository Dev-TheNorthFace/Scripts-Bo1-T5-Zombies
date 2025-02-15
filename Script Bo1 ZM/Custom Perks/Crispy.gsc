level HasCrispy(player) {
    if (player hasPerk("crispy")) {
        return true;
    }
    return false;
}

level ApplyCrispyEffect(player) {
    if (HasCrispy(player)) {
        player onZombieDeath( function(zombie) {
            vector zombiePosition = zombie.origin;
            zombies = GetNearbyZombies(zombiePosition, 10);

            foreach (zombie in zombies) {
                zombie takeDamage(50);
                zombie iPrintLn("Zombie brûlé par l'effet Crispy !");
            }
            spawnFx("crispy_burn_fx", zombiePosition);
            player playSoundAtPos("crispy_burn_sound", zombiePosition);
            player iPrintLn("Les zombies proches sont brûlés !");
        });
    }
}

level BuyCrispy(player) {
    if (player.getPoints() >= 4000) {
        if (!HasCrispy(player)) {
            player givePerk("crispy");
            player takePoints(4000);
            player iPrintLn("Vous avez acheté Crispy pour 4000$ !");
        } else {
            player iPrintLn("Vous avez déjà la perk Crispy.");
        }
    } else {
        player iPrintLn("Vous n'avez pas assez de points pour acheter cette perk.");
    }
}

level OnPerkMachineInteraction(player) {
    player iPrintLn("Achetez Crispy pour 4000$ !");
    wait(1);
    BuyCrispy(player);
}

level CheckZombieDeath(player) {
    if (HasCrispy(player)) {
        ApplyCrispyEffect(player);
    }
}

init() {
    level.onPerkMachineInteraction = OnPerkMachineInteraction;
    level.onPlayerUpdate = function(player) {
        if (HasCrispy(player)) {
            CheckZombieDeath(player);
        }
    };
}

main() {
    init();
}