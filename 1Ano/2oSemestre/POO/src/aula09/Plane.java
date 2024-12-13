package aula09;

public class Plane {
    /*
• Identificador único (String)
• Fabricante (String)
• Modelo (String)
• Ano de produção (int)
• Número máximo de passageiros (int)
• Velocidade máxima (int)
     */
    private String id;
    private String producer;
    private String model;
    private int year;
    private int maxPassengers;
    private int maxSpeed;

    public Plane(String id, String producer, String model, int year, int maxPassengers, int maxSpeed) {
        this.id = id;
        this.producer = producer;
        this.model = model;
        this.year = year;
        this.maxPassengers = maxPassengers;
        this.maxSpeed = maxSpeed;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMaxPassengers() {
        return maxPassengers;
    }

    public void setMaxPassengers(int maxPassengers) {
        this.maxPassengers = maxPassengers;
    }

    public int getMaxSpeed() {
        return maxSpeed;
    }

    public void setMaxSpeed(int maxSpeed) {
        this.maxSpeed = maxSpeed;
    }

    @Override
    public String toString() {
        return "Plane [identifier=" + id + ", producer=" + producer + ", model=" + model + ", year=" + year
                + ", maxPassengers=" + maxPassengers + ", maxSpeed=" + maxSpeed + "]";
    }

    

    


}
