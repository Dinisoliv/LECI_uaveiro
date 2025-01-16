package stand;

public class Veiculo {
    private String marca;
    private String modelo;
    private double precoBase;
    private int codigoIdentificador;
    private int codigoIdentificadorSeguinte = 1000;

    public Veiculo(String marca, String modelo, double precoBase){
    this.marca = marca;
    this.modelo = modelo;
    this.precoBase = precoBase;
    this.codigoIdentificador = codigoIdentificadorSeguinte++;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public double getPrecoBase() {
        return precoBase;
    }

    public void setPrecoBase(double precoBase) {
        this.precoBase = precoBase;
    }

    public int getCodigoIdentificador() {
        return codigoIdentificador;
    }
}