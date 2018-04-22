#include<iostream>
#include<stdlib.h>
#include<stdio.h>
#include"Game.h"
#include"User.h"
#include"Show_Players.h"
#include"AddGame.h"
#include"Play.h"

using namespace std;

int main()
{

User user_array[10];
for (int n=0; n<10; n++)
{
    user_array[n].AssignID(n+101);
}
user_array[0].Add_Existing_Game('C',34,1412);   //initializing some users
user_array[0].Add_Existing_Game('A',14,1630);
user_array[0].Add_Existing_Game('B',2,1080);
user_array[1].Add_Existing_Game('A',23,1570);
user_array[1].Add_Existing_Game('C',11,1708);
user_array[2].Add_Existing_Game('B',60,1886);


cout<<"Welcome to Gamers Database and Match Simulation\n\n";
char c;

while (1)                       //main program
{
    cout<<"Enter a function number\n";
    cout<<"1- Display users having the same game\n";
    cout<<"2- Simulate a match between two players\n";
    cout<<"3- Add a new game\n";
    cin>>c;
    switch (c)
    {
    case '1':
        Show_Players(user_array);
        break;
    case '2':
        Play(user_array);
        break;
    case '3':
        AddGame(user_array);
        break;
    default:
        cout<<c<<" is not a valid function number.\n";
    }

}
    return 0;
}
