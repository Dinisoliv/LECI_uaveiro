package aula08;

public abstract class Pesado extends Veiculo {
    private double peso;

    public Pesado(String matricula, String marca, String modelo, int potencia, int numeroQuadro, double peso){
        super(matricula, marca, modelo, potencia, numeroQuadro);
        this.peso = peso;
    }

    public double getPeso(){
        return peso;
    }
}
