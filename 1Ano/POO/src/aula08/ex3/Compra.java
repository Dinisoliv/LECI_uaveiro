package aula08.ex3;

public interface Compra {
    void adicionarProduto (Produto produto, int quantidade);
    void listarProdutos();
    double calcularTotal();
}
