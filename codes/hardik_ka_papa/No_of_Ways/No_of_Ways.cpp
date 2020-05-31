#include<bits/stdc  .h>
using namespace std;
long long int dp[17];
long long int C(int n,int r)
{
  return dp[n]/(dp[r]*dp[n-r]);
}
int main()
{
  dp[0]=1;
  for(int i=1;i<17;i  )
  {
    dp[i]=dp[i-1]*i;
  }
    
  int n,k;
  cin>>n>>k;
  cout<<C(n k-1,n-1);
}