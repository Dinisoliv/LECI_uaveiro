package aula08;

public abstract class Veiculo implements KmPercorridosInterface {
    private String matricula;
    private String marca;
    private String modelo;
    private int potencia;
    private int numeroQuadro;
    private int ultimoTrajeto;
    private int distanciaTotal;

    public Veiculo(String matricula, String marca, String modelo, int potencia){
        if (matricula.matches("\\w{6}") || matricula.matches("\\w{2}-\\w{2}-\\w{2}")) {
            this.matricula = matricula;
        }
        this.marca = marca;
        this.modelo = modelo;
        this.potencia = potencia;
    }

    public Veiculo(String matricula, String marca, String modelo, int potencia, int numeroQuadro){
        this.matricula = matricula;
        this.marca = marca;
        this.modelo = modelo;
        this.potencia = potencia;
        this.numeroQuadro = numeroQuadro;
    }

    public String getMatricula() {
        return matricula;
    }

    public String getMarca() {
        return marca;
    }

    public String getModelo() {
        return modelo;
    }

    public int getPotencia() {
        return potencia;
    }

    public int getNumeroQuadro(){
        return numeroQuadro;
    }

    public double getDistanciaTotal(){
        return distanciaTotal;
    }

    public double getUltimoTrajeto(){
        return ultimoTrajeto;
    }

    @Override
    public void trajeto(int quilometros){
        this.distanciaTotal += quilometros;
        this.ultimoTrajeto = quilometros;
    }

    @Override
    public int ultimoTrajeto(){
        return this.ultimoTrajeto;
    }

    @Override
    public int distanciaTotal(){
        return this.distanciaTotal;
    }
}
