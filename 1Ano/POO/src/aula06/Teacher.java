package aula06;

import aula05.DateYMD;

public class Teacher extends Person {
    private String category;
    private String department;

    public Teacher(String name, int idNumber, DateYMD dateOfBirth, String category, String department){
        super(name, idNumber, dateOfBirth);
        assert(category.equalsIgnoreCase("Auxiliar")
        || category.equalsIgnoreCase("Associado")
        || category.equalsIgnoreCase("Catedrático"));
        this.category = category;
        this.department = department;
    }

    public String getCategory(){
        return category;
    }

    public String getDepartament(){
        return department;
    }

    public String toString(){
        return super.toString() + " categoria: " + category + " departamento: " + department;
    }


}
