#ifndef OKU_H_INCLUDED
#define OKU_H_INCLUDED
#include <fstream>

void oku(char in[],char *ch)
{

    fstream fin(in, fstream::in);
    int n=0;
    while (fin >> ch[n])
    {
        n++;
    }


}


#endif // OKU_H_INCLUDED
