using namespace std;



class Game
{
private:
    int score, xp;
    char gameID;
public:
    Game()          //Game class have members score,xp and ID
    {               //actually, score and xp are user's score and xp
        score=1200; // but these games are not actual games
        xp=0;       // They are users' games so the score and xp actually belong to the user
        gameID='N';
    }
    void SetID(char n)   // sets game id
    {
        gameID=n;
    }
    void SetScore(int d)   // sets game score
    {
        score=d;
    }
    void SetExperience(int d)   //sets game experience
    {
        xp=d;
    }
    char GetID()            //gets id
    {
        return gameID;
    }
    int GetScore()             //gets score
    {
        return score;
    }
    int GetExperience()          //gets xp
    {
        return xp;
    }
    bool isNull()                //checks if the game is null
    {
        return (gameID=='N');

    }
};
