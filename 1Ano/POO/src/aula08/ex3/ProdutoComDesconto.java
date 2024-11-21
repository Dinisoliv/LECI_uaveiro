package aula08.ex3;

public class ProdutoComDesconto implements Produto {
    private String nome;
    private double preco;
    private int quantidade;
    private int desconto;
    
    public ProdutoComDesconto(String nome, double preco, int quantidade, int desconto){
        this.nome = nome;
        this.preco = preco;
        this.quantidade = quantidade;
        this.desconto = desconto;
        calcularPrecoComDesconto();
    }

    @Override
    public String getNome(){
        return nome;
    }

    @Override
    public double getPreco(){
        return preco;
    }

    @Override
    public int getQuantidade(){
        return quantidade;
    }

    public int getDesconto(){
        return desconto;
    }

    @Override
    public void adicionarQuantidade(int quantidade){
        quantidade =+ quantidade;
    }

    @Override
    public void removerQuantidade(int quantidade){
        quantidade =- quantidade;
    }

    private void calcularPrecoComDesconto() {
        preco = preco * (1 - desconto / 100.0);
    }

    @Override
    public String toString(){
        return "Nome: " + getNome() + ", Preço: " + getPreco() + ", Quantidade: " + getQuantidade();
    }
}
