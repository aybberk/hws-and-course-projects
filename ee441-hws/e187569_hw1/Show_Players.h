void Show_Players(User *p_user)        // take the user input for game id shows the players
{                                       // who have that game with their score and xp
    char gameid;
    string gameids;
    cout<<"Enter a valid game ID (Example games are A, B, C)"<<endl;
    cout<<"Enter ESC to return function selection"<<endl;
    cin>>gameids;
    if (gameids=="ESC"||gameids=="esc"||gameids=="Esc")
        return;
    else
        gameid=gameids[0];
    if (gameid=='1'||gameid=='2'||gameid=='3'||gameid=='4'||gameid=='5'||gameid=='6'||gameid=='7'||gameid=='8'||gameid=='9'||gameid=='0'||gameid=='N')
    {
        cout<<gameid<<" is not a valid game ID.\n";
        return;
        }
        int counter=0;
    cout<<"Game "<<gameid<<endl<<"User ID\t\tExperience\tScore"<<endl;
    for(int n=0;n<10;n++)
    {
        if (p_user[n].Check_Game(gameid))
        {
            cout<<p_user[n].GetID()<<"\t\t"<<p_user[n].Get_Game_Experience(gameid)<<"\t\t"<<p_user[n].Get_Game_Score(gameid)<<endl;
            counter++;
        }
    }
    cout<<"Number of users is "<<counter<<"\n\n";
}

int randomsayi()        //creates a random number between 1-100
{
    return rand()%100+1;
}
