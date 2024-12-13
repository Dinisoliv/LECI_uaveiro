package util;

import java.util.function.Predicate;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Supplier;
import java.util.Comparator;
import java.util.Arrays;

// Custom functional interface
@FunctionalInterface
interface MathOperation {
    int operate(int a, int b);
}

public class FunctionalInterfacesExample {
    public static void main(String[] args) {
        // Predicate example
        Predicate<Integer> isEven = n -> n % 2 == 0;
        System.out.println("Is 4 even? " + isEven.test(4)); // true
        System.out.println("Is 3 even? " + isEven.test(3)); // false

        Predicate<Integer> isOdd = n -> n % 2 != 0;
        System.out.println("Is 4 odd? " + isOdd.test(4));
        System.out.println("Is 3 odd? " + isOdd.test(3));
        
        // Consumer example
        Consumer<String> print = s -> System.out.println(s);
        print.accept("Hello, World!"); // Prints "Hello, World!"
        
        // Function example
        Function<String, Integer> stringLength = s -> s.length();
        System.out.println("Length of 'Hello': " + stringLength.apply("Hello")); // 5
        
        // Supplier example
        Supplier<String> greetSupplier = () -> "Hello, World!";
        System.out.println("Greeting: " + greetSupplier.get()); // "Hello, World!"
        
        // Comparator example
        Comparator<Integer> comparator = (a, b) -> a - b;
        Integer[] numbers = {3, 1, 4, 1, 5, 9};
        Arrays.sort(numbers, comparator);
        System.out.println("Sorted numbers: " + Arrays.toString(numbers)); // [1, 1, 3, 4, 5, 9]
        
        // Custom functional interface example
        MathOperation addition = (a, b) -> a + b;
        System.out.println("Addition: " + addition.operate(5, 3)); // Output: 8
        
        MathOperation subtraction = (a, b) -> a - b;
        System.out.println("Subtraction: " + subtraction.operate(5, 3)); // Output: 2
    }
}

