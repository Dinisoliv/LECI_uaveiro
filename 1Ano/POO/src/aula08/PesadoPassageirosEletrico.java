package aula08;

public class PesadoPassageirosEletrico extends PesadoPassageiros implements VeiculoEletrico{
    private int cargaBateria;

    public PesadoPassageirosEletrico(String matricula, String marca, String modelo, int potencia, int numeroQuadro, double peso, int numMaxPassageeiros){
        super(matricula, marca, modelo, potencia, numeroQuadro, peso, numMaxPassageeiros);
        this.cargaBateria = 100;
    }

    @Override
    public int autonomia(){
        return cargaBateria;
    }

    @Override
    public void carregar(int percentagem){
        cargaBateria = Math.min(100, percentagem);
    }
}
