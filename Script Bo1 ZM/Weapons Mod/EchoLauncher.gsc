init()
{
    level.echo_launcher_radius = 8;
    level.echo_launcher_knockback = 300;
    level.echo_launcher_stun_duration = 3;
    level.echo_launcher_fx = loadfx("fx/echo_wave");
    level.echo_launcher_stun_fx = loadfx("fx/echo_stun");
    level.echo_launcher_sound = "echo_launcher_fire";
    level.echo_launcher_stun_sound = "echo_stun_buzz";
    add_weapon_to_box();
}

add_weapon_to_box()
{
    level.weapons["echo_launcher"] = spawnEchoLauncher;
}

spawnEchoLauncher(player)
{
    player.has_echo_launcher = true;
    player.giveWeapon("echo_launcher");
    player iprintlnbold("Vous avez obtenu l'Echo Launcher");
    player thread echo_launcher_logic();
}

echo_launcher_logic()
{
    self endon("disconnect");

    while(self.has_echo_launcher)
    {
        if(self AttackButtonPressed())
        {
            self thread fire_echo_wave();
            wait(5);
        }
        wait(0.1);
    }
}

fire_echo_wave()
{
    start_origin = self getTagOrigin("j_gun");
    playfx(level.echo_launcher_fx, start_origin);
    self playsound(level.echo_launcher_sound);
    zombies = getEntArray("zombie", "classname");
    foreach(zombie in zombies)
    {
        if(distance(zombie.origin, start_origin) <= level.echo_launcher_radius)
        {
            dir = vectorNormalize(zombie.origin - start_origin);
            zombie.velocity = dir * level.echo_launcher_knockback;
            zombie playfx(level.echo_launcher_stun_fx);
            zombie playsound(level.echo_launcher_stun_sound);
            zombie.stunned = true;
            zombie freezeControls(true);
            wait(level.echo_launcher_stun_duration);
            zombie.freezeControls(false);
            zombie.stunned = false;
        }
    }
}