package aula11;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Scanner;
import java.util.Iterator;


public class Gradebook implements IGradeCalculator{
    Map<String, Double> gradebook;
    List<Student> listStudents;

    public Gradebook(){
        gradebook = new HashMap<>();
        listStudents = new ArrayList<>();
    }

    public double calculate(List<Double> grades){
        double sum = 0;
        for (Double grade : grades) {
            sum += grade; 
        }
        return sum / grades.size();
    }

    public void load(String fich){
        File myFile = new File(fich);
        try {
            Scanner myReader = new Scanner(myFile);
            while (myReader.hasNextLine()) {
                String student = myReader.nextLine();
                String[]studentInfo = student.split("\\|");
                List<Double> grades = new ArrayList<>();
                try {
                    grades.add(Double.parseDouble(studentInfo[1]));
                    grades.add(Double.parseDouble(studentInfo[2]));
                    grades.add(Double.parseDouble(studentInfo[3]));
                } catch (NumberFormatException e) {
                    System.out.println("Error parsing grade for student: " + studentInfo[0]);
                    continue;
                }

                gradebook.put(studentInfo[0], calculate(grades));

                listStudents.add(new Student(studentInfo[0], grades));

            }
            myReader.close();
        } catch (FileNotFoundException e) {
            System.out.println("Ficheiro não encontrado");
            e.printStackTrace();
        }   
    }

    public void addStudent(Student student){
        gradebook.put(student.getName(), calculate(student.getGrades()));
        listStudents.add(student);
    }

    public void removeStudent(String name){
        gradebook.remove(name);
        Iterator<Student> iterator = listStudents.iterator();
        while (iterator.hasNext()) {
            Student student = iterator.next();
            if (student.getName().equals(name)) {
                iterator.remove();
            }
        }
    }

    public Student getStudent(String name){
        for (Student student : listStudents) {
            if (student.getName().equals(name)) {
                return student;
            }
        }
        return null;
    }

    public double calculateAverageGrade(String name){
        return gradebook.getOrDefault(name, -1.0);
    }

    public void printAllStudents(){
        for (Student student : listStudents) {
            System.out.println(student + ", média:" + gradebook.get(student.getName()));
        }
    }
}
