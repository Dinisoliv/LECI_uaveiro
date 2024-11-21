package aula06;

import aula05.DateYMD;

public class Test {
    public static void main(String[] args) {
    Student al = new Student ("Andreia Melo", 9855678,new DateYMD(18, 7, 1990), new DateYMD(1, 9, 2018));
    
    Teacher p1 = new Teacher("Jorge Almeida", 3467225, new DateYMD(13, 3, 1967),"Associado", "Informática");

    Fellowship bls = new Fellowship("Igor Santos", 8976543, new DateYMD(11, 5, 1985), p1, 900);

    bls.setScholarship(1050);
    
    System.out.println("Aluno: " + al.getName());
    System.out.println(al);
    System.out.println("Bolseiro: " + bls.getName() + ", NMec: "
    + bls.getNMEc() + ", Bolsa: " + bls.getScholarship() + ", Orientador: " +
    bls.getAdvisor());
    System.out.println(bls);
    }
    }
