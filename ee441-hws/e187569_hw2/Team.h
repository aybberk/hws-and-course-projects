#ifndef TEAM_H_INCLUDED
#define TEAM_H_INCLUDED
#include "User.h"
class Team
{
private:
    User *teamList;
    int currentSize;
    int teamID;

public:
    Team(int teamsize, int tID)
    {
        teamID=tID;
        currentSize=0;
        teamList=new User[teamsize];
    }
    ~Team()
    {
        delete[] teamList;
    }

///////////////////////////////////////////////////////////////////////////////////////////////

    int getID()
    {
        return teamID;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    float GetAverage()
    {
        if (currentSize==0)
        return 1500;
        else
        {
            int sum=0;
            for(int temp=currentSize; temp>0; temp--)
            {
                sum=sum+teamList[temp-1].GetScore();
            }
            float csize=currentSize*1.0;
            float avg=sum/csize;
            return avg;
        }
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    void AddMember(User a)
    {
        teamList[currentSize++]=a;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    int getCurrentSize()
    {
        return currentSize;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    void printTeamInfo(ofstream &outputtxt)
    {
        outputtxt<<"Team "<<teamID<<endl;
        outputtxt<<"Size: "<<currentSize<<endl;
        for (User *n=teamList;n<teamList+currentSize;n++)
        {
            outputtxt<<"User ID:"<<(*n).GetID()<<"  Score:"<<(*n).GetScore()<<endl;
        }
        outputtxt<<"Average score: "<<GetAverage()<<endl<<endl;

    }
};


#endif //
