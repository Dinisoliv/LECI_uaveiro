#define SIZE 10
int main(void)
{
	double arr[SIZE];
	int i;
	for(i=0; i < SIZE; i++)
		arr[i] = read_double();
	print_double( average(arr, SIZE) );
	print_double( var(arr, SIZE) );
	print_double( stdev(arr, SIZE) );
	return 0;
} 

double var(double *array, int nval)
{
	int i;
	float media, soma;
	media = (float)average(array, nval);
	for(i=0, soma=0.0; i < nval; i++)
		soma += xtoy((float)array[i] - media, 2);
	return (double)soma / (double)nval;
}
double stdev(double *array, int nval)
{
	return sqrt( var(array, nval) );
}

double average(double *array, int n)
{
	int i = n-1;
	double sum = 0.0;
	for(; i >= 0; i--){
		sum += array[i];
	}
	return sum / (double)n;
}

double sqrt(double val)
{
	double aux, xn = 1.0;
	int i = 0;
	if(val > 0.0)
		{
		do{
			aux = xn;
			xn = 0.5 * (xn + val/xn);
		} while((aux != xn) && (++i < 25));
	} else
		xn = 0.0;
	return xn;
} 

float xtoy(float x, int y)
{
	int i;
	float result;
	for(i=0, result=1.0; i < abs(y); i++)
		{
		if(y > 0)
			result *= x;
	else
		result /= x;
	}
	return result;
}
int abs(int val)
{
	if(val < 0)
		val = -val;
	return val;
} 
