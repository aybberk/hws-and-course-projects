void AddGame(User *p_user)    //adds game tu user from console
{                                 //p_user pointer is needed to make changes with users of user array
    int id;
    char gameid;
    cout<<"User ID:";
    cin>>id;

    cout<<"Game ID:";
    cin>>gameid;

        if (gameid=='1'||gameid=='2'||gameid=='3'||gameid=='4'||gameid=='5'||gameid=='6'||gameid=='7'||gameid=='8'||gameid=='9'||gameid=='0'||gameid=='N')
    {
        cout<<gameid<<" is not a valid game ID.\n";
        return;
        }

    for (int n=0;n<10;n++)
    {
        if (p_user[n].GetID()==id)
        {
            bool success=p_user[n].Add_Game(gameid);
            if (success)
            cout<<"Game "<<gameid<<" has beed added to User "<<id<<".\n\n";
            return;
        }

    }
    cerr<<"No such user exists."<<endl;   //if there is no user with that id, prints error msg
}
