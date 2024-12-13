package aula06;

import aula05.DateYMD;

public class Fellowship extends Student {
    private Teacher advisor;
    private int scholarship;
    
    public Fellowship(String name, int idNumber, DateYMD dateOfBirth, Teacher advisor, int scholarship){
        super(name, idNumber, dateOfBirth);
        this.advisor = advisor;
        this.scholarship = scholarship;
    }

    public int getScholarship(){
        return scholarship;
    }

    public Teacher getAdvisor(){
        return advisor;
    }

    public void setScholarship(int scholarship){
        this.scholarship = scholarship;
    }

    public void setAdvisor(Teacher advisor){
        this.advisor = advisor;
    }

    public String toString(){
        return " Orientador: " + advisor + " Valor da Bolsa: " + scholarship;
    }
}
