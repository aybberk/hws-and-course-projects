#ifndef Queue_H_INCLUDED
#define Queue_H_INCLUDED
#include "User.h"
#include <string>
#include <string.h>
class Queue
{
private:
    User *qList;  //ilk(potansiyel) kisinin adresi
    User *qEnd;
    int currentSize;   //son kisinin bi arkasinin adresi
public:
    Queue(int qsize)
    {
        qList= new User[qsize];
        qEnd=qList;
        currentSize=0;
    }
    ~Queue()
    {
        delete[] qList;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    int GetCurrentSize()
    {
        return currentSize;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    User LookFront(int sira=1)
    {
        return *(qList+sira-1);
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    void Insert(User a)
    {
        *qEnd=a;
        qEnd++;
        currentSize++;
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    User Delete(int sira=1)
    {
        User temp=*(qList+sira-1);
        for(User *n=(qList+sira); n<qEnd; n++)
        {
            *(n-1)=*n;
        }
        qEnd--;
        currentSize--;
        return temp;

    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    void printQueueInfo(ofstream &outputtxt)
    {
        outputtxt<<"Queue: \n";
        for (User *n=qList; n<qEnd; n++)
        {
            outputtxt<<"User ID: "<<(*n).GetID()<<endl;
            outputtxt<<"User Score: "<<n->GetScore()<<endl<<endl;
        }
    }

};



#endif // Queue_H_INCLUDED
