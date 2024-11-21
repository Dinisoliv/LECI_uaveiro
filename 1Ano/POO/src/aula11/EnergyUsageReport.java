package aula11;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

public class EnergyUsageReport {
    List<Customer> clientEnergyUsage;

    public EnergyUsageReport(){
        clientEnergyUsage = new ArrayList<>();
    }

    public void load(String fich){
        File myFile = new File(fich);
        try {
            Scanner myReader = new Scanner(myFile);
            while (myReader.hasNextLine()) {
                String client = myReader.nextLine();
                String[] clientInfo = client.split("\\|");
                
                List<Double> energyUsage = new ArrayList<>();
                try {
                    int id = Integer.parseInt(clientInfo[0]);
                    energyUsage.add(Double.parseDouble(clientInfo[1]));
                    energyUsage.add(Double.parseDouble(clientInfo[2]));
                    energyUsage.add(Double.parseDouble(clientInfo[3]));
                    Customer customer = new Customer(id, energyUsage);
                    clientEnergyUsage.add(customer);
                } catch (NumberFormatException e) {
                    System.out.println("Error parsing grade for student: " + clientInfo[0]);
                    continue;
                }
            }
            myReader.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("Ficheiro nao encontrado");
        }
    }

    public void addCustomer(Customer customer){
        clientEnergyUsage.add(customer);
    }

    public void removeCustomer(int id){
        Iterator<Customer> iterator = clientEnergyUsage.iterator();

        while (iterator.hasNext()) {
            if (iterator.next().getCustomerId() == id) {
                clientEnergyUsage.remove(iterator.next());
                return;
            }
        }
    }

    public Customer getCustomer(int id){
        for (Customer customer : clientEnergyUsage) {
            if (customer.getCustomerId() == id) {
                return customer;
            }
        }
        return null;
    }

    public double calculateTotalUsage(int id){
        for (Customer customer : clientEnergyUsage) {
            if (customer.getCustomerId() == id) {
                return sumEnergy(customer.getMeterReadings());
            }   
        }
        return -1;
    }

    private double sumEnergy(List<Double> energyValues){
        double totalUsage = 0;
        for (Double elem : energyValues) {
            totalUsage += elem;
        }
        return totalUsage;
    }

    public void generateReport(String fich){
        try {
            FileWriter myWriter = new FileWriter(fich);

            for (Customer customer : clientEnergyUsage) {
                myWriter.write("ID: " + customer.getCustomerId() + ", " + "total-energia: " + sumEnergy(customer.getMeterReadings()) + "\n");
            }
            myWriter.close();
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();        
        }
    }
}