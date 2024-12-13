package aula10;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class GenreLibrary {
    Map<String, List<Book>> genreMap;

    public GenreLibrary(){
        genreMap = new HashMap<>(); //use treemap for order
    }

    public void addBook(String genre, Book book){
        if (!genreMap.containsKey(genre)) {
            genreMap.put(genre, new ArrayList<>());
        }
        genreMap.get(genre).add(book);
    }

    public void removeBook(String genre, Book book){
        if (genreMap.containsKey(genre)) {
            genreMap.get(genre).remove(book);
        }
    }

    public void updateBook(String genre, Book oldBook, Book newBook){
        if (genreMap.containsKey(genre)) {
            List<Book >books = genreMap.get(genre);
            if (books.contains(oldBook)) {
                int index = books.indexOf(oldBook);
                books.set(index, newBook);
            }
        }
    }

    public List<String> getAllGenres(){
        return new ArrayList<>(genreMap.keySet());
    }

    public List<Book> getAllBooks(){
        List<Book> allBooks = new ArrayList<>();
        for (List<Book> books : genreMap.values()) {
            allBooks.addAll(books);
        }
        return allBooks;
    }

    public Book getRandomBook(String genre){
        List<Book> books = genreMap.get(genre);
        if (books != null && !books.isEmpty()) {
            Random rand = new Random();
            return books.get(rand.nextInt(books.size()));
        }
        return null;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (String i : genreMap.keySet()) {
            sb.append(i);
            sb.append(": ");
            List<Book> books = genreMap.get(i);
            for (int j = 0; j < books.size(); j++) {
                sb.append(books.get(j)).append(", ");
            }
            sb.append("\n");
        }
        return sb.toString();
    }

    
}
