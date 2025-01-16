package aula09;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.TreeSet;
import java.util.ArrayList;

public class CollectionTester {
    public static void main(String[] args) {
    //int DIM = 5000;

    Collection<Integer> col = new ArrayList<>();
    Collection<Integer> col1 = new LinkedList<>();
    Collection<Integer> col2 = new HashSet<>();
    Collection<Integer> col3 = new TreeSet<>();

    //checkPerformance(col, DIM);

    int[] values = {1000, 5000, 10000, 20000, 40000, 100000};

    printResults(col, values);
    printResults(col1, values);
    printResults(col2, values);
    printResults(col3, values);

    }

    private static double[] checkPerformance(Collection<Integer> col, int DIM) {
        double[] results = new double[3];
        double start, stop, delta;
        // Add
        start = System.nanoTime(); // clock snapshot before
        for(int i=0; i<DIM; i++ )
            col.add( i );
        
        stop = System.nanoTime(); // clock snapshot after
        delta = (stop-start)/1e6; // convert to milliseconds
        //System.out.println(col.size()+ ": Add to " +
                //col.getClass().getSimpleName() +" took " + delta + "ms");
        results[0] = delta;
        // Search
        start = System.nanoTime(); // clock snapshot before
        for(int i=0; i<DIM; i++ ) {
            int n = (int) (Math.random()*DIM);
            if (!col.contains(n))
                System.out.println("Not found???"+n);
    }
        stop = System.nanoTime(); // clock snapshot after
        delta = (stop-start)/1e6; // convert nanoseconds to milliseconds
        //System.out.println(col.size()+ ": Search to " +
                //col.getClass().getSimpleName() +" took " + delta + "ms");
        results[1] = delta;
        // Remove
        start = System.nanoTime(); // clock snapshot before
        Iterator<Integer> iterator = col.iterator();
        while (iterator.hasNext()) {
            iterator.next();
            iterator.remove();
        }
        stop = System.nanoTime(); // clock snapshot after
        delta = (stop-start)/1e6; // convert nanoseconds to milliseconds
        //System.out.println(col.size() + ": Remove from "+
                //col.getClass().getSimpleName() +" took " + delta + "ms");
        results[2] = delta;

        return results;
    }

    private static void printResults(Collection<Integer> col, int[] sizeToCheck){
        System.out.print(String.format("%-15s", "Collection"));
        for (int i = 0; i < sizeToCheck.length; i++) {
            System.out.print(String.format("%15d", sizeToCheck[i]));
        }
        System.out.println("\n" + col.getClass().getSimpleName());

        double[][] results = new double[sizeToCheck.length][];

        for (int i = 0; i < sizeToCheck.length; i++) {
            results[i] = checkPerformance(col, sizeToCheck[i]);
        }

        System.out.print(String.format("%-15s", "add"));

        for (int i = 0; i < sizeToCheck.length; i++) {
            System.out.print(String.format("%15.4f", results[i][0]));
        }
        System.out.println();

        System.out.print(String.format("%-15s", "search"));

        for (int i = 0; i < sizeToCheck.length; i++) {
            System.out.print(String.format("%15.4f", results[i][1]));
        }
        System.out.println();

        System.out.print(String.format("%-15s", "remove"));

        for (int i = 0; i < sizeToCheck.length; i++) {
            System.out.print(String.format("%15.4f", results[i][2]));
        }
        System.out.println("\n");
    }
}