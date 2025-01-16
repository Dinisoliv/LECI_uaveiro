package aula12;

import java.io.FileWriter;
import java.io.IOException;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Scanner;
import java.util.stream.Collectors;
import java.util.List;
import java.util.Map;


public class MovieManager {
    public static void main(String[] args) {
        List<Movie> movies = readMoviesFromFile("movies.txt");

        // Ordenar por nome e listar
        movies.sort(Comparator.comparing(movie -> movie.getName().toLowerCase()));
        System.out.println("Movies ordered by name:");
        movies.forEach(System.out::println);

        // Ordenar por score decrescente e listar
        movies.sort(Comparator.comparing(Movie::getScore).reversed());
        System.out.println("\nMovies ordered by score (descending):");
        movies.forEach(System.out::println);

        // Ordenar por running time crescente e listar
        movies.sort(Comparator.comparing(Movie::getRunningTime));
        System.out.println("\nMovies ordered by running time (ascending):");
        movies.forEach(System.out::println);

        Map<Genre, Long> genreCount = movies.stream()
                                .collect(Collectors.groupingBy(Movie::getGenre, Collectors.counting()));
        System.out.println("\nGenre count:");
        genreCount.forEach((genre, count) -> System.out.println(genre + ": " + count));

        Scanner scanner = new Scanner(System.in);
        System.out.print("\nEnter a genre: ");
        String userGenre = scanner.nextLine();
        writeSelectionToFile("myselection.txt", movies, Genre.fromString(userGenre));
        scanner.close();
    }

    private static List<Movie> readMoviesFromFile(String filename){
        List<Movie> movies = new ArrayList<>();

        try (Scanner myReader = new Scanner(new File(filename))) {
            myReader.nextLine();
            while (myReader.hasNextLine()) {
                String movieInfo = myReader.nextLine();

                String[] attributes = movieInfo.split("\t");
                String name = attributes[0].trim();
                double score = Double.parseDouble(attributes[1]); //NumberFormatException?
                String rating = attributes[2];
                Genre genre = Genre.fromString(attributes[3]); //NumberFormatException?
                int runningTime = Integer.parseInt(attributes[4]);
                
                movies.add(new Movie(name, score, rating, genre, runningTime));
            }
        } catch (FileNotFoundException e) {
            System.out.println("Ficheiro não existente!");
        }
        return movies;
    }

    private static void writeSelectionToFile(String filename, List<Movie> movies, Genre genre){
        try (FileWriter myWriter = new FileWriter(filename)) {
            for (Movie movie : movies) {
                if (movie.getScore() > 60 && movie.getGenre() == genre) {
                    myWriter.write(movie.toString());
                }
            }
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();  
        }
    }
}