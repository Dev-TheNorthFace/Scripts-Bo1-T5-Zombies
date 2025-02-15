level VIPCheck() {
    if (isVIP(self)) {
        self giveWeapon("mustang_sally");
        self giveWeapon("mustang_sally");
        self playSound("zmb_zombie_weapon_pickup");
    }
    else {
    }
}

init() {
    VIPCheck();
}

main() {
    init();
}