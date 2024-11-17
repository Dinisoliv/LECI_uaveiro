package aula04;

public class Circle extends Form{
    private double radius;

    public Circle(double radius, String color){
        super(color);
        //assert radius > 0
        if (radius > 0) {
            this.radius = radius;
        }
        else{
            System.err.println("Radius must be positive");
        }
    }

    public double getRadius(){
        return radius;
    }

    public String getColor(){
        return color;
    }

    public double calculateArea(){
        return Math.PI * Math.pow(radius, 2);
    }

    public double calculatePerimeter(){
        return 2 * Math.PI * radius;    
    }

    @Override public String toString(){
        return "Circle: radius = " + radius + " color = " + color;
    }

    @Override public boolean equals(Object obj){
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        
        Circle other = (Circle) obj;

        if (radius != other.getRadius()) {
            return false;
        }
        System.out.println("Cor (other): " + other.getColor());
        if (!color.equals(other.getColor())) {
            return false;
        }    

        return true;
    }

}
