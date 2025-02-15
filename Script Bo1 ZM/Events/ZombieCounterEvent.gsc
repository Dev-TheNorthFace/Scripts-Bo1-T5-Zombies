displayZombieCount()
{
    self endon("disconnect");
    
    for(;;)
    {
        wait 1;
        zombieCount = getZombieCount();
        self iPrintLnBold("^1Zombie : " + zombieCount);
    }
}

getZombieCount()
{
    return level.zombie_count;s
}