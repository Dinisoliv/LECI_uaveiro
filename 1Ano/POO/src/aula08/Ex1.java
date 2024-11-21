package aula08;

import java.util.Random;

public class Ex1 {
    public static void main(String[] args) {

        //Adicionar um veiculo de cada tipo
        Empresa empresa = new Empresa("AlugaCar", "12345", "contato@alugacar.com");
        Motociclo moto = new Motociclo("123ABC", "Honda", "X", 100, "desportivo");
        Ligeiro carro = new Ligeiro("456DEF", "Toyota", "Corolla", 150, 78, 500);
        Taxi taxi = new Taxi("789GHI", "Ford", "Fiesta", 120, 34, 400, 123);
        PesadoMercadorias camiao = new PesadoMercadorias("101JKL", "Volvo", "FH16", 600, 90, 10, 20.5);
        PesadoPassageiros bus = new PesadoPassageiros("111MNO", "Mercedes", "Sprinter", 300, 56, 8, 30);
        LigeiroEletrico carroEletrico = new LigeiroEletrico("789EFG", "Tesla", "Model S", 500, 24, 400);
        PesadoPassageirosEletrico busEletrico = new PesadoPassageirosEletrico("222PQR", "BYD", "eBus", 400, 35, 10, 40);

        empresa.adicionarViatura(moto);
        empresa.adicionarViatura(carro);
        empresa.adicionarViatura(taxi);
        empresa.adicionarViatura(camiao);
        empresa.adicionarViatura(bus);
        empresa.adicionarViatura(carroEletrico);
        empresa.adicionarViatura(busEletrico);

        //Dar print a todos os veiculos na empresa

        System.out.println(empresa);

        //Teste de ordenar veiculos potencia

        int numviaturas = empresa.getConjunto().size();

        Veiculo[] potenciaSorted = new Veiculo[numviaturas];

        Veiculo[] veiculos = new Veiculo[numviaturas];

        for (int i = 0; i < empresa.getConjunto().size(); i++) {
            veiculos[i] = empresa.getConjunto().get(i);
        }

        int potenciaMin = Integer.MAX_VALUE;
        int indexToChange = -1;
        
        while (numviaturas > 0) {
            for (int i = 0; i < veiculos.length; i++) {
                if (veiculos[i] != null) {
                    if (veiculos[i].getPotencia() < potenciaMin) {
                        potenciaMin = veiculos[i].getPotencia();
                        indexToChange = i;
                    }
                }
            }
            potenciaSorted[numviaturas - 1] = veiculos[indexToChange];
            veiculos[indexToChange] = null;
            numviaturas--;
            potenciaMin = Integer.MAX_VALUE;
        }

        for (Veiculo veiculo : potenciaSorted) {
            System.out.println(veiculo);
        }

        //Teste de aicionar trajetos
        Random random = new Random();

        for (int i = 0; i < 5; i++) {
            int randomNumber = random.nextInt(10) + 1;
            carro.trajeto(randomNumber);
            System.out.println(randomNumber);
        }

        System.out.println(carro.ultimoTrajeto());

        System.out.println(carro.distanciaTotal());

        //Gestão da carga da bateria de um carro elétrico

        System.out.println(carroEletrico.autonomia());

        carroEletrico.percurso(50, 0.5);

        System.out.println(carroEletrico.autonomia());

        carroEletrico.carregar(92);

        System.out.println(carroEletrico.autonomia());
    }
}
