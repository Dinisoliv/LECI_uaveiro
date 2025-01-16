package aula08.ex2;

public class Vegetariano extends Alimento {
    private String nome;

    public Vegetariano(double proteinas, double calorias, double peso, String nome){
        super(proteinas, calorias, peso);
        this.nome = nome;
    }

    @Override
    public String toString() {
        return "Proteína: " + getProteinas() + " , Calorias: " + getCalorias() + " , Peso: " + getPeso() + ", Nome: " + nome;
    }

    @Override
    public boolean equals(Object obj){
        if (!super.equals(obj)) {
            return false;
        }
        if (!(obj instanceof Vegetariano)) {
            return false;
        }
        Vegetariano vegetariano = (Vegetariano) obj;
        
        if (!nome.equals(vegetariano.nome)) {
            return false;
        }
        return true;
    }
}
