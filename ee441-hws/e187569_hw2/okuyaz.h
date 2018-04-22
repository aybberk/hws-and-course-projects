#ifndef OKUYAZ_H_INCLUDED
#define OKUYAZ_H_INCLUDED
#include <fstream>
#include "User.h"
#include "Team.h"
#include "Queue.h"
#include <stdlib.h>
using namespace std;
int oku(char a[],User *userlist)
{
//Reads "a" file and prints the users in file to the userlist.
    ifstream inputtxt;
    inputtxt.open(a);
    char output[100];
    int kacakac;
    int ctr=-1;
    char *endp;
    if (inputtxt.is_open())
    {

        while (!inputtxt.eof())
        {
            inputtxt >> output;
            if (ctr==-1)
            {
                long n = strtol(output,NULL,10);
                kacakac=n;
                ctr++;
            }
            else
            {
                long int score=strtol(output,&endp,10);
                long int id=strtol(endp+1,NULL,10);
                userlist[ctr].AssignID(id);
                userlist[ctr].SetScore(score);
                ctr++;
            }
        }
    }

    inputtxt.close();
    return kacakac;
}

int kacSatir(char a[])
{
//Reads "a" file and returns the files' row count.
    ifstream inputtxt;
    inputtxt.open(a);
    int ctr=0;
    char dummy[100];
    if (inputtxt.is_open())
    {

        while (!inputtxt.eof())
        {
                inputtxt >> dummy;
                ctr++;
        }

    }

    inputtxt.close();
    return ctr;
}

void yaz(Team team1, Team team2, Queue waiting)
{ //Prints team and queue info to out.txt.
ofstream outputtxt;
outputtxt.open("out.txt");
team1.printTeamInfo(outputtxt);
team2.printTeamInfo(outputtxt);
waiting.printQueueInfo(outputtxt);
outputtxt.close();
}
#endif // OKUYAZ_H_INCLUDED
