#include <stdio.h>
#include <stdlib.h>

void DisplayArray(double* a, size_t n);
double* ReadArray(size_t* size_p);
double* Append(double* array_1, size_t size_1, double* array_2, size_t size_2);

int main(void) {
    double array1[] = {1.0, 2.0, 3.0};
    DisplayArray(array1, 3);
    
    size_t size2; // Declare size for the second array
    double* array2 = ReadArray(&size2); // Correct the array declaration and use ReadArray correctly
    
    if (array2 != NULL) { // Check if array2 is allocated successfully
        DisplayArray(array2, size2);
        double* combined_array = Append(array1, 3, array2, size2); // Correct parameters for Append
        if (combined_array != NULL) {
            DisplayArray(combined_array, 3 + size2);
            free(combined_array); // Free the combined array after use
        }
        free(array2); // Free the second array after use
    }
    
    return 0;
}

void DisplayArray(double* a, size_t n) {
    if (a == NULL || n <= 0) {
        return; // No valid array to display
    }
    
    printf("Array = [ ");
    for (size_t i = 0; i < n; i++) {
        printf("%.2f, ", a[i]); // Print elements as floating point with 2 decimals
    }
    printf("\b\b ]\n"); // Backspace to remove last comma and space
}

double* ReadArray(size_t* size_p) {
    if (size_p == NULL) {
        return NULL;
    }

    size_t n;
    printf("Enter the number of elements: ");
    if (scanf("%zu", &n) != 1 || n <= 0) {
        *size_p = 0;
        return NULL;
    }

    double* array = (double*)malloc(n * sizeof(double));
    if (array == NULL) {
        *size_p = 0;
        return NULL;
    }

    printf("Enter the elements: \n");
    for (size_t i = 0; i < n; i++) {
        if (scanf("%lf", &array[i]) != 1) {
            free(array);
            *size_p = 0;
            return NULL;
        }
    }

    *size_p = n;
    return array;
}

double* Append(double* array_1, size_t size_1, double* array_2, size_t size_2) {
    if (array_1 == NULL || array_2 == NULL || size_1 <= 0 || size_2 <= 0) {
        return NULL;
    }

    size_t newsize = size_1 + size_2;
    double* combined_array = (double*)malloc(newsize * sizeof(double));
    
    if (combined_array == NULL) {
        return NULL;
    }

    for (size_t i = 0; i < size_1; i++) {
        combined_array[i] = array_1[i];
    }

    for (size_t i = 0; i < size_2; i++) {
        combined_array[i + size_1] = array_2[i];
    }

    return combined_array;
}
