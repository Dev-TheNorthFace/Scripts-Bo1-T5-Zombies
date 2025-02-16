special_weapons = ["weapon_raygun", "weapon_thundergun", "weapon_wunderwaffe"];

manage_special_weapon()
{
    current_special_weapon = get_current_special_weapon();
    if(current_special_weapon != "")
    {
        self takeWeapon(current_special_weapon);
    }

    new_special_weapon = get_random_special_weapon();
    self giveWeapon(new_special_weapon);
    self iPrintLn("Tu as échangé ton arme spéciale pour: " + new_special_weapon);
}

get_current_special_weapon()
{
    for(i = 0; i < special_weapons.size; i++)
    {
        if(self hasWeapon(special_weapons[i]))
        {
            return special_weapons[i];
        }
    }
    return "";
}

get_random_special_weapon()
{
    random_index = randomInt(special_weapons.size);
    return special_weapons[random_index];
}

on_box_pickup()
{
    manage_special_weapon();
}

main()
{
    level notifyOnPlayerPickupWeapon("on_box_pickup");
    manage_special_weapon();
}