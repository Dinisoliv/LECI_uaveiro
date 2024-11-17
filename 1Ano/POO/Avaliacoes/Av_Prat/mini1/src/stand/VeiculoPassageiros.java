package stand;

public class VeiculoPassageiros extends Veiculo {
    private int numeroPassageiros;
    private String tipoMotorizacao;
    private double potencia;

    public VeiculoPassageiros(String marca, String modelo, double precoBase, int numeroPassageiros, String tipoMotorizacao, double potencia){
        super(marca, modelo, precoBase);
        this.numeroPassageiros = numeroPassageiros;
        if (!(tipoMotorizacao.equalsIgnoreCase("gasolina") || tipoMotorizacao.equalsIgnoreCase("gasóleo") 
        || tipoMotorizacao.equalsIgnoreCase("GPL") || tipoMotorizacao.equalsIgnoreCase("híbrido") || 
        tipoMotorizacao.equalsIgnoreCase("elétrico"))) {
            throw new IllegalArgumentException("Tipo de motorização errada");
        }
        this.tipoMotorizacao = tipoMotorizacao;
        this.potencia = potencia;
    }

    public int getNumeroPassageiros(){
        return numeroPassageiros;
    }

    public String getTipoMotorizacao(){
        return tipoMotorizacao;
    }

    public double getPotencia(){
        return potencia;
    }

    public void setNumeroPassageiros(int numeroPassageiros) {
        this.numeroPassageiros = numeroPassageiros;
    }

    public void setTipoMotorizacao(String tipoMotorizacao) {
        this.tipoMotorizacao = tipoMotorizacao;
    }

    public void setPotencia(double potencia) {
        this.potencia = potencia;
    }

    public String toString() {
        return "Marca: " + getMarca() + "\n" +
               "Modelo: " + getModelo() + "\n" +
               "Preço Base: " + getPrecoBase() + "\n" +
               "Número de Passageiros: " + numeroPassageiros + "\n" +
               "Tipo de Motorização: " + tipoMotorizacao + "\n" +
               "Potência: " + potencia;
    }
    
}

