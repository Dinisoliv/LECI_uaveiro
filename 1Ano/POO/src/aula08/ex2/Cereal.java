package aula08.ex2;

public class Cereal extends Vegetariano {
    
    public Cereal(double proteinas, double calorias, double peso, String nome){
        super(proteinas, calorias, peso, nome);
    }

    @Override
    public String toString(){
        return "Cereal: " + super.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (!super.equals(obj)) {
            return false;
        }
        if (!(obj instanceof Cereal)) {
            return false;
        }
        return true;
    }
}
