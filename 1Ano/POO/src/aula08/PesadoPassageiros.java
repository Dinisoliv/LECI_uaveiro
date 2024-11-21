package aula08;

public class PesadoPassageiros extends Pesado{
    private int numMaxPassgeiros;

    public PesadoPassageiros(String matricula, String marca, String modelo, int potencia, int numeroQuadro, double peso, int numMaxPassageeiros){
        super(matricula, marca, modelo, potencia, numeroQuadro, peso);
        this.numMaxPassgeiros = numMaxPassageeiros;
    }

    public int getMaxPassageiros(){
        return numMaxPassgeiros;
    }

    @Override
    public String toString() {
        return "Matricula: " + getMatricula() + ", Marca: " + getMarca() + ", Modelo: " + getModelo() + ", Potencia: " + getPotencia() + ", Nº Quadro: " + getNumeroQuadro() + ", Peso: " + getPeso() + ", Numero Max Passageiros: " + getMaxPassageiros();
    }
}
