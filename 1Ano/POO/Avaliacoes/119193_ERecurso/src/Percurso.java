import java.util.List;
import java.util.ArrayList;

public class Percurso {
    private String nome;
    private int preco;
    private Transporte transporte;
    private List<Local> locais;

    public Percurso(String nome, int preco, Transporte transporte) {
        this.nome = nome;
        this.preco = preco;
        this.transporte = transporte;
        this.locais = new ArrayList<>();
    }

    public Percurso(String nome, int preco, Transporte transporte, List<Local> locais) {
        this.nome = nome;
        this.preco = preco;
        this.transporte = transporte;
        this.locais = locais;
    }

    public String getNome() {
        return nome;
    }

    public double getPreco() {
        return preco;
    }

    public Transporte getTransporte() {
        return transporte;
    }

    public List<Local> getLocais() {
        return locais;
    }

    public void add(Local local){
        for (Local i : locais) {
            if (i.equals(local)) {
                return;
            }
        }
        locais.add(local);
    }

    

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((nome == null) ? 0 : nome.hashCode());
        result = prime * result + preco;
        result = prime * result + ((transporte == null) ? 0 : transporte.hashCode());
        result = prime * result + ((locais == null) ? 0 : locais.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Percurso other = (Percurso) obj;
        if (nome == null) {
            if (other.nome != null)
                return false;
        } else if (!nome.equals(other.nome))
            return false;
        if (preco != other.preco)
            return false;
        if (transporte != other.transporte)
            return false;
        if (locais == null) {
            if (other.locais != null)
                return false;
        } else if (!locais.equals(other.locais))
            return false;
        return true;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(nome).append(", ").append(preco).append("€/pessoa, em ").append(transporte.toString()).append(": ");
        for (int i = 0; i < locais.size(); i++) {
            sb.append(locais.get(i));
            if (i + 1 < locais.size()) {
                sb.append(" -> ");
            }
        }
        sb.append("\n");
        return sb.toString();
    }
    
}
