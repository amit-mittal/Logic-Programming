#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <utility>

using namespace std;

int n;
vector<int> d;
vector<int> ans;

void solve(int val, int index){
	if(val <= 1){
		for(int i=0;i<n;++i){
			printf("%d ", ans[i]);
		}
		printf("\n");

		return;
	}

	if(index == n)
        return;

	int max_count = (val/d[index]) + 1;
	for(int i=0;i<=max_count;++i){
		if(val - (d[index]*i) >= -1){
            ans[index]+=i;
            solve(val-(d[index]*i), index+1);
            ans[index]-=i;
        }
	}
}

int main() {
	double value, den;

    printf("Enter no. of coins you have: ");
	scanf("%d", &n);
	d.resize(n);
	ans.resize(n);

	// multiplying by 1000.0f to avoid calculations in decimal
	for(int i=0;i<n;++i){
        printf("Enter %d th coin value: ", i+1);
		scanf("%lf", &den);
		d[i] = (int)(den*10000.00f);
	}

    printf("Enter the amount: ");
	scanf("%lf", &value);

    printf("Possible Exchange:\n");
	solve((int)(value*10000.00f), 0);

	return 0;
}
