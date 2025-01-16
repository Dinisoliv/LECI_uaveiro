package stand;

import java.util.Scanner;

public class Stand {
    public static final Scanner sc = new Scanner(System.in);

    private int capacidade;
    private Veiculo[] veiculos;

    public Stand(int capacidade){
        this.capacidade = capacidade;
        this.veiculos = new Veiculo[capacidade];
    }

    public int getCapacidade(){
        return capacidade;
    }

    public Veiculo[] getVeiculos(){
        return veiculos;
    }

    public String toString(){
        StringBuilder result = new StringBuilder();
        result.append("Veículos no stand:\n");
        for (Veiculo veiculo : veiculos) {
            if (veiculo != null) {
                result.append(veiculo.toString()).append("\n");
            }
        }
        return result.toString();
    }

    public double venderVeiculo(int identificadorInterno, double preco){
        for (int i = 0; i < veiculos.length; i++) {
            if (veiculos[i].getCodigoIdentificador() == identificadorInterno && veiculos[i] != null) {
                veiculos[i] = null;
                System.out.println("Veiculo vendido com sucesso");
                double margemLucro = preco - veiculos[i].getPrecoBase();
                return margemLucro;
            }
        }
        System.out.println("Veiculo nao encontrado");
        return 0;
    }


    public double lucroTotal(double margemLucro, double lucroTotal){
        return margemLucro + lucroTotal;
    }

    public void adicionarVeiculoPassageiros(Veiculo[] veiculos, VeiculoPassageiros novoVeiculo){
        for (Veiculo veiculo : veiculos) {
            if (veiculo == null) {
                veiculo = novoVeiculo;
            }
        }
    }

    public void adicionarVeiculoComercial(Veiculo[] veiculos, VeiculoComercial novoVeiculo){
        for (Veiculo veiculo : veiculos) {
            if (veiculo == null) {
                veiculo = novoVeiculo;
            }
        }
    }

    public void adicionarMotorizada(Veiculo[] veiculos, Motorizada novoVeiculo){
        for (Veiculo veiculo : veiculos) {
            if (veiculo == null) {
                veiculo = novoVeiculo;
            }
        }
    }
    
}
