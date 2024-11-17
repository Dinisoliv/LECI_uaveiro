package aula08.ex2;

import java.util.HashSet;
import java.util.Set;

public class Ementa {
    private String nome;
    private String local;
    private Set<Prato> ementaLista;

    public Ementa(String nome, String local){
        this.nome = nome;
        this.local = local;
        ementaLista = new HashSet<>();
    }

    public String getNome(){
        return nome;
    }

    public String getLocal(){
        return local;
    }

    public Set<Prato> getEmentaLista(){
        return ementaLista;
    }

    public void addPrato(Prato prato, DiaSemana diaSemana){
        ementaLista.add(prato);
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        for (Prato prato : ementaLista) {
            sb.append(prato).append(", ");
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
        Ementa ementa = (Ementa) obj;
        
        if (!ementaLista.equals(ementa.ementaLista)) {
            return false;
        }
        return true;
    }
 
}
