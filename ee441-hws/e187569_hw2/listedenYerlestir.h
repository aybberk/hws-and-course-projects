#ifndef LISTEDENYERLESTIR_H_INCLUDED
#define LISTEDENYERLESTIR_H_INCLUDED

bool listedenYerlestir(Queue &liste, Queue &waiting, Team &team1, Team &team2, bool &turn)
{   //Tries to place a player from the list(dummy queue) to the team which has the turn to get a player
        //If it can, returns 1, else returns 0.
    while(liste.GetCurrentSize()!=0)
    {
        if (isApplicable(liste.LookFront(),team1, team2, turn))
        {
            addTeam(liste.Delete(), turn, team1, team2);
            return 1;
        }
        else waiting.Insert(liste.Delete());
    }
    return 0;
}


#endif // LISTEDENYERLESTIR_H_INCLUDED
