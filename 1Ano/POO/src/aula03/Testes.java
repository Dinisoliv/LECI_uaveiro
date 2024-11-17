package aula03;

import java.util.Scanner;

public class Testes {
    public static final Scanner scanner = new Scanner(System.in);
    public static void main(String[] args) {
        String data;
        int mes, ano, diaSemana;

        // Leitura da data do teclado
        data = lerData();
        mes = Integer.parseInt(data.substring(0, 2));
        ano = Integer.parseInt(data.substring(3));
        diaSemana = lerDiaSemana();

        // Impressão do calendário
        imprimirCalendario(mes, ano, diaSemana);
    }

    // Função para ler a data no formato mm/yyyy
    private static String lerData() {
        String data;

        do {
            System.out.print("Digite a data (mm/yyyy): ");
            data = scanner.nextLine();
        } while (!validarData(data));

        return data;
    }

    // Função para validar a data no formato mm/yyyy
    private static boolean validarData(String data) {
        return data.matches("^(0[1-9]|1[0-2])/(\\d{4})$");
    }

    // Função para ler o dia da semana com validação
    private static int lerDiaSemana() {
        int diaSemana;

        do {
            System.out.print("Digite o dia da semana (1-7): ");
            diaSemana = scanner.nextInt();
        } while (diaSemana < 1 || diaSemana > 7);

        return diaSemana;
    }

    // Função para calcular o número de dias no mês
    private static int calcularDiasNoMes(int mes, int ano) {
        int[] diasNoMes = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        if (mes == 2 && anoBissexto(ano)) {
            return 29;
        } else {
            return diasNoMes[mes];
        }
    }

    // Função para verificar se o ano é bissexto
    private static boolean anoBissexto(int ano) {
        return (ano % 4 == 0 && ano % 100 != 0) || (ano % 400 == 0);
    }

    // Função para imprimir o calendário
    private static void imprimirCalendario(int mes, int ano, int diaSemana) {
        System.out.println(getNomeMes(mes) + " " + ano);
        System.out.println("Su Mo Tu We Th Fr Sa");

        // Adjust starting position for Sunday
        if (diaSemana == 7) {
            diaSemana = 0; // Reset to 0 for easier calculation
        }

        // Espaços iniciais para posicionar o dia da semana
        for (int i = 0; i < diaSemana; i++) {
            System.out.print("   ");
        }

        int diasNoMes = calcularDiasNoMes(mes, ano);

        for (int dia = 1; dia <= diasNoMes; dia++) {
            System.out.printf("%2d ", dia);

            // Quebra de linha no final da semana
            if ((dia + diaSemana - 1) % 7 == 0 || dia == diasNoMes) {
                System.out.println();
            }
        }
    }

    // Função para obter o nome do mês
    private static String getNomeMes(int mes) {
        String[] nomesMeses = {"", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        return nomesMeses[mes];
    }
}
