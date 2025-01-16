package stand;

public class Motorizada extends Veiculo{
    private int numeroRodas;
    private double velocidadeMaxima;

    public Motorizada(String marca, String modelo, double precoBase, int numeroRodas, double velocidadeMaxima){
        super(marca, modelo, precoBase);
        this.numeroRodas = numeroRodas;
        this.velocidadeMaxima = velocidadeMaxima;
    }
    
    public int getNumeroRodas() {
        return numeroRodas;
    }

    public double getVelocidadeMaxima() {
        return velocidadeMaxima;
    }

    public void setNumeroRodas(int numeroRodas) {
        this.numeroRodas = numeroRodas;
    }

    public void setVelocidadeMaxima(double velocidadeMaxima) {
        this.velocidadeMaxima = velocidadeMaxima;
    }

    public String toString() {
        return "Marca: " + getMarca() + "\n" +
               "Modelo: " + getModelo() + "\n" +
               "Preço Base: " + getPrecoBase() + "\n" +
               "Número de Rodas: " + numeroRodas + "\n" +
               "Velocidade Máxima: " + velocidadeMaxima;
    }
}
