package aula08;

public class PesadoMercadorias extends Pesado{
    private double cargaMaxima;

    public PesadoMercadorias(String matricula, String marca, String modelo, int potencia, int numeroQuadro, double peso, double cargaMaxima){
        super(matricula, marca, modelo, potencia, numeroQuadro, peso);
        this.cargaMaxima = cargaMaxima;
    }

    public double getCargaMaxima(){
        return cargaMaxima;
    }

    @Override
    public String toString() {
        return "Matricula: " + getMatricula() + ", Marca: " + getMarca() + ", Modelo: " + getModelo() + ", Potencia: " + getPotencia() + ", Nº Quadro: " + getNumeroQuadro() + ", Peso: " + getPeso() + ", Carga Máxima: " + getCargaMaxima();
    }
}
