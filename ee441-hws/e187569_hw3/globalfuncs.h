#ifndef GLOBALFUNCS_H_INCLUDED
#define GLOBALFUNCS_H_INCLUDED
#include "User.h"
#include "Queue.h"



    void ResetTraversalStatus(User *userarray)  //sets mindist member of all users 999999
                                                // and sets all unvisited
    {
        for(int n=0;n<20;n++)
        {
            userarray[n].setUnvisited();
            userarray[n].mindist=999999;
        }
    }

    int minDist(User *from, User *to)           //calculates the min distance from "from" to "to"
    {                                           //using the algorithm in the lecture notes

        Queue userq;
        userq.Insert(from);
        from->mindist=0;
        User* current;
        while(userq.GetCurrentSize()>0)
        {
            current=userq.Delete();
            //cout<<current->GetID()<<" is deleted \n";         //for debugging
            for(int n=0;n<5;n++)
            {
                if(current->Link_array[n]==NULL)
                {
                    continue;
                }
                else if((current->Link_array[n])->isVisited())
                {
                    continue;
                }
                    else
                    {
                        userq.Insert(current->Link_array[n]);
                        if ((current->mindist+1) < current->Link_array[n]->mindist)
                        {
                            current->Link_array[n]->mindist=current->mindist+1;

                           // cout<<current->Link_array[n]->GetID()<<" is inserted."<<endl;  //for debugging
                        }

                    }
            }
            current->setVisited();


        }
        int temp=to->mindist;
        return temp;
    }

    float CalcNetworkScore(User *user, User *userarray, int usercount)
    {
                        //calculates the user's network score in the "userarray" network which has "usercount" users
        float ntw=0.0;
        for(int n=0;n<usercount;n++)
        {
            if(user==userarray+n){continue;}
            else
            {
                int mindist=minDist(user, userarray+n);
                if (mindist!=999999)  //meaning that user can be reached
                ntw=ntw + userarray[n].CalcWeightedScore()*1.0/mindist;
                ResetTraversalStatus(userarray);
            }
        }
        user->SetNetworkScore(ntw);
        return ntw;

    }

    void quickSort(float *arr, char *arr2, int left, int right)
    {           //implemented quick sort algorithm in the lecture notes (for float)
      int i = left, j = right;
      float tmp;
      char  tmp2;
      float pivot = arr[(left + right) / 2];

      while (i <= j) {
            while (arr[i] < pivot)
                  i++;
            while (arr[j] > pivot)
                  j--;
            if (i <= j) {
                  tmp = arr[i];
                  tmp2 = arr2[i];
                  arr[i] = arr[j];
                  arr2[i] = arr2[j];
                  arr[j] = tmp;
                  arr2[j] = tmp2;
                  i++;
                  j--;
            }
      };

      if (left < j)
            quickSort(arr, arr2, left, j);
      if (i < right)
            quickSort(arr, arr2, i, right);
    }


    void quickSort(int *arr, char *arr2, int left, int right)
    {           //different overload quicksort for integer
      int i = left, j = right;
      int tmp;
      char tmp2;
      int pivot = arr[(left + right) / 2];

      while (i <= j) {
            while (arr[i] < pivot)
                  i++;
            while (arr[j] > pivot)
                  j--;
            if (i <= j) {
                  tmp = arr[i];
                  tmp2 = arr2[i];
                  arr[i] = arr[j];
                  arr2[i] = arr2[j];
                  arr[j] = tmp;
                  arr2[j] = tmp2;
                  i++;
                  j--;
            }
      };

      if (left < j)
            quickSort(arr, arr2, left, j);
      if (i < right)
            quickSort(arr, arr2, i, right);
    }

void invert(char *arr, int usercount)
{           //yanlislikla kucukten buyuge sıraladığım için bi de invert yazmak zorunda kaldım
    char temp;
    for(int n=0;n<usercount/2;n++)
    {
        temp=arr[n];
        arr[n]=arr[usercount-1-n];
        arr[usercount-1-n]=temp;
    }
}
void invert(float *arr, int usercount)
{           //overloading invert for float
    float temp;
    for(int n=0;n<usercount/2;n++)
    {
        temp=arr[n];
        arr[n]=arr[usercount-1-n];
        arr[usercount-1-n]=temp;
    }

}
void invert(int *arr, int usercount)
{           //overloading invert for integer
    int temp;
    for(int n=0;n<usercount/2;n++)
    {
        temp=arr[n];
        arr[n]=arr[usercount-1-n];
        arr[usercount-1-n]=temp;
    }

}

#endif // GLOBALFUNCS_H_INCLUDED
