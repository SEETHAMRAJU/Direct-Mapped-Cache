#include<bits/stdc++.h>
#define llint long long int
#define append push_back
#define SIZE 1000000
using namespace std;
string solve(llint x,llint s)
{
	string ans = "";
	llint i=0;
	while(i<s)
		{x = x >> 1;i++;}
	for(;i<s+8;i++)
	{
		if(x%2 == 0)
			ans += "0";
		else
			ans += "1";
		x = x>>1;
	}
	reverse(ans.begin(),ans.end());
	return ans;

}
int main()
{
	freopen("memory.list","w",stdout);
	unsigned long long int p=0;	
	for(p;p<2097152;p++)
	{
		for(int j=24;j>=0;j-=8)
		{
			cout << solve(p,j) << endl;
		}
	}
	return 0;
}




