package aula04;

public abstract class Form{
    String color;

    public Form(String color){
        this.color = color;
    }

    public abstract double calculateArea();
    public abstract double calculatePerimeter();
}
