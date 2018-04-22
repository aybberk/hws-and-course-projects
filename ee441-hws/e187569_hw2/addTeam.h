#ifndef ADDTEAM_H_INCLUDED
#define ADDTEAM_H_INCLUDED
#include <iostream>
#include "okuyaz.h"
#include "team.h"
#include "User.h"

void addTeam(User u, bool &turn, Team &t1, Team &t2)
{   //Adds the input player to the team which has the turn to get a player.
    if (turn==1)
    {
        t1.AddMember(u);
        //cout<<"User "<<u.GetID()<<","<<u.GetScore()<<" is added to Team "<<t1.getID()<<"!!!!!!!!!!!!!!!!!!"<<endl;
    }
    else
        {
        t2.AddMember(u);
        //cout<<"User "<<u.GetID()<<","<<u.GetScore()<<" is added to Team "<<t2.getID()<<"!!!!!!!!!!!!!!!!!!"<<endl;

    }
    turn=!turn;
}




#endif // ADDTEAM_H_INCLUDED
