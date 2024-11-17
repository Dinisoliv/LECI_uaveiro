package streams;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class StreamsExamples {
    //Given a list of strings, return a list sorted by the length of the strings.
    public List<String> sortByLenght (List<String> strings){
        return strings.stream()
            .sorted(Comparator.comparingInt(String::length))
            .collect(Collectors.toList());
    }

    //Given a list of strings, return a list where each string is converted to uppercase.
     public List<String> convertToUppercase(List<String> strings){
        return strings.stream()
            .map(String::toUpperCase)
            .collect(Collectors.toList());
    }

    //Given a list of integers, return a list containing only the odd numbers.
    public List<Integer> filterOddNumbers(List<Integer> numbers){
        return numbers.stream()
            .filter(n -> n % 2 != 0)
            .collect(Collectors.toList());
    }

    //Given a list of lists of integers, return a flattened list of integers.
    public List<Integer> flattenList (List<List<Integer>> listOfLists){
        return listOfLists.stream()
            .flatMap(List::stream)
            .collect(Collectors.toList());
    } 

    //Given a list of strings, find the first string that has more than three characters.
    public Optional<String> findFirstLongString(List<String> strings){
        return strings.stream()
            .filter(str -> str.length() > 3)
            .findFirst();
    }

    //Given a list of integers, return the sum of their squares.
    public int sumOfSquares(List<Integer> numbers){
        return numbers.stream()
            .mapToInt(n -> n*n)
            .sum();
    }

    //Given a list of strings and a character, count how many strings start with that character.
    public long countStartingWith(List<String> strings, char c){
        return strings.stream()
            .filter(str -> str.charAt(0) == c)
            .count();
    }

    //Given a list of strings, group them by their first character.
    public Map<Character, List<String>> groupByFirstLetter(List<String> strings){
        return strings.stream()
            .collect(Collectors.groupingBy(str -> str.charAt(0)));
    }

    //Given a list of integers, partition them into even and odd numbers.
    public Map<Boolean, List<Integer>> partitionEvenOdd (List<Integer> numbers){
        return numbers.stream()
            .collect(Collectors.partitioningBy(n -> n % 2 == 0));
    }

    //Given a list of strings, return a map where the keys are the strings and the values are their lengths.
    public Map<String, Integer> mapStringToLength(List <String> strings){
        return strings.stream()
            .collect(Collectors.toMap(str -> str, String::length));
    }

    //Skip the first 2 elements and then limit the stream to the next 3 elements, collecting the result.
    public List<Integer> skipAndLimit(List<Integer> numbers){
        return numbers.stream()
            .skip(2)
            .limit(3)
            .collect(Collectors.toList());
    }

    //Find the maximum element in a list.
    public Optional<Integer> findMax(Set<Integer> numbers){
        return numbers.stream()
            .max(Integer::compareTo);
    }

    //Sum a large list of integers using parallel streams.
    public int parallelSum(List <Integer> numbers){
        return numbers.parallelStream()
            .mapToInt(Integer::intValue)
            .sum();
    }

    //Remove duplicate elements from a list.
    public List<Integer> removeDuplicates(List<Integer> numbers){
        return numbers.stream()
            .distinct()
            .collect(Collectors.toList());
    }

    //Debug a stream pipeline.
    public List<String> debugStream (List<String> strings){
        return strings.stream()
            .peek(System.out::println)
            .map(String::toUpperCase)
            .peek(System.out::println)
            .collect(Collectors.toList());
    }

    // Create an infinite stream of random numbers.
    public Set<Double> generateRandomNumbers(int limit){
        return Stream.generate(Math::random)
            .limit(limit)
            .collect(Collectors.toSet());
    }

    // Concatenate two lists.
    public List<Integer> concatenate(List<Integer> list1, List<Integer> list2){
        return Stream.concat(list1.stream(), list2.stream())
            .collect(Collectors.toList());
    }

    //Join a list of strings into a single string.
    public String joinStrings (List<String> strings){
        return strings.stream()
            .collect(Collectors.joining(", "));
    }

    //To perform a reduction on the elements of the stream, using an associative accumulation function, 
    //and return an Optional describing the reduced value, if any.
    public Optional<Integer> sum(List<Integer> numbers){
        return numbers.stream()
            .reduce((a, b) -> a + b);
    }

    public int sum2(List<Integer> numbers) {
        return numbers.stream()
            .reduce(0, (a, b) -> a + b); // Accumulate with an identity value of 0
    }

    //To return an Optional describing some element of the stream, or an empty Optional if the stream is empty. 
    //This operation is particularly useful in parallel streams where any found element is sufficient.
    public Optional<Integer> findAnyElement(List<Integer> numbers){
        return numbers.stream()
            .findAny();
    }


    public static void main(String[] args) {
        
    }

}
