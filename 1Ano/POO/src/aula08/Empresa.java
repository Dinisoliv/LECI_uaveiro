package aula08;

import java.util.ArrayList;

public class Empresa {
    private String nome;
    private String codigoPostal;
    private String email;
    private ArrayList<Veiculo> conjuntoveiculos;

    public Empresa(String nome, String codigoPostal, String email){
        this.nome = nome;
        this.codigoPostal = codigoPostal;
        this.email = email;
        this.conjuntoveiculos = new ArrayList<>();
    }

    public String getNome() {
        return nome;
    }

    public String getCodigo() {
        return codigoPostal;
    }

    public String getEmail() {
        return email;
    }

    public ArrayList<Veiculo> getConjunto() {
        return conjuntoveiculos;
    }

    public void adicionarViatura(Veiculo veiculo){
        conjuntoveiculos.add(veiculo);
    }

    @Override
    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append("Empresa: ").append(nome).append(", Código Postal: ").append(codigoPostal).append(", Email: ").append(email).append("\n");
        for (Veiculo veiculo : conjuntoveiculos) {
            sb.append(veiculo.toString()).append("\n");
        }
        return sb.toString();
    }
}
