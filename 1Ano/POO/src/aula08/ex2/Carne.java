package aula08.ex2;

public class Carne extends Alimento{
    private VariedadeCarne variedadeCarne;

    public Carne(double proteinas, double calorias, double peso, VariedadeCarne variedadeCarne){
        super(proteinas, calorias, peso);
        this.variedadeCarne = variedadeCarne;
    }

    public VariedadeCarne getVariedadeCarne(){
        return variedadeCarne;
    }

    @Override
    public String toString() {
        return "Carne: " + variedadeCarne + super.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (!super.equals(obj)) {
            return false;
        }
        if (!(obj instanceof Carne)) {
            return false;
        }
        Carne carne = (Carne) obj;
        
        if (!variedadeCarne.equals(carne.variedadeCarne)) {
            return false;
        }
        return true;
    }
}