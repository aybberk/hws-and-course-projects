using namespace std;



class User
{
private:                        //User class have members userId, manyGames and Game array
    int userID;
    int manyGames;
    Game Game_Array[5];
public:

    User()
    {
        Game Game_Array[5];
        manyGames=0;
        userID=100;
    }

    void Set_Game_Experience(char c,int xp)   //sets user's experience of game c to xp.
    {
        for(int n=0;n<5;n++)
        {
            if(c==Game_Array[n].GetID())
            {
                Game_Array[n].SetExperience(xp);
                return;
            }
        }                                       //if the user doesn't have game c, prints error msg.
        cerr<<"User "<<GetID()<<"does not have Game "<<c<<"."<<endl;
    }

    void Set_Game_Score(char c,int score)       //sets user's score of game c to score.
    {
        for(int n=0;n<5;n++)
        {
            if(c==Game_Array[n].GetID())
            {
                Game_Array[n].SetScore(score);
                return;
            }
        }                                   //if the user doesn't have game c, prints error msg.
        cerr<<"User "<<GetID()<<"does not have Game "<<c<<"."<<endl;
    }

    bool Add_Game(char game)                //Fills the user's first empty slot with "game"
    {
        if (Check_Game(game))
        {
            cerr<<"User "<<userID<<" already have Game "<<game<<endl;
            return 0;                       //If user has the game, prints error msg.
        }
        for (int n=0;n<5;n++)
        {
            if (Game_Array[n].isNull()==1)
            {
                Game_Array[n].SetID(game);
                return 1;
            }

        }

            cerr<<"User's capacity is full"<<endl;
            return 0;                       //If user's capacity is full, prints error msg.
    }

    void Add_Existing_Game(char id, int xp, int score)   //initializing game adding function for coder
    {
        for(int n=0;n<5;n++)
        {
            if (Game_Array[n].isNull()==1)
            {
                Game_Array[n].SetID(id);
                Game_Array[n].SetExperience(xp);
                Game_Array[n].SetScore(score);
                return;
            }
        }
        cerr<<"User's capacity is full."<<endl;
    }
    void AssignID(int d)        //assigns an id to user
    {
        userID=d;
    }
    int GetID()              //gets id of the user
    {
        return userID;
    }
    int Get_Game_Score(char c)   //gets the score of game c of the user
    {

        for(int n=0;n<5;n++)
        {
            if(c==Game_Array[n].GetID())
            {
                return Game_Array[n].GetScore();
            }
        }
        cerr<<"User "<<GetID()<<"does not have Game "<<c<<"."<<endl;
        return -1;                 //if the user doesnt have the game, prints error msg and returns -1
    }

    int Get_Game_Experience(char c)    //gets the score of game c of the user
    {
        for(int n=0;n<5;n++)
        {
            if(c==Game_Array[n].GetID())
            {
                return Game_Array[n].GetExperience();
            }
        }
        cerr<<"User "<<GetID()<<"does not have Game "<<c<<"."<<endl;
        return -1;       //if the user doesnt have the game, prints error msg and returns -1
    }

    bool Check_Game(char gameid)  //checks the game if it exists at user's slot
    {
        for (int n=0;n<5;n++)
        {
            if (gameid==Game_Array[n].GetID())
                return 1;

        }
        return 0;
    }

};
