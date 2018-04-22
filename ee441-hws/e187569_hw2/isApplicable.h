#ifndef ISAPPLICABLE_H_INCLUDED
#define ISAPPLICABLE_H_INCLUDED
#include "team.h"
#include "User.h"
bool isApplicable(User u,Team t1,Team t2, bool turn)
{  //Applicable if team(1 if turn=1, 2 if turn=0) fits the score constraints.
    float boldavg=(t1.GetAverage()+t2.GetAverage())/2;

    if (turn==1)
    {
        if((u.GetScore()>boldavg&&t1.GetAverage()<boldavg)||(u.GetScore()<boldavg&&t1.GetAverage()>boldavg)||(t1.GetAverage()==boldavg))
        {
        //    cout<<"User "<<u.GetID()<<","<<u.GetScore()<<" is applicable for Team 1"<<endl;
            return 1;
        }
        else
        {
        //    cout<<"User "<<u.GetID()<<","<<u.GetScore()<<" is not applicable for Team 1"<<endl;
            return 0;
        }
    }
    else
    {
        if((u.GetScore()>boldavg&&t2.GetAverage()<boldavg)||(u.GetScore()<boldavg&&t2.GetAverage()>boldavg)||(t2.GetAverage()==boldavg))
        {
        //    cout<<"User "<<u.GetID()<<","<<u.GetScore()<<" is applicable for Team 2"<<endl;
            return 1;
        }
        else
        {
        //    cout<<"User "<<u.GetID()<<","<<u.GetScore()<<" is not applicable for Team 2"<<endl;
            return 0;
        }
    }
}

#endif // ISAPPLICABLE_H_INCLUDED
