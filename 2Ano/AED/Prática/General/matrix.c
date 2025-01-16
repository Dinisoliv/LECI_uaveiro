void multiplyMatrix(int** matrixA, int** matrixB, int** result, int rowsA, int colsB, int colsA){
    for (int i = 0; i < rowsA; i++)
    {
        for (int j = 0; j < colsB; j++)
        {
            result[i][j] = 0;
            for (int k = 0; k < colsA; k++)
            {
                result[i][j] += matrixA[i][k] * matrixB[k][j]; 
            }
            
        }
        
    }
    
}