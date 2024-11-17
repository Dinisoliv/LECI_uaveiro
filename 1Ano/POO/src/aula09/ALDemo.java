package aula09;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

import aula05.Date;
import aula05.DateYMD;
import aula06.Person;

public class ALDemo {
    public static void main(String[] args) {
        ArrayList<Integer> c1 = new ArrayList<>();
        for (int i = 10; i <= 100; i++) {
            c1.add(i);
        }
        System.out.println("Size: " + c1.size());
        for (int i = 0; i < c1.size(); i++) {
            System.out.println("Elemento: " + c1.get(i));
        }

        ArrayList<String> c2 = new ArrayList<>();
        c2.add("Vento");
        c2.add("Calor");
        c2.add("Frio");
        c2.add("Chuva");
        System.out.println(c2);
        Collections.sort(c2);
        System.out.println(c2);
        c2.remove("Frio");
        c2.remove(0);
        System.out.println(c2);

        if (c2.contains("Chuva")) {
            c2.add("Chuva");
        }
        c2.set(1, "Verão");
        
        System.out.println(c2);

        System.out.println("1a e ultima ocurrencia de chuva");
        System.out.println(c2.indexOf("Chuva"));
        System.out.println(c2.lastIndexOf("Chuva"));

        System.out.println("sublist the c1:");
        System.out.println(c1.subList(12, 45));

        Set<Person> c3 = new HashSet<>();
        
        DateYMD date1 = new DateYMD(1, 1, 2000);
        DateYMD date2 = new DateYMD(2, 2, 2001);
        DateYMD date3 = new DateYMD(3, 3, 2002);
        DateYMD date4 = new DateYMD(4, 4, 2003);
        //DateYMD date5 = new DateYMD(5, 5, 2004);

        Person person1 = new Person("Dinis", 1234567, date1);
        Person person2 = new Person("Afonso", 2345671, date2);
        Person person3 = new Person("Manuel", 3456712, date3);
        Person person4 = new Person("Joao", 7654321, date4);
        Person person5 = new Person("Dinis", 1234567, date1);
        

        c3.add(person1);
        c3.add(person2);
        c3.add(person3);
        c3.add(person4);
        c3.add(person5);

        //for (Person n : c3) {
          //  System.out.println(n);
        //}

        Person p1 = new Person("Alice", 1, new DateYMD(1, 1, 2000));
        Person p2 = new Person("Bob", 2, new DateYMD(1, 2, 2001));
        Person p3 = new Person("Charlie", 3, new DateYMD(2, 3, 2002));
        Person p4 = new Person("Alice", 1, new DateYMD(1, 1, 2000));

        c3.add(p1);
        c3.add(p2);
        c3.add(p3);
        c3.add(p4);

        Iterator<Person> iterator = c3.iterator();

        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }

        Set<Date> c4 = new TreeSet<>();

        Date d1 = new DateYMD(1, 1, 2000);
        Date d2 = new DateYMD(1, 1, 2000);
        Date d3 = new DateYMD(1, 2, 2000);
        Date d4 = new DateYMD(1, 1, 2001);
        Date d5 = new DateYMD(2, 1, 2001);
        Date d6 = new DateYMD(23, 6, 2005);

        c4.add(d1);
        c4.add(d2);
        c4.add(d3);
        c4.add(d4);
        c4.add(d5);
        c4.add(d6);

        Iterator<Date> iterator2 =c4.iterator();

        while (iterator2.hasNext()) {
            System.out.println(iterator2.next());            
        }
    }    
}
