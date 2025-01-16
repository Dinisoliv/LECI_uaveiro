public class StandardShippingCostCalculator implements IShippingCostCalculator {
    
    public static double calculateShippingCost(Parcel parcel){
        double peso = parcel.getPeso();
        int pesoInt = (int) peso;
        if (peso < 5) {
            return pesoInt * 5;
        }
        else if (peso >= 5 && peso < 10) {
            return pesoInt * 0.75;
        }
        else{
            return pesoInt * 0.5;
        }
    }
}
