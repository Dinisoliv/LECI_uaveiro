package aula08;

public class Taxi extends Ligeiro{
    private int numLicenca;

    public Taxi(String matricula, String marca, String modelo, int potencia, int numquadro, double capacidadeBagageira, int numLicenca){
        super(matricula, marca, modelo, potencia, numquadro, capacidadeBagageira);
        this.numLicenca = numLicenca;
    }

    public int getNumLicenca(){
        return numLicenca;
    }

    public String toString() {
        return "Matricula: " + getMatricula() + ", Marca: " + getMarca() + ", Modelo: " + getModelo() + ", Potencia: " + getPotencia() + ", Nº Quadro: " + getNumeroQuadro() + ", Capacidade Bagageira: " + getCapacidadeBagageira() + ", Nº Licença: " + getNumLicenca();
    }

}
