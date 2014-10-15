#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <cmath>
#include <algorithm>
#include <ctime>

using namespace std;

int n;
int* a;
int* b;

int partition(int low, int high){
	int pivot = low + (rand()%(high-low));
	int left = low;
	int right = high-1;

	swap(a[pivot], a[high]);
	while(left<=right){
		if(a[left]<=a[high]){
			++left;
		} else {
			swap(a[left], a[right]);
			--right;
		}
	}
	swap(a[left], a[high]);

	return left;
}

void quick_sort(int low, int high){
	if(high-low <= 0)
		return;

	int index = partition(low, high);
	quick_sort(low, index-1);
	quick_sort(index+1, high);
}

void heapify(int index, int size){
	int parent;
	do{
		parent = index;
		int left = 2*index+1;
		int right = 2*index+2;

		if(left<size && b[left]>b[index]){
			index = left;
		}

		if(right<size && b[right]>b[index]){
			index = right;
		}

		swap(b[index], b[parent]);
	}while(parent!=index);
}

void heap_sort(){
	for(int i=n/2;i>=0;--i){
		heapify(i, n);
	}

	for(int i=0;i<n;++i){
		swap(b[0], b[n-i-1]);
		heapify(0, n-i-1);
	}
}

void compare(){
	for(int i=0;i<n;++i){
		if(a[i] != b[i]){
			printf("\nIF OUTPUT FROM BOTH SORT SAME : FALSE\n");
			return;
		}
	}
	printf("\nIF OUTPUT FROM BOTH SORT SAME : TRUE\n");
}

int main() {
	srand(time(NULL));

	n = 1000000;
	a = new int[n];
	b = new int[n];

	// ===========INPUT===========
	printf("SIZE OF INPUT: %d", n);
	for(int i=0;i<n;++i){
		a[i] = rand()%100000;
		b[i] = a[i];

		// to see input uncomment below statement
		// printf("%d ", a[i]);
	}

	// ===========QUICK SORT===========
	printf("\nQUICK SORT ");

	clock_t qsort_s = clock();
	quick_sort(0, n-1);
	clock_t qsort_e = clock();

    // to see sorted output from quick sort, uncomment below for loop
	// for(int i=0;i<n;++i)
        // printf("%d ", a[i]);

	printf("\nTime Taken: %lf", (double)(qsort_e - qsort_s) / CLOCKS_PER_SEC);

	// ===========HEAP SORT===========
	printf("\nHEAP SORT ");

	clock_t heap_s = clock();
	heap_sort();
	clock_t heap_e = clock();

    // to see sorted output from heap sort, uncomment below for loop
	// for(int i=0;i<n;++i)
		// printf("%d ", b[i]);

	printf("\nTime Taken: %lf", (double)(heap_e - heap_s) / CLOCKS_PER_SEC);

	// ===========COMPARING RESULTS===========
	compare();

    delete(a);
    delete(b);

	return 0;
}
