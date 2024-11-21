package aula09;

public class CommercialPlane extends Plane {
    private int numCrew;

    public CommercialPlane(String identifier, String producer, String model, int year, int maxPassengers, int maxSpeed, int numCrew){
        super(identifier, producer, model, year, maxPassengers, maxSpeed);
        this.numCrew = numCrew;
    }

    public int getNumCrew() {
        return numCrew;
    }

    public void setNumCrew(int numCrew) {
        this.numCrew = numCrew;
    }

    @Override
    public String toString() {
        return "Comercial " + super.toString() + " [numCrew=" + numCrew + "]";
    }

    
}
