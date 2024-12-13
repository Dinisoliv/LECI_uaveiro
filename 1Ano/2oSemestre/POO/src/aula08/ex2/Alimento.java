package aula08.ex2;

public class Alimento {
    private double proteinas;
    private double calorias;
    private double peso;

    public Alimento(double proteinas, double calorias, double peso){
        this.proteinas = proteinas;
        this.calorias = calorias;
        this.peso = peso;
    }

    public double getProteinas(){
        return proteinas;
    }

    public double getCalorias(){
        return calorias;
    }

    public double getPeso(){
        return peso;
    }

    @Override
    public String toString() {
        return "Proteína: " + proteinas + " , Calorias: " + calorias + " , Peso: " + peso;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        long temp;
        temp = Double.doubleToLongBits(proteinas);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(calorias);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(peso);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj){
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }

        Alimento alimento = (Alimento) obj;
        
        if (proteinas != alimento.proteinas) {
            return false;
        }
        if (calorias != alimento.calorias) {
            return false;
        }
        if (peso != alimento.peso) {
            return false;
        }
        return true;
    }

    
}
