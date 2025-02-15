init()
{
    self enable_unlimited_perks();
}

enable_unlimited_perks()
{
    level.perks_max = 999;
    self onPerkTaken();
}

onPerkTaken()
{
    self setperk_limit(999);
}

init();