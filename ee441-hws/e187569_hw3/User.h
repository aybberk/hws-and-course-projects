
#ifndef USER_H_INCLUDED
#define USER_H_INCLUDED
#include "Queue.h"

using namespace std;
void ResetTraversalStatus();


class User
{
private:

    char userID;

    int Weight_array[5];
    int wgt;
    int bsc;
    float ntw;
    int visited;


public:
///////////////////////////////////////////////////////////////////////////////////////////////
    User(char c='Z')        //user ID 'Z' ise böyle bir user yok demek
                            //dummy initialization
    {

        userID=c;
        wgt=0;        //weighted score
        bsc=0;      //basic score
        ntw=0;      //network score
        visited=0;
        mindist=999999;     //minimum distance to some other user, used in minDist function, initially 999999
        for (int n=0;n<5;n++)
        {
            Weight_array[n]=0;
            Link_array[n]=NULL;
        }


    }
///////////////////////////////////////////////////////////////////////////////////////////////
    User *Link_array[5];     int mindist;  //mindist used in traversal
///////////////////////////////////////////////////////////////////////////////////////////////
    int isVisited()
    {
        return visited;     //used in traversal
    }
///////////////////////////////////////////////////////////////////////////////////////////////
    void setVisited()
    {
        visited=1;          //used in traversal
    }
    void setUnvisited()
    {
        visited=0;
    }
///////////////////////////////////////////////////////////////////////////////////////////////

    void AssignID(char d)
    {
        userID=d;
    }

///////////////////////////////////////////////////////////////////////////////////////////////

    char GetID()
    {
        return userID;
    }
//////////////////////////////////////////////////////////////////////////////////////////////////
    void WonAgainst(User &loser)            //this user won against "loser"
                                        //adds losers address to fist null of link array and corresponding
    {                                        //weight array element is 1
        for(int n=0;n<5;n++)                //if it exists in link array
        {                                   //only increments corresponding weight array element
            if(Link_array[n]==NULL)
            {
                Link_array[n]=&loser;
                Weight_array[n]=1;
                break;
            }
            else if(Link_array[n]->GetID()==loser.GetID())
            {
                Weight_array[n]++;
                break;
            }

        }
    }
////////////////////////////////////////////////////////////////////
// Function for debugging
/*    void PrintLosers()
    {
        cout<<"User: "<<userID<<endl;
        cout<<"Losers: "<<endl;
        for(int n=0;n<5;n++)
        {
            if(Link_array[n]!=NULL)
            {
                cout<<Link_array[n]->GetID()<<"  "<<Weight_array[n]<<endl;
            }
        }
    }*/
/////////////////////////////////////////////////////////////////////
    int CalcBasicScore()  //calculates the sum of weight array
    {
        bsc=0;
        for (int n=0;n<5;n++)
        {
            if(Weight_array[n]!=NULL)
            bsc+=Weight_array[n];
        }
        return bsc;
    }

///////////////////////////////////////////////////////////////////////////
    int CalcWeightedScore()     //calculates the sum of (weight array* basic score of corresponding element of link array)
    {
        wgt=0;
        for (int n=0;n<5;n++)
        {
            if(Link_array[n] != NULL)
            {
                wgt=wgt+Weight_array[n]*(Link_array[n]->CalcBasicScore());
            }
        }
        return wgt;
    }
//////////////////////////////////////////////////////////////////////////7
    void SetNetworkScore(float network)
    {
        ntw=network;            //network score is calculated as a global function, and only set in user method
    }

//////////////////////////////////////////////////////////////////////////////////
};
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////







#endif
