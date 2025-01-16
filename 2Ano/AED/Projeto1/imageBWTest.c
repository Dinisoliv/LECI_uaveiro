// imageBWTest - A program that performs some image processing.
//
// This program is an example use of the imageBW module,
// a programming project for the course AED, DETI / UA.PT
//
// You may freely use and modify this code, NO WARRANTY, blah blah,
// as long as you give proper credit to the original and subsequent authors.
//
// The AED Team <jmadeira@ua.pt, jmr@ua.pt, ...>
// 2024

#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "imageBW.h"
#include "instrumentation.h"

int main(int argc, char* argv[]) {
  // To initalize operation counters
  ImageInit();

  // Creating and displaying some images
  Image white_image = ImageCreate(8, 8, WHITE);
  ImageRAWPrint(white_image);

  Image black_image = ImageCreate(8, 8, BLACK);
  ImageRAWPrint(black_image);

  Image image_1 = ImageNEG(white_image);
  ImageRAWPrint(image_1);

  Image imageChess = ImageCreateChessboard(8,8,1,WHITE);
  ImageRAWPrint(imageChess);
  
  Image image_2 = ImageReplicateAtBottom(white_image, black_image);
  ImageRAWPrint(image_2);

  printf("image_1 AND image_1\n");
  Image image_3 = ImageAND(image_1, image_1);
  ImageRAWPrint(image_3);

  printf("image_1 AND image_2\n");
  Image image_4 = ImageAND(image_1, imageChess);
  ImageRAWPrint(image_4);

  printf("image_1 OR image_2\n");
  Image image_5 = ImageOR(image_1, imageChess);
  ImageRAWPrint(image_5);

  printf("image_1 XOR image_1\n");
  Image image_6 = ImageXOR(image_1, image_1);
  ImageRAWPrint(image_6);

  printf("image_1 XOR image_2\n");
  Image image_7 = ImageXOR(image_1, imageChess);
  ImageRAWPrint(image_7);

  Image image_8 = ImageReplicateAtRight(image_6, image_7);
  ImageRAWPrint(image_8);

  Image image_9 = ImageReplicateAtRight(image_6, image_6);
  ImageRAWPrint(image_9);


  // Saving in PBM format
  ImageSave(image_7, "image7.pbm");
  ImageSave(image_8, "image8.pbm");

  ChessboardMemAnalizingFunc(4, 4, 1);
  ChessboardMemAnalizingFunc(4, 4, 2);
  ChessboardMemAnalizingFunc(4, 4, 4);
  ChessboardMemAnalizingFunc(8, 8, 1);
  ChessboardMemAnalizingFunc(8, 8, 2);
  ChessboardMemAnalizingFunc(8, 8, 4);
  ChessboardMemAnalizingFunc(8, 8, 8);
  ChessboardMemAnalizingFunc(16, 16, 4);
  ChessboardMemAnalizingFunc(20, 20, 5);
  ChessboardMemAnalizingFunc(32, 32, 1);
  ChessboardMemAnalizingFunc(32, 32, 4);
  ChessboardMemAnalizingFunc(32, 32, 8);
  ChessboardMemAnalizingFunc(128, 128, 16);
  ChessboardMemAnalizingFunc(256, 256, 32);

  /*** UNCOMMENT TO TEST THE NEXT FUNCTIONS

  Image image_10 = ImageHorizontalMirror(image_1);
  ImageRAWPrint(image_10);

  Image image_11 = ImageVerticalMirror(image_8);
  ImageRAWPrint(image_11);



  ***/

  // Housekeeping
  ImageDestroy(&white_image);
  ImageDestroy(&black_image);
  ImageDestroy(&image_1);
  ImageDestroy(&image_2);
  ImageDestroy(&imageChess);
  ImageDestroy(&image_3);
  ImageDestroy(&image_4);
  ImageDestroy(&image_5);
  ImageDestroy(&image_6);
  ImageDestroy(&image_7);
  ImageDestroy(&image_8);
  ImageDestroy(&image_9);

  /*** UNCOMMENT IF YOU CREATE THOSE IMAGES

  ImageDestroy(&image_10);
  ImageDestroy(&image_11);

   ***/

  return 0;
}
