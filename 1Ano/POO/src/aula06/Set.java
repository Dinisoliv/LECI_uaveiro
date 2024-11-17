package aula06;

import java.util.Arrays;

interface InnerSet {
    public double calculatePerimeter();
    public double calculateArea(); 
}

public class Set {
    private int[] elements;
    private int length;

    public Set(){
        elements = new int[0];
        length = 0;
    }

    public int[] getElements(){
        return elements;
    }

    public void insert(int n){
        if(!contains(n)){
            int[] newArray = Arrays.copyOf(elements, length + 1);
            newArray[length++] = n;
            elements = newArray;
        }
    }

    public boolean contains(int n){
        for (int i : elements) {
            if (i == n) {
                return true;
            }
        }
        return false;
    }

    public void remove (int n){
        for (int i = 0; i < length; i++) {
            if (elements[i] == n) {
                for (int j = i; j < length - 1; j++) {
                    elements[j] = elements[j + 1];
                }
            length--;
            int[] newArray = Arrays.copyOf(elements, length);
            elements = newArray;
            return;
            }
        }
    }

    public void empty(){
        elements = new int[0];
        length = 0;
    }

    public String toString(){
        return Arrays.toString(elements);
    }

    public String toString2(){
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(elements[i]);
            if (i < length - 1) {
                sb.append(", ");
            }
        }
        return sb.toString();
    }

    public int size(){
        return length;
    }

    public Set combine(Set add){
        Set union = new Set();
        for (int i : elements) {
            union.insert(i);
        }

        for (int j : add.getElements()) {
            if (!contains(j, union.getElements())) {
                union.insert(j);
            }
        }
    return union;
    }

    public boolean contains(int n, int[] set){
        for (int i : set) {
            if (i == n) {
                return true;
            }
        }
        return false;
    }

    public Set subtract(Set dif){
        Set subtract = new Set();
        for (int i : elements) {
            if (!dif.contains(i)) {
                subtract.insert(i);
            }
        }
        return subtract;
    }

    public Set intersect(Set inter){
        Set intersect = new Set();
        for (int i : elements) {
            if (inter.contains(i)) {
                intersect.insert(i);
            }
        }
       return intersect;
    }
}
