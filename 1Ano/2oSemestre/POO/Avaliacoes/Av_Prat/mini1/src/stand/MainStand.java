package stand;

import java.util.Scanner;

public class MainStand {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        Stand stand = new Stand(100);
        int opcao = 0;
        do {
            System.out.println("\nMenu:");
            System.out.println("1. Adicionar um veiculo");
            System.out.println("2. Listar veiculos");
            System.out.println("3. Vender um veiculo");
            System.out.println("4. Calcular o lucro total");
            System.out.println("5. Sair");
            System.out.print("Opçao: ");
            opcao = sc.nextInt();
            switch (opcao) {
                case 1:
                    System.out.println("\n1. Adicionar um veiculo do tipo");
                    System.out.println("1. Passageiros");
                    System.out.println("2. Comercial");
                    System.out.println("3. Motorizada");
                    System.out.print("Tipo de produto: ");
                    int opcaoVeiculo = sc.nextInt();
                    sc.nextLine();
                    switch (opcaoVeiculo) {
                        case 1:
                            System.out.println("Marca: ");
                            String marca = sc.nextLine();
                            System.out.println("Modelo: ");
                            String modelo = sc.nextLine();
                            System.out.println("Preço base: ");
                            double precoBase = sc.nextDouble();
                            System.out.println("Número de passageiros: ");
                            int numeroPassageiros = sc.nextInt();
                            System.out.println("Tipo de motorização: ");
                            String tipoMotorizacao = sc.nextLine();
                            System.out.println("Potência: ");
                            double potencia = sc.nextDouble();
                            VeiculoPassageiros passageiros = new VeiculoPassageiros(marca, modelo, precoBase, numeroPassageiros, tipoMotorizacao, potencia);
                            break;
                        case 2:
                            // Adicionar Veiculo Comercial
                            break;
                        case 3:
                            // Adicionar Motorizada;
                            break;
                    }
                    break;
                case 2:
                    System.out.println(Stand);
                    break;
                case 3:
                    System.out.println("Identificador interno do veiculo que pretende vender: ");
                    int identificadorInterno = sc.nextInt();
                    System.out.println("Preço: ");
                    double preco = sc.nextDouble;
                    stand.venderVeiculo(identificadorInterno, preco);
                    break;
                case 4:
                    // Apresentar o Lucro Total
                    break;
                case 5:
                    System.out.println("5. Sair");
                    sc.close();
                    break;
            }
        } while (opcao != 5);
    }
}
