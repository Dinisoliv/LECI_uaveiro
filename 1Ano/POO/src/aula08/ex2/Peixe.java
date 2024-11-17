package aula08.ex2;

public class Peixe extends Alimento{
    private TipoPeixe tipoPeixe;

    public Peixe(double proteinas, double calorias, double peso, TipoPeixe tipoPeixe){
        super(proteinas, calorias, peso);
        this.tipoPeixe = tipoPeixe;
    }

    public TipoPeixe getTipo(){
        return tipoPeixe;
    }

    @Override
    public String toString() {
        return "Peixe: " + tipoPeixe + super.toString();
    }

    @Override
    public boolean equals(Object obj){
        if (!super.equals(obj)) {
            return false;
        }
        if (!(obj instanceof Peixe)) {
            return false;
        }
        Peixe peixe = (Peixe) obj;
        
        if (!tipoPeixe.equals(peixe.tipoPeixe)) {
            return false;
        }
        return true;
    }
}
