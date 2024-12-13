package aula08.ex2;

import java.util.HashSet;
import java.util.Set;

public class PratoVegetariano extends Prato{
    private Set<Vegetariano> composicaoPratoVegetariano;
    private double calorias;

    public PratoVegetariano(String nome){
        super(nome);
        clearHashSet();
        this.composicaoPratoVegetariano = new HashSet<>();
        this.calorias = 0;
    }

    public Set<Vegetariano> getComposicaoPratoVegetariano(){
        return composicaoPratoVegetariano;
    }

    public double getCalorias(){
        return calorias;
    }

    public void addIngrediente(Vegetariano alimento){
        composicaoPratoVegetariano.add(alimento);
        calorias += alimento.getCalorias();
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Alimentos que compoẽm o prato \n");
        for (Vegetariano alimento : composicaoPratoVegetariano) {
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
        PratoVegetariano prato = (PratoVegetariano) obj;

        if (!composicaoPratoVegetariano.equals(prato.composicaoPratoVegetariano)) {
            return false;
        }
        return true;
    }
}