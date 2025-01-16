package aula08.ex2;

import java.util.HashSet;
import java.util.Set;

public class Prato {
    private String nome;
    private Set<Alimento> composicaoPrato;
    private double calorias;

    public Prato(String nome){
        this.nome = nome;
        this.composicaoPrato = new HashSet<>();
        this.calorias = 0;
    }

    public String getNome(){
        return nome;
    }

    public double getCalorias(){
        return calorias;
    }

    public Set<Alimento> getComposicaoPrato(){
        return composicaoPrato;
    }

    public void clearHashSet() {
        composicaoPrato.clear();
    }

    public boolean addIngrediente(Alimento alimento){
        composicaoPrato.add(alimento);
        calorias += alimento.getCalorias();
        return true;
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Alimentos que compoẽm o prato \n");
        for (Alimento alimento : composicaoPrato) {
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
        Prato prato = (Prato) obj;

        if (!nome.equals(prato.nome)) {
            return false;
        }
        return true;
    }
}
