import csv
import sys

def main(argv):
    fich_csv = open(argv[1], "r")
    csv_reader = csv.DictReader(fich_csv, delimiter=",")

    next(csv_reader)

    counter_rows = 0
    max_temp = float('-inf')  # Initialize max_temp with negative infinity
    min_temp = float('inf')   # Initialize min_temp with positive infinity
    total_temp = 0

    for row in csv_reader:
        temp = float(row['value'])
        if temp > max_temp:
            max_temp = temp
        if temp < min_temp:
            min_temp = temp
        
        total_temp += temp
        counter_rows += 1
    
    avg_temp = total_temp / counter_rows

    print(f"Temperatura máxima = {max_temp}")
    print(f"Temperatura mínima = {min_temp}")
    print(f"Temperatura média = {avg_temp}")

    fich_csv.close()

main(sys.argv)
