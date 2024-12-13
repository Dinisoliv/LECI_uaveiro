package aula08;

public class LigeiroEletrico extends Ligeiro implements VeiculoEletrico{
    private int cargaBateria;

    public LigeiroEletrico(String matricula, String marca, String modelo, int potencia,  int numquadro, double capacidadeBagageira){
        super(matricula, marca, modelo, potencia, numquadro, capacidadeBagageira);
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

    public void percurso(int kms, double percentagePerKm){
        this.cargaBateria -= kms * percentagePerKm;
    }

}
