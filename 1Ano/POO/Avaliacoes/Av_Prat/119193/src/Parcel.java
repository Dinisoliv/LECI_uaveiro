public class Parcel {
    private int id;
    private double peso;
    private String destino;
    private String rementente;
    private static int nextId = 1;

    public Parcel(String destino, String rementente, double peso) {
        this.id = nextId;
        nextId++;
        this.destino = destino;
        this.rementente = rementente;
        this.destino = destino;
    }

    
    public int getId() {
        return id;
    }

    public double getPeso() {
        return peso;
    }

    public String getDestino() {
        return destino;
    }

    public String getRementente() {
        return rementente;
    }


    public void setId(int id) {
        this.id = id;
    }

    public static void setNextId(int nextId){
        nextId = nextId;
    }

    @Override
    public String toString() {
        return "Parcel [id=" + id + ", peso=" + peso + ", destino=" + destino + ", rementente=" + rementente + "]";
    }
}