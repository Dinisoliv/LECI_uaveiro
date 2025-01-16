package aula08.ex3;

import java.util.HashSet;
import java.util.Set;

public class CarrinhoDeCompras implements Compra {
    Set<Produto> produtos = new HashSet<>();    

    public void adicionarProduto(Produto produto, int quantidade){
        produto.adicionarQuantidade(quantidade);
        produtos.add(produto);
    }

    public void listarProdutos(){
        for (Produto produto : produtos) {
            System.out.println(produto);
        }
    }

    public double calcularTotal(){
        double total = 0;
        for (Produto produto : produtos) {
            total += produto.getPreco() * produto.getQuantidade();
        }
        return total;
    }
}
