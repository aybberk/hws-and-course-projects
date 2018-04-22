
void Play(User *p_user)       //simulates a match between two users and updates the scores
{
    int userid1,userid2;
    char gameid;
    cout<<"Enter first user ID\n(Enter Q to return function selection)\n";
    cin>>userid1;
    if (userid1=='Q')
        return;
    cout<<"Enter second user ID\n(Enter Q to return function selection)\n";
    cin>>userid2;
    if (userid2=='Q')
        return;
    cout<<"Enter a valid game ID (Example games are A, B, C)\n(Enter Q to return function selection)\n";
    cin>>gameid;
    if  (gameid=='Q')
        return;
            if (gameid=='1'||gameid=='2'||gameid=='3'||gameid=='4'||gameid=='5'||gameid=='6'||gameid=='7'||gameid=='8'||gameid=='9'||gameid=='0'||gameid=='N')
    {
        cout<<gameid<<" is not a valid game ID.\n";
        return;
        }
    if(p_user[userid1-101].Check_Game(gameid)==0)
    {
        cout<<"User "<<userid1<<" does not have game "<<gameid<<endl;
        return;
    }
    if(p_user[userid2-101].Check_Game(gameid)==0)
    {
        cout<<"User "<<userid2<<" does not have game "<<gameid<<endl;
        return;
    }

    int score1=p_user[userid1-101].Get_Game_Score(gameid);    //current scores
    int score2=p_user[userid2-101].Get_Game_Score(gameid);
    int newscore1,newscore2;
    double prob1=(((score1-score2)/1000.0*0.8)+1.0)/2.0;       //probabilities percent
    double prob2=1-prob1;
    int r=randomsayi();
    cout<<r<<endl;
    prob1=prob1*100;
    prob2=prob2*100;
    cout<<"Chance of user "<<userid1<<" is "<<prob1<<"%\n";
    cout<<"Chance of user "<<userid2<<" is "<<prob2<<"%\n";
    cout<<"Press a key to start!";
    getchar();
    getchar();
    if (prob1>r)                               //user 1 has won if prob1>r
    {
        cout<<"User "<<userid1<<" has won!\n\n";
        newscore1=score1+(2000-score1)/1000.0*(score2-1000)*0.2;
        newscore2=score2-(2000-score1)/1000.0*(score2-1000)*0.2;
    }
    else                                        //user 2 has won if prob1<=r
    {
        cout<<"User "<<userid2<<" has won!\n";
        newscore1=score1-(2000-score2)/1000.0*(score1-1000)*0.2;
        newscore2=score2+(2000-score2)/1000.0*(score1-1000)*0.2;

    }
    p_user[userid1-101].Set_Game_Experience(gameid,p_user[userid1-101].Get_Game_Experience(gameid)+1); //exp updates
    p_user[userid2-101].Set_Game_Experience(gameid,p_user[userid2-101].Get_Game_Experience(gameid)+1);
    p_user[userid1-101].Set_Game_Score(gameid,newscore1);           //score updates
    p_user[userid2-101].Set_Game_Score(gameid,newscore2);

    cout<<"New score of user "<<userid1<<" is "<<newscore1<<".\n";
    cout<<"New score of user "<<userid2<<" is "<<newscore2<<".\n";

    return;

}

