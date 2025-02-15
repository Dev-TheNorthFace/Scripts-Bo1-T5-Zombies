initMathChallenge()
{
    level thread startMathChallenges();
}

startMathChallenges()
{
    for(;;)
    {
        wait 180;
        num1 = randomInt(10) + 1;
        num2 = randomInt(10) + 1;
        correctAnswer = num1 + num2;
        
        level.lastMathAnswer = correctAnswer;
        level notify("chat", "^3Problème Mathématique : " + num1 + " + " + num2 + " = ? (Répondez avec !reponse [votre réponse])");
    }
}

monitorMathAnswers()
{
    for(;;)
    {
        self waittill("say", message);
        
        if(message.startswith("!reponse "))
        {
            answer = int(message.substring(9));
            
            if(answer == level.lastMathAnswer)
            {
                self.score += 1000;
                self iPrintLnBold("^2Bonne réponse, Vous gagnez 1000$");
                level.lastMathAnswer = null;
            }
            else
            {
                self iPrintLnBold("^1Mauvaise réponse ! Essayez encore.");
            }
        }
    }
}