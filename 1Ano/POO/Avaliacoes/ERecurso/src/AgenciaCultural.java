import java.util.HashSet;
import java.util.Set;

public class AgenciaCultural implements Listavel{
    private String name;
    private String endereco;
    private Set<Percurso> percursos;

    public AgenciaCultural(String name, String endereco) {
        this.name = name;
        this.endereco = endereco;
        this.percursos = new HashSet<Percurso>();
    }

    public String getName() {
        return name;
    }

    public String getEndereco() {
        return endereco;
    }

    public Set<Percurso> getPercursos() {
        return percursos;
    }

    public HashSet<String> percursos(){
        HashSet<String> percursosString = new HashSet<>();
        for (Percurso percurso : percursos) {
            percursosString.add(percurso.toString());
        }
        return percursosString;
    }

    public void add(Percurso percurso){
        percursos.add(percurso);
    }

    public long totalSitiosCulturais(){
        return percursos.stream()
            .filter(n -> n.getClass().getName().equals("SitioCultural")) //TODO: Not the right output
            .count();
    }

    @Override
    public String toString() {
        return "Agência Cultural " + name +  ": " + percursos.size() + " percursos disponíveis";
    }
}
