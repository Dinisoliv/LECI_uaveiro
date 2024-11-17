package stand;

public class VeiculoComercial extends Veiculo {
    private String formato;
    private double capacidadeCarga;
    private String unidadeCarga;

    public VeiculoComercial(String marca, String modelo, double precoBase, String formato, double capacidadeCarga, String unidadeCarga){
        super(marca, modelo, precoBase);
        this.formato = formato;
        this.capacidadeCarga = capacidadeCarga;
        this.unidadeCarga = unidadeCarga;
    }

    public String getFormato(){
        return formato;
    } 

    public double getCapacidadeCarga(){
        return capacidadeCarga;
    }

    public String getUnidadeCarga(){
        return unidadeCarga;
    }

    public void setFormato(String formato) {
        this.formato = formato;
    }

    public void setCapacidadeCarga(double capacidadeCarga) {
        this.capacidadeCarga = capacidadeCarga;
    }

    public void setUnidadeCarga(String unidadeCarga) {
        this.unidadeCarga = unidadeCarga;
    }

    public String toString() {
        return "Marca: " + getMarca() + "\n" +
               "Modelo: " + getModelo() + "\n" +
               "Preço Base: " + getPrecoBase() + "\n" +
               "Formato: " + formato + "\n" +
               "Capacidade de Carga: " + capacidadeCarga + " " + unidadeCarga;
    }

}
