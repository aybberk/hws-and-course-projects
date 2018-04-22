/***************************\
|   EE441 Data Structures   |
|   HW #3                   |
|   Ayberk Aydın-1875699    |
\***************************/


#include <iostream>
#include "Queue.h"
#include "User.h"
#include "globalfuncs.h"
#include "oku.h"

using namespace std;

int main()
{

    User User_array[20];   //user array with max possible size
    const int textsize=10000; // max possible input text character count
    char textwithoutspaces[textsize];
    for (int n=0;n<textsize;n++)
      {
         textwithoutspaces[n]='Z';
      }
    oku("in.txt",textwithoutspaces);    //converting in.txt to spaceless char array

//    cout<<textwithoutspaces<<endl;   //for debugging

    int i=0;
    for (int n=0;n<1000;n++)
    {
                //ilk elemanı ve virgulden sonraki her elemanı user olarak ata
        if(n==0 || textwithoutspaces[n-1]==',')
        {
            User_array[i++].AssignID(textwithoutspaces[n]);

        }
    }
    int userCount=i;

//    for (int n=0;n<20;n++)
//    {
//        cout<<User_array[n].GetID();
//    }
//    cout<<endl;                           //for debugging

    int winner=0;
    int loser=0;
    for (int n=2;n<textsize;n+=2)
    {
        if(textwithoutspaces[n-1] != ',' && textwithoutspaces[n-1] != 'Z')
        {           //userları atadıktan sonra son virgulden sonraki 1. eleman 2. elemanı yendi
                                                                    //3. eleman 4. elemanı yendi
                                                                    //5. eleman 6. elamanı yendi etcetc
            for(int i=0;i<20;i++)
            {
                if(User_array[i].GetID()==textwithoutspaces[n-1])
                    winner=i;
                if(User_array[i].GetID()==textwithoutspaces[n])
                    loser=i;
            }
            User_array[winner].WonAgainst(User_array[loser]);
 //           cout<<"User "<<User_array[winner].GetID()<<" won against User "<<User_array[loser].GetID()<<endl;  //for debugging
        }
    }


    int operation;
    char id_array[20];
    cout<<"Welcome to Gamers Database\n";
    while(true)
    {
        cout<<"Choose an option to perform;\n1-Calculate Basic Score\n2-Calculate Weighted Score\n3-Calculate Network Score\n";
        cin>>operation;
        switch (operation)
        {


    case 1:    //Basic score

                int basic_score_array[20];

                for (int n=0;n<userCount;n++)
                {
                    id_array[n]=User_array[n].GetID();
                    basic_score_array[n]=User_array[n].CalcBasicScore();
                }
                  //basic scores and user ID's are stored in 2 arrays

                quickSort(basic_score_array,id_array,0,userCount-1); //quicksort basic score array and align with ID array
                invert(basic_score_array,userCount);   //yanlıslıkla kucukten buyuge sıraladım o yüzden invert ediyorum :)
                invert(id_array, userCount);
                for(int n=0;n<userCount;n++)
                    cout<<id_array[n]<<"("<<basic_score_array[n]<<")\n";  //yazdırma

                break;

    case 2:     //Weighted score

                int weighted_score_array[20];

                for (int n=0;n<userCount;n++)
                {
                    id_array[n]=User_array[n].GetID();
                    weighted_score_array[n]=User_array[n].CalcWeightedScore();
                }       //weighted scores and user ID's are stored in 2 arrays

                quickSort(weighted_score_array,id_array,0,userCount-1);  //quicksort weighted score array and align with ID array
                invert(weighted_score_array,userCount);
                invert(id_array, userCount);

                for(int n=0;n<userCount;n++)
                    cout<<id_array[n]<<"("<<weighted_score_array[n]<<")\n";
                                                            //yazdirma
                break;

    case 3:     //Network_score

                float network_score_array[20];

                for (int n=0;n<userCount;n++)
                {
                    id_array[n]=User_array[n].GetID();
                    network_score_array[n]=CalcNetworkScore(User_array+n, User_array, userCount);
                }         //network scores and user ID's are stored in 2 arrays

                quickSort(network_score_array,id_array,0,userCount-1);  //quicksort network score array and align with ID array
                invert(network_score_array,userCount);
                invert(id_array, userCount);

                for(int n=0;n<userCount;n++)
                    cout<<id_array[n]<<"("<<network_score_array[n]<<")\n";
                                                                //yazdirma
                break;


        }




    }
//    for(int n=0;n<20;n++)
//    {
//        if(User_array[n].GetID()!='Z')
//        {
//            User_array[n].PrintLosers();
//            cout<<"Basic Score: "<<User_array[n].CalcBasicScore()<<endl<<"Weighted Score: "<<User_array[n].CalcWeightedScore()<<endl<<endl;
//        }
//    }
                    /*for debugging*/
//        for (int from=0;from<userCount;from++)
//        {
//            for (int to=0;to<userCount;to++)
//            {
//                ResetTraversalStatus(User_array);
//                cout<<"min dist from "<<User_array[from].GetID()<<" to "<<User_array[to].GetID()<<" is "<<minDist(User_array+from,User_array+to)<<endl;
//            }
//        }
                    /*for debugging*/



   return 0;
}
