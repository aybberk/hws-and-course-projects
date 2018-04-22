#ifndef SIRADANYERLESTIR_H_INCLUDED
#define SIRADANYERLESTIR_H_INCLUDED

bool siradanYerlestir(Queue &waiting, Team &team1, Team &team2, bool &turn)
{ //Tries to place a player from the waiting line to the team which has the turn to get a player without changing the order of queue.
    //If it can, returns 1, else returns 0.
    int ctr=waiting.GetCurrentSize();
    while(ctr)
    {
    if(isApplicable(waiting.LookFront(), team1, team2, turn))
       {
           addTeam(waiting.Delete(), turn, team1, team2);
           break;
       }
       else
        {
            waiting.Insert(waiting.Delete());
            ctr--;
        }
    }
    if (ctr==0)
    {
        //waiting.printQueueInfo();
        return 0;
    }
    for (int n=1;n<ctr;n++)
    {
        waiting.Insert(waiting.Delete());
    }
        //waiting.printQueueInfo();
    return 1;
}

#endif // SIRADANYERLESTIR_H_INCLUDED
