package aula09;

public class MilitaryPlane extends Plane{
    private int numArming;

    public MilitaryPlane(String identifier, String producer, String model, int year, int maxPassengers, int maxSpeed,
            int numArming) {
        super(identifier, producer, model, year, maxPassengers, maxSpeed);
        this.numArming = numArming;
    }

    public int getNumArming() {
        return numArming;
    }

    public void setNumArming(int numArming) {
        this.numArming = numArming;
    }

    @Override
    public String toString() {
        return "Military" + super.toString() + "[numArming=" + numArming + "]";
    }

    
}
