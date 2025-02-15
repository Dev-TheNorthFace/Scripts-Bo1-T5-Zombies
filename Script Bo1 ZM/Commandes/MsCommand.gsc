function show_ms(player)
{
    player_ms = player getPing();
    
    player iprintln("^7Votre latence est de: ^2" + player_ms + "^7 ms.");
}

function player_command(player, cmd, args)
{
    if (cmd == "!ms")
    {
        show_ms(player);
    }
}

level.onPlayerCommand = player_command;