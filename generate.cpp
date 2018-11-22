#include<bits/stdc++.h>
#define append push_back
#define SIZE 1000000
using namespace std;
int main()
{
	freopen("memory.list","w",stdout);
	unsigned long long int p=0;
	for(p;p<1024;p++)
	{
		bitset<32> x(p);
		cout << x << endl;
	}
	return 0;
}





