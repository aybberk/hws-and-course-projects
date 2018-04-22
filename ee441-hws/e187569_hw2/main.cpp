
/***************************\
|   EE441 Data Structures   |
|   HW #2                   |
|   Ayberk Aydın-1875699    |
\***************************/

#include <iostream>
#include <string>
#include <string.h>
#include "okuyaz.h"
#include "Team.h"
#include "User.h"
#include "Queue.h"
#include "isApplicable.h"
#include "addTeam.h"
#include "listedenYerlestir.h"
#include "isDone.h"
#include "siradanYerlestir.h"

using namespace std;

int main()
{
/*initialize objects and variables*/

User *userlist;
int kackisi;
int kacsatir=kacSatir("in.txt");
kackisi=kacsatir-1; //How many people will be considered for matchmaking

userlist=new User[kackisi]; //Allocate memory for users
int kacakac=oku("in.txt",userlist); // Teams size is determined from first line
Queue liste(kackisi);
Queue waiting(kackisi);
for (int n=0;n<kackisi;n++)
{   //First, get all users in a dummy queue and get rid of input text file//
    liste.Insert(userlist[n]);
}
delete userlist; //Deallocate the memory
Team team1(kacakac,1);
Team team2(kacakac,2);
bool turn=1;
/*end of initialization of objects and variables*/


//This loop tries to get users from the queue to the team, if possible.
//If it can not, it tries from the list. If it still can't place or the teams are full, the loop ends.
while(1)
{
    if(siradanYerlestir(&waiting, &team1, &team2, &turn))
    {
        if(isDone(&team1, &team2, &kacakac))
        {
            break;
        }
        else continue;
    }
    else if(listedenYerlestir(&liste, &waiting, &team1, &team2, &turn))
    {
        if(isDone(&team1, &team2, &kacakac))
        {
            break;
        }
        else continue;
    }
        else break;
}

yaz(team1, team2, waiting);  //Printing the info to the out.txt

return 0;

}
