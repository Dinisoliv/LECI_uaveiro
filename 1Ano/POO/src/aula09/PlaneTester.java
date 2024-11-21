package aula09;

public class PlaneTester {
    public static void main(String[] args) {
        PlaneManager manager = new PlaneManager();

        CommercialPlane commercialPlane1 = new CommercialPlane("CP001", "Boeing", "747", 2000, 300, 900, 10);
        CommercialPlane commercialPlane2 = new CommercialPlane("CP002", "Airbus", "A320", 2010, 150, 800, 8);
        MilitaryPlane militaryPlane1 = new MilitaryPlane("MP001", "Lockheed Martin", "F-22", 2005, 1, 1500, 50);

        manager.addPlane(commercialPlane1);
        manager.addPlane(commercialPlane2);
        manager.addPlane(militaryPlane1);

        System.out.println("All planes:");
        manager.printAllPlanes();

        System.out.println("\nCommercial planes:");
        for (CommercialPlane plane : manager.getCommercialPlanes()) {
            System.out.println(plane);
        }

        System.out.println("\nMilitary planes:");
        for (MilitaryPlane plane : manager.getMilitaryPlanes()) {
            System.out.println(plane);
        }

        System.out.println("\nFastest plane:");
        System.out.println(manager.getFastestPlane());
    }
}