package aula08;

public class Ligeiro extends Veiculo{    
    private double capacidadeBagageira;

    public Ligeiro(String matricula, String marca, String modelo, int potencia,  int numquadro, double capacidadeBagageira){
        super(matricula, marca, modelo, potencia, numquadro);
        this.capacidadeBagageira = capacidadeBagageira;
    }

    public double getCapacidadeBagageira(){
        return capacidadeBagageira;
    }

    @Override
    public String toString() {
        return "Matricula: " + getMatricula() + ", Marca: " + getMarca() + ", Modelo: " + getModelo() + ", Potencia: " + getPotencia() + ", Nº Quadro: " + getNumeroQuadro() + ", Capacidade Bagageira: " + getCapacidadeBagageira();
    }

}
