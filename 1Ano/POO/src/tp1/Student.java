package tp1;

public class Student {
    private Person pi;
    private int nMec;
    private int courseID;
    private double grade;

    public Student(Person pi, int nMec, int courseID, double grade) {
        this.pi = pi;
        this.nMec = nMec;
        this.courseID = courseID;
        this.grade = grade;
    }

    public Person getPi() {
        return pi;
    }

    public int getnMec() {
        return nMec;
    }

    public int getCourseID() {
        return courseID;
    }

    public double getGrade() {
        return grade;
    }

    
    
    
}
