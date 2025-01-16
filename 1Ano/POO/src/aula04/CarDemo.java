package aula04;

//import java.util.Arrays;
import java.util.Scanner;

class Car {
    public String make;
    public String model;
    public int year;
    public int kms;

    public Car(String make, String model, int year, int kms) {
        this.make = make;
        this.model = model;
        this.year = year;
        this.kms = kms;
    }

    public void drive(int distance) {
        this.kms += distance;
    }

    @Override public String toString(){
        return "marca: " + make + " modelo: " + model + " ano: " + year + " quilometragem " + kms;
    }

}

public class CarDemo {

    static Scanner sc = new Scanner(System.in);

    static boolean validateCarInput(String[] car){
        
        if (car.length < 4) {
            return false;
        }

        if (!car[0].matches("[a-zA-Z]+")) {
            return false;
        }

        for (int i = 1; i < car.length - 2; i++) {
            if (!car[i].matches("[a-zA-Z0-9]+")) {
                return false;
            }
        }

        if (!car[car.length - 2].matches("\\d{4}")) {
            return false;
        }

        if (!car[car.length - 1].matches("\\d+")) {
            return false;
        }

        return true;
    }

    static int registerCars(Car[] cars) {
        // pede dados dos carros ao utilizador e acrescenta ao vetor
        // registo de carros termina quando o utilizador inserir uma linha vazia 
        // devolve número de carros registados
        int numCars = 0;
        String carInput = null;

        while (numCars < cars.length) {
            System.out.print("Insira dados do carro (marca modelo ano quilómetros): ");
            carInput = sc.nextLine().trim();
            if (carInput.isEmpty()) {
                break;
            }
            String[] car = carInput.split(" ");

            //System.out.println(Arrays.toString(car));

            if (!validateCarInput(car)) {
                System.out.println("Dados mal formatados. Tente novamente.");
                continue;
            }
            
            String make = car[0];
            StringBuilder modelBuilder = new StringBuilder();

            for (int i = 1; i < car.length - 2; i++) {
                modelBuilder.append(car[i]);
                modelBuilder.append(" ");
            }

            String model = modelBuilder.toString().trim();

            int year = Integer.parseInt(car[car.length - 2]);
            int kms = Integer.parseInt(car[car.length - 1]);

            cars[numCars++] = new Car(make, model, year, kms);

            //System.out.println(cars[numCars - 1].toString());
        }

        return numCars;
   }

    static void registerTrips(Car[] cars, int numCars) {
        // pede dados das viagens ao utilizador e atualiza informação do carro
        // registo de viagens termina quando o utilizador inserir uma linha vazia 

        while (true) {
            System.out.print("Registe uma viagem no formato \"carro:distância\": ");
            String tripInput = sc.nextLine().trim();

            if (tripInput.isEmpty()) {
                break;
            }
            String[] tripData = tripInput.split(":");

            if (tripData.length != 2 || !tripData[1].matches("\\d+") || !tripData[0].matches("\\d")) {
                System.out.println("Dados mal formatados. Tente novamente.");
                continue;
            }

            int carIndex = Integer.parseInt(tripData[0]);
            int distance = Integer.parseInt(tripData[1]);

            if (carIndex < 0 || carIndex >= numCars || distance < 0) {
                System.out.println("Dados mal formatados ou carro não existente. Tente novamente.");
                continue;
            }

            cars[carIndex].drive(distance);
        }
    }


    static void listCars(Car[] cars) {
        System.out.println("\nCarros registados: ");
        //  lista todos os carros registados
        // Exemplo de resultado
        // Carros registados: 
        // Toyota Camry, 2010, kms: 234346
        // Renault Megane Sport Tourer, 2015, kms: 32536
        for (int i = 0; i < cars.length; i++) {
            if (cars[i] != null) {
                System.out.println(String.format("%s, %s, %d, kms: %d", cars[i].make, cars[i].model, cars[i].year, cars[i].kms));
            }        
        }
        System.out.println("\n");
    }

    public static void main(String[] args) {

        Car[] cars = new Car[10];

        int numCars = registerCars(cars);

        if (numCars>0) {
            listCars(cars);
            registerTrips(cars, numCars);
            listCars(cars);
        }

        sc.close();

    }
}