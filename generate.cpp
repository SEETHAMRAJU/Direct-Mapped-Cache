#include<bits/stdc++.h>
#define append push_back
#define SIZE 1000000
using namespace std;
int main()
{
	freopen("memory.list","w",stdout);
	unsigned long long int p=0;	
	for(p;p<256;p++)
	{
		bitset<8> x(p);
		for(int j=0;j<4;j++)
		{
			if(j == 3)
				cout << x << endl;
			else
				cout << "00000000"<<endl; 
		}
	}
	return 0;
}





