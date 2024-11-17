package aula10;

import java.util.HashMap;
import java.util.Map;

public class Ex1 {
    public static void main(String[] args) {
        Map<Book, String> library = new HashMap<>();
        
        library.put(new Book("Hamlet", "William Shakespeare", 1600), "Drama");
        library.put(new Book("Harry Potter", "J.K. Rowling", 1997), "Fantasy");
        library.put(new Book("Dune", "Frank Herbert", 1965), "Sci-Fi");
        library.put(new Book("The Hound of the Baskervilles", "Arthur Conan Doyle", 1902), "Mystery");
        library.put(new Book("Pride and Prejudice", "Jane Austen", 1813), "Romance");
        library.put(new Book("Amor", "Camões", 1500), "Romance");

        //use remove and replace

        for (Book book : library.keySet()) {
            System.out.println("Livro: " + book + ", Género: " + library.get(book));
        }
    }
}
