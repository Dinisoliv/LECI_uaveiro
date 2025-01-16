package aula06;

import aula05.DateYMD;

public class Person {
    private String name;
    private int idNumber;
    private DateYMD dateOfBirth;

    public Person(String name, int idNumber, DateYMD dateOfBirth){
        assert(idNumber > 0);
        this.name = name;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public int getIdNumber(){
        return idNumber;
    }

    public void setIdNumber(int cc){
        this.idNumber = cc;
    }

    public DateYMD getDateOfBirth(){
        return dateOfBirth;
    }

    public void setDateOfBirth(DateYMD birthDate){
        this.dateOfBirth = birthDate;
    }

    @Override
    public String toString(){
        return String.format(" nome:%s cc:%d birthday:%s ", name, idNumber, dateOfBirth);
    }

    @Override
    public boolean equals(Object obj){
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        Person person = (Person) obj;

        if (!(name.equals(person.name)) || idNumber != person.idNumber || !dateOfBirth.equals(person.dateOfBirth)) {
            return false;    
        }
        return true;
    }
    
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + idNumber;
        result = prime * result + ((dateOfBirth == null) ? 0 : dateOfBirth.hashCode());
        return result;
    }
}

