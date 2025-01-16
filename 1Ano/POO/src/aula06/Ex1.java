package aula06;

import aula05.DateYMD;

public class Ex1 {
    public static void main(String[] args) {
        DateYMD datePerson = new DateYMD(5, 10, 1988);
        Person person = new Person("Ana Santos", 98012244, datePerson);
        System.out.println(person);

        DateYMD dateStudent = new DateYMD(7, 9, 2005);
        Student StudentM = new Student("Afonso", 1234567, datePerson, dateStudent);
        Student StudentF = new Student("Maria", 9846352, datePerson);
        System.out.println(StudentM);
        System.out.println(StudentF);

        //melhorar os toString()(s)
    }
}
