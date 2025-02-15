init()
{
    self setClientDvar( "ui_hud_hardcore", 1 );
    
    level.box_position = (Vector(0, 0, 0));
    level.box_weapon = "";
    level.box_entity = spawnEntity(level.box_position, "weapon_box_entity");
    
    level box_weapon_logic();
}

box_weapon_logic()
{
    while (true)
    {
        box_zone = getBoxTriggerZone();

        if (isPlayerOpeningBox())
        {
            if (isKnifeAttack())
            {
                playKnifeHitEffect(self);
                
                allowOtherPlayersToTakeWeapon();
            }
        }
        
        wait(0.1);
    }
}

isKnifeAttack()
{
    if (self getCurrentWeapon() == "knife")
    {
        return true;
    }
    return false;
}

allowOtherPlayersToTakeWeapon()
{
    players = getAllPlayers();
    foreach (player in players)
    {
        if (isPlayerNearBox(player))
        {
            player giveWeapon(level.box_weapon);
            break;
        }
    }
}

isPlayerNearBox(player)
{
    if (player getDistance(level.box_position) < 100)
    {
        return true;
    }
    return false;
}

getAllPlayers()
{
    return level.players;
}

getBoxTriggerZone()
{
    return level.box_zone;
}