package aula08.ex2;

public class Legume extends Vegetariano{

    public Legume(double proteinas, double calorias, double peso, String nome){
        super(proteinas, calorias, peso, nome);
    }

    @Override
    public String toString(){
        return "Legume: " + super.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (!super.equals(obj)) {
            return false;
        }
        if (!(obj instanceof Legume)) {
            return false;
        }
        return true;
    }
}
