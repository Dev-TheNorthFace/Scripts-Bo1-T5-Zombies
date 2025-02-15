auto_messages = [
    "Rejoindre le serveur Discord : https://discord.gg/votre-lien",
    "Payer un grade VIP : https://votre-site-paiement.com",
    "Le serveur redémarre à minuit."
];

init()
{
    thread sendAutoMessages();
}

sendAutoMessages()
{
    for(;;)
    {
        wait 300;
        
        message = auto_messages[randomInt(0, size(auto_messages) - 1)];
        
        level notify("chat", "^2[INFO] ^7" + message);
    }
}