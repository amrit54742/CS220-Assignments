#include <stdio.h>

int p = 12;
int n = 2;
float arr[] = {0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434, 0.1126, 0.554, 0.3349, 0.678, 0.3656, 0.9989};
float buckets[] = {-1, 0.565, -1, 0.1234, -1, 0.3434, 0.1126, 0.554, 0.3349, -1, 0.3656, -1, 0.897, -1, 0.656, -1, 0.665, -1, -1, -1, -1, 0.678, -1, 0.9989};

void insertion_sort(int start, int end){
    for(int i = start + 1; i < end; i++){
        int j = i;
        while(j > start && buckets[j - 1] > buckets[j]){
            float temp = buckets[j - 1];
            buckets[j - 1] = buckets[j];
            buckets[j] = temp;
            j--;
        }
    }
}

int main(){
    for(int i = 0; i < n; i++){
        insertion_sort(p * i, p * (i + 1));
    }

    float bucket[p];
    int j = 0;
    for(int i = 0; i < n * p; i++){
        if(buckets[i] >= 0){
            bucket[j] = buckets[i];
            j++;
        }
    }

    for(int i = 0; i < p; i++){
        printf("%f ", bucket[i]);
    }
    printf("\n");

    return 0;
}
