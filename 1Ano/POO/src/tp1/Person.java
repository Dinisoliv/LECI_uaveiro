package tp1;

import java.time.LocalDate;

public class Person {
    private String name;
    private LocalDate dob;
    
    public Person(String name, LocalDate dob) {
        this.name = name;
        this.dob = dob;
    }

    @Override
    public String toString() {
        return "Person [name=" + name + ", dob=" + dob + "]";
    }



    public int getAge(){
        return LocalDate.now().getYear() - dob.getYear();
    }
}
