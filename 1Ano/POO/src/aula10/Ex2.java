package aula10;

public class Ex2 {
    public static void main(String[] args) {
        GenreLibrary firstbBookSaving = new GenreLibrary();

        // Adicionar livros aos géneros
        firstbBookSaving.addBook("Drama", new Book("Hamlet", "William Shakespeare", 1600));
        firstbBookSaving.addBook("Fantasy", new Book("Harry Potter", "J.K. Rowling", 1997));
        firstbBookSaving.addBook("Sci-Fi", new Book("Dune", "Frank Herbert", 1965));
        firstbBookSaving.addBook("Mystery", new Book("The Hound of the Baskervilles", "Arthur Conan Doyle", 1902));
        firstbBookSaving.addBook("Romance", new Book("Pride and Prejudice", "Jane Austen", 1813));

        System.out.println("Library Contents:");
        System.out.println(firstbBookSaving);

        System.out.println("All Genres:");
        System.out.println(firstbBookSaving.getAllGenres());

        System.out.println("All Books:");
        System.out.println(firstbBookSaving.getAllBooks());

        // Atualizar um livro
        Book oldBook = new Book("Dune", "Frank Herbert", 1965);
        Book newBook = new Book("Foundation", "Isaac Asimov", 1951);
        firstbBookSaving.updateBook("Sci-Fi", oldBook, newBook);

        System.out.println("Updated Library Contents:");
        System.out.println(firstbBookSaving);

        // Remover um livro
        firstbBookSaving.removeBook("Mystery", new Book("The Hound of the Baskervilles", "Arthur Conan Doyle", 1902));

        System.out.println("Library Contents after removing a book:");
        System.out.println(firstbBookSaving);

        GenreLibrary library = new GenreLibrary();

        // Adicionar livros aos géneros
        library.addBook("Drama", new Book("Hamlet", "William Shakespeare", 1600));
        library.addBook("Fantasy", new Book("Harry Potter", "J.K. Rowling", 1997));
        library.addBook("Fantasy", new Book("The Hobbit", "J.R.R. Tolkien", 1937)); // Adicionando outro livro de fantasia
        library.addBook("Sci-Fi", new Book("Dune", "Frank Herbert", 1965));
        library.addBook("Mystery", new Book("The Hound of the Baskervilles", "Arthur Conan Doyle", 1902));
        library.addBook("Romance", new Book("Pride and Prejudice", "Jane Austen", 1813));

        System.out.println("Library Contents:");
        System.out.println(library);

        System.out.println("Random book from Fantasy genre: ");
        System.out.println(library.getRandomBook("Fantasy"));    
    }
}
