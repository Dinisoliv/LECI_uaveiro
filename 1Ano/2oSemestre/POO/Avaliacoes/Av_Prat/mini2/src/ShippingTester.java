public class ShippingTester {
    public static void main(String[] args) {
        ParcelManager pm = new ParcelManager();

        // ----------------------------------------------------------
        Parcel p1 = new Parcel("Aveiro, Portugal", "Madrid, Spain", 10);
        Parcel p2 = new Parcel("Dublin, Ireland", "Berlin, Germany", 15);
        pm.addParcel(p1);
        pm.addParcel(p2);

        System.out.println("Teste feito 1");
        // ----------------------------------------------------------

        pm.printAllParcels();

        System.out.println("Teste feito 2");
        // ----------------------------------------------------------
        System.out.println(pm.getParcel(1));
        System.out.println(pm.calculateShippingCost(1));
        System.out.println(pm.getParcel(2));
        System.out.println(pm.calculateShippingCost(2));
        System.out.println(pm.getParcel(30));              // não existe!
        System.out.println(pm.calculateShippingCost(30));  // não existe!

        System.out.println("Teste feito 3");
        // ----------------------------------------------------------

        pm.readFile("encomendas.txt");
        pm.printAllParcels();

        System.out.println("Teste feito 4");
        // ----------------------------------------------------------
        System.out.println(pm.getParcel(1));
        System.out.println(pm.calculateShippingCost(1));
        System.out.println(pm.getParcel(2));
        System.out.println(pm.calculateShippingCost(2));
        System.out.println(pm.getParcel(30));
        System.out.println(pm.calculateShippingCost(30));

        System.out.println("Teste feito 5");
        // ----------------------------------------------------------

        pm.writeFile("resultado.txt");

        System.out.println("Teste feito 6");
    }
}
