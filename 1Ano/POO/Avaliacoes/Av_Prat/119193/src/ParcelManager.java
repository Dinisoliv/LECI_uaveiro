import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class ParcelManager {
    Map<Integer, Parcel> parcelManager;

    public ParcelManager() {
        this.parcelManager = new HashMap<>();
    }

    public void addParcel(Parcel p){
        if (!(parcelManager.containsKey(p.getId()))) {
            parcelManager.put(p.getId(), p);
        }
    }

    public void removeParcel(int id){
        if (parcelManager.containsKey(id)) {
            parcelManager.remove(id);
        }
    }

    public Parcel getParcel(int id){
        if (parcelManager.containsKey(id)) {
            return parcelManager.get(id);
        }
        return null;
    }

    public double calculateShippingCost(int id){
        if (!parcelManager.containsKey(id)) {
            return -1;
        }
        return StandardShippingCostCalculator.calculateShippingCost(parcelManager.get(id));
    }

    public void printAllParcels(){
        for (Parcel parcel : parcelManager.values()) {
            System.out.println(parcel);
        }
    }

    public void readFile(String fich){
        try {
            File myObj = new File(fich);
            Scanner myReader = new Scanner(myObj);

            myReader.nextLine();

            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                String[] splitedLine = data.split(";");

                System.out.println(splitedLine.toString());

                Parcel newParcel = new Parcel(splitedLine[3], splitedLine[2], parseDouble(splitedLine[1]));

                for (int i = 0; i < splitedLine.length; i++) {
                    parcelManager.put(parseInt(splitedLine[0]), newParcel);
                }

                int maxKey = 0;
                for (int i : parcelManager.keySet()) {
                    if (i > maxKey) {
                        maxKey = i;
                    }
                }
                newParcel.setNextId(maxKey + 1);
            }
            myReader.close();

        } catch (FileNotFoundException e) {
            System.out.println("Ficheiro não encontrado.");
        }
    }

    private int parseInt(String string) throws NumberFormatException{
        return Integer.parseInt(string);
    }

    private double parseDouble(String string) throws NumberFormatException{
        return Double.parseDouble(string);
    }

    public void writeFile(String fich){
        try {
            File myObj = new File(fich);
            if (!myObj.createNewFile()) {
                System.out.println("Ficheiro já existe");
            }

        } catch (IOException e) {
            System.out.println("IOExcepetion");
            e.printStackTrace();
        }

        try {
            FileWriter myWriter = new FileWriter(fich);

            for (Parcel parcel : parcelManager.values()) {
                myWriter.write(parcel.getId() + "; " + parcel.getPeso() + "; " + parcel.getRementente() + "; " + parcel.getDestino());
            }

            myWriter.close();

        } catch (IOException e) {
            System.out.println("IOExcepetion");
            e.printStackTrace();
        }
    }
}
