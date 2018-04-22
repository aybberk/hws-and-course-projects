#ifndef ISDONE_H_INCLUDED
#define ISDONE_H_INCLUDED

bool isDone(Team t1, Team t2, int kacakac)
{   //If the both teams are full and ready to match, returns 1, else returns 0;
    if(t1.getCurrentSize()==kacakac && t2.getCurrentSize()==kacakac)
        return 1;
    else
        return 0;
}


#endif // ISDONE_H_INCLUDED
