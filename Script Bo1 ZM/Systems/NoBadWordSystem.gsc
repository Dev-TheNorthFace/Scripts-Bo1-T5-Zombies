restricted_words = [
    "asshole", "bitch", "bastard", "faggot", "cunt", "nigger", "slut", "whore", 
    "fuck", "shit", "bastard", "motherfucker", "cock", "pussy", "dick", "twat", "retard"
];

function contains_bad_word(message)
{
    for (i = 0; i < sizeof(restricted_words); i++)
    {
        if (i != undefined && strstr(message, restricted_words[i]) != -1)
        {
            return true;
        }
    }
    return false;
}

function on_player_chat(player, message)
{
    if (contains_bad_word(message))
    {
        player iprintln("^1[Erreur] ^7Votre message a été supprimé car il contenait un mot inapproprié.");
        
        player setClientDvar("cl_chat_input", "");
        
        level notifyAdmins("^1[ChatMod] ^7Le joueur ^3" + player.name + "^7 a utilisé un mot interdit dans le chat.");
    }
    else
    {
        iprintln("^7[Chat] " + player.name + ": ^3" + message);
    }
}

level onPlayerChat = on_player_chat;