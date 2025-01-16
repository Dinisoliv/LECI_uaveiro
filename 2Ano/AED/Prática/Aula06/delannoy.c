#include <stdio.h>
#include "elapsed_time.h"

int delannoy_rec(int m, int n, int* Nadds, int* RcrCalls);
long long delannoy_dynamic(int m, int n, int* Nadds, int* RcrCalls);
long long delannoy_menoization();

int main(void){
    int Nadds;
    int RcrCalls;
    long long del_num;
    double time;

    printf("%3s%25s%18s%10s%10s\n", "i", "del_num", "adds", "Rcrs", "cpu_t");

    for (int i = 0; i < 50; i++)
    {
        Nadds = 0; RcrCalls = 0;
        time = cpu_time();
        del_num = delannoy_dynamic(i, i, &Nadds, &RcrCalls);
        time = cpu_time() - time;
        printf("%3d%25lld%18d%10d%10.5lf\n", i, del_num, Nadds, RcrCalls, time);
    }

    //Memoization implementation
    long long meno_del [50][50];

    for (int i = 0; i <= 50; i++)
    {
        for (int j = 0; j <= 50; j++)
        {
            meno_del[i][j] = -1;
        }
    }

    printf("%3s%25s%18s%10s%10s\n", "i", "del_num", "adds", "Rcrs", "cpu_t");

    for (int i = 0; i < 50; i++)
    {
        Nadds = 0; RcrCalls = 0;
        time = cpu_time();
        del_num = delannoy_menoization(i, i, &Nadds, &RcrCalls, meno_del);
        time = cpu_time() - time;
        printf("%3d%25lld%18d%10d%10.5lf\n", i, del_num, Nadds, RcrCalls, time);
    }
        
}

int delannoy_rec(int m, int n, int* Nadds, int* RcrCalls){
    if ((m == 0) || (n == 0))
    {
        return 1;
    }
    *Nadds += 2;
    *RcrCalls += 3;
    return delannoy_rec(m-1, n, Nadds, RcrCalls) + delannoy_rec(m-1, n-1, Nadds, RcrCalls) + delannoy_rec(m, n-1, Nadds, RcrCalls);
}

long long delannoy_dynamic(int m, int n, int* Nadds, int* RcrCalls){
    long long del_data[m+1] [n+1];

    for (int i = 0; i <= m; i++)
    {
        del_data[i][0] = 1;
    }
    for (int i = 0; i <= n; i++)
    {
        del_data[0][i] = 1;
    }

    for (int i = 1; i <= m; i++)
    {
        for (int j = 1; j <= n; j++)
        {
            *Nadds += 2;
            del_data[i][j] = del_data[i-1][j] + del_data[i-1][j-1] + del_data[i][j-1];
        }
    }
    return del_data[m][n];
}

long long delannoy_menoization(int m, int n, int* Nadds, int* RcrCalls, long long** meno_del){
    (*RcrCalls)++;

    if (m == 0 || n==0)
    {
        return 1;
    }
    

    if (meno_del[m][n] != -1)
    {
        return meno_del[m][n];
    }
    
    meno_del[m][n] = delannoy_menoization(m-1, n, Nadds, RcrCalls, meno_del) +
                     delannoy_menoization(m-1, n-1, Nadds, RcrCalls, meno_del) +
                     delannoy_menoization(m, n-1, Nadds, RcrCalls, meno_del);

    *Nadds += 2;

    return meno_del[m][n];
}