#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "imageBW.h"
#include "instrumentation.h"

#define TEST_IMAGE_WIDTH  16
#define TEST_IMAGE_HEIGHT 8

// Function prototypes
void RunTests();
double MeasureExecutionTime(Image (*operation)(const Image, const Image), const Image img1, const Image img2, const char* testName);
void PrintExecutionResults(const char* testName, double timeTaken);

int main() {
    // Initialize the image library and instrumentation
    ImageInit();

    InstrCalibrate();

    // Run the defined tests
    RunTests();

    return 0;
}

// Function to execute the tests
void RunTests() {
    printf("Generating test images...\n");

    // Generate the test images
    Image imgBlack = ImageCreate(TEST_IMAGE_WIDTH, TEST_IMAGE_HEIGHT, BLACK);
    Image imgWhite = ImageCreate(TEST_IMAGE_WIDTH, TEST_IMAGE_HEIGHT, WHITE);
    Image chessboard1 = ImageCreateChessboard(16, 8, (uint8) 2, WHITE);
    Image chessboard2 = ImageCreateChessboard(16, 8, (uint8) 4, BLACK);
    Image random = GenerateTestImage(TEST_IMAGE_WIDTH, TEST_IMAGE_HEIGHT);
    Image random2 = GenerateTestImage(TEST_IMAGE_WIDTH, TEST_IMAGE_HEIGHT);

    //printImageRLE(imgBlack);
    //printf("------------------");
    //printImageRLE(imgWhite);
    //printf("------------------");
    //printImageRLE(chessboard1);
    //printf("------------------");
    //printImageRLE(chessboard2);
    //printf("------------------");
    //printImageRLE(random);
    //printf("------------------");
    //printImageRLE(random2);
    //printf("------------------");

    // List of test images
    const Image testImages[] = {imgBlack, imgWhite, /*chessboard1, chessboard2,*/ random, random2};
    const char* testImageNames[] = {"Black", "White", /*"Chessboard 1", "Chessboard 2",*/ "Random", "Random2"};
    const int numImages = sizeof(testImages) / sizeof(testImages[0]);

    // Run AND tests for all pairs of images
    for (int i = 0; i < numImages; i++) {
        for (int j = i; j < numImages; j++) {
            // Measure AND operation with and without compression
            char testName[128];
            snprintf(testName, sizeof(testName), "AND (%s, %s)", testImageNames[i], testImageNames[j]);
            double timeWithoutCompression = MeasureExecutionTime(ImageAND, testImages[i], testImages[j], testName);

            snprintf(testName, sizeof(testName), "AND with compression (%s, %s)", testImageNames[i], testImageNames[j]);
            double timeWithCompression = MeasureExecutionTime(ImageANDWithCompression, testImages[i], testImages[j], testName);

            // Print results
            PrintExecutionResults("AND without compression", timeWithoutCompression);
            PrintExecutionResults("AND with compression", timeWithCompression);
            printf("----------------------------------------------------------------\n");

            // Print instrumentation counters
            //InstrPrint();
        }
    }
    // Free all allocated images
    ImageDestroy(&imgBlack);
    ImageDestroy(&imgWhite);
    //printf("\ntest1\n");
    //ImageDestroy(&chessboard1);
    //printf("\ntest2\n");
    //ImageDestroy(&chessboard2);
    //ImageDestroy(&random);
    //ImageDestroy(&random2);
}

// Function to measure execution time of an operation
double MeasureExecutionTime(Image (*operation)(const Image, const Image), const Image img1, const Image img2, const char* testName) {
    printf("Running test: %s...\n", testName);

    // Reset counters and start the timer
    InstrReset();
    double startTime = cpu_time();

    //printf("\nTest1\n");
    // Perform the operation
    Image img = operation(img1, img2);
    //printf("\nTest2\n");

    // Stop the timer
    double elapsedTime = cpu_time() - startTime;

    // Destroy the result to free memory
    ImageDestroy(&img);
    
    return elapsedTime;
}

// Function to print the execution results
void PrintExecutionResults(const char* testName, double timeTaken) {
    printf("Test: %s\n", testName);
    printf("Elapsed time: %.6f seconds\n\n", timeTaken);
}
