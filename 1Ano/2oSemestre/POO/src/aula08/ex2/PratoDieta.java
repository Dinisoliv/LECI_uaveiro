package aula08.ex2;

import java.util.HashSet;
import java.util.Set;

public class PratoDieta extends Prato {
    private Set<Alimento> composicaoPratoDieta;
    private double limiteCalorias;
    private double calorias;

    public PratoDieta(String nome, double limiteCalorias){
        super(nome);
        clearHashSet();
        this.composicaoPratoDieta = new HashSet<>();
        this.limiteCalorias = limiteCalorias;
        this.calorias = 0;
    }

    public Set<Alimento> getComposicaoPratoDieta(){
        return composicaoPratoDieta;
    }

    public double getLimiteCalorias(){
        return limiteCalorias;
    }

    @Override
    public boolean addIngrediente(Alimento alimento){
        if (calorias + alimento.getCalorias() >= limiteCalorias) {
            composicaoPratoDieta.add(alimento);
            calorias =+ alimento.getCalorias();
            return true;
        }
        else{
            System.out.println("Cannot add ingredient. Exceeds calorie limit.");
            return false;
        }
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Alimentos que compoẽm o prato \n");
        for (Alimento alimento : composicaoPratoDieta) {
            sb.append(alimento).append("\n");
        }
        return sb.toString();
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
        PratoDieta prato = (PratoDieta) obj;

        if (!composicaoPratoDieta.equals(prato.composicaoPratoDieta)) {
            return false;
        }
        return true;
    }
}
