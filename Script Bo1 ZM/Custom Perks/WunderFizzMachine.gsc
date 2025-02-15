main()
{
    level.wunderfizz_cost = 5000;
    level.available_perks = [
        "juggernog", 
        "speed_cola", 
        "quick_revive", 
        "double_tap",
        "stamin_up",
        "deadshot_daiquiri",
        "mule_kick",
        "phd_flopper",
        "electric_cherry",
        "death_perception"
    ];

    wait 1;
    thread setup_wunderfizz();
}

setup_wunderfizz()
{
    wunderfizz = Spawn("script_model", (250, 400, 50));
    wunderfizz SetModel("zombie_vending_wunderfizz");
    wunderfizz.angles = (0, 90, 0);
    thread electric_effect(wunderfizz);
    thread blinking_light(wunderfizz);
    trigger = Spawn("trigger_use", wunderfizz.origin);
    trigger SetBounds((-32, -32, 0), (32, 32, 80));
    trigger SetHintString("Appuyez sur ^3[F]^7 pour utiliser Wunderfizz [^2$1500^7]");
    trigger SetCursorHint("HINT_NOICON");

    while(1)
    {
        trigger waittill("trigger", player);
        
        if(player GetPoints() >= level.wunderfizz_cost)
        {
            player SetPoints(player GetPoints() - level.wunderfizz_cost);
            player PlaySound("electric_zap");
            thread shake_machine(wunderfizz);
            thread give_random_perk(player);
        }
        else
        {
            player iPrintLnBold("Pas assez de points");
        }
        
        wait 0.5;
    }
}

electric_effect(machine)
{
    machine endon("stop_effect");

    while(1)
    {
        wait RandomFloat(5);
        machine PlayFX("electric_fx", machine.origin + (RandomFloatRange(-10,10), RandomFloatRange(-10,10), 40));
        wait 0.2;
    }
}

blinking_light(machine)
{
    machine endon("stop_effect");

    while(1)
    {
        machine ShowLight();
        wait RandomFloatRange(0.3, 1.2);
        machine HideLight();
        wait RandomFloatRange(0.2, 0.8);
    }
}

shake_machine(machine)
{
    machine MoveX(5, 0.1);
    wait 0.1;
    machine MoveX(-5, 0.1);
    wait 0.1;
    machine MoveY(5, 0.1);
    wait 0.1;
    machine MoveY(-5, 0.1);
}

give_random_perk(player)
{
    player endon("disconnect");
    random_index = RandomInt(level.available_perks.size);
    perk = level.available_perks[random_index];
    if(player HasPerk(perk))
    {
        player iPrintLnBold("Vous avez déjà cet atout");
        return;
    }

    thread perk_animation(player, perk);

    wait 2.5;

    player GivePerk(perk);
    player iPrintLnBold("Vous avez obtenu ^2" + perk + "^7");
    player PlaySound("zmb_perk_bottle");
    thread update_perk_hud(player);
}

update_perk_hud(player)
{
    player endon("disconnect");

    if(player.perk_hud)
    {
        player.perk_hud Destroy();
    }

    player.perk_hud = NewHudElem();
    player.perk_hud.alignX = "left";
    player.perk_hud.alignY = "top";
    player.perk_hud.x = 50;
    player.perk_hud.y = 50;
    player.perk_hud.fontScale = 1.5;
    player.perk_hud SetText("Atouts :");

    y_offset = 70;

    foreach(perk in level.available_perks)
    {
        if(player HasPerk(perk))
        {
            icon = NewHudElem();
            icon.alignX = "left";
            icon.alignY = "top";
            icon.x = 50;
            icon.y = y_offset;
            icon SetShader(perk + "_icon", 32, 32);
            y_offset += 40;
        }
    }
}

perk_animation(player, perk)
{
    model = Spawn("script_model", player.origin + (0, 0, 50));
    model SetModel("zombie_perk_bottle");

    time = 2.5;
    rotate_speed = 360 / time;

    while(time > 0)
    {
        model RotateYaw(rotate_speed * 0.1);
        wait 0.1;
        time -= 0.1;
    }

    model Delete();
}