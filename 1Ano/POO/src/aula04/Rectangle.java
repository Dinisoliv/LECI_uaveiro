package aula04;

public class Rectangle extends Form {
    private double lenght;
    private double height;

    public Rectangle(double length, double height, String color){
        super(color);
        assert(height > 0 && length > 0);
        this.lenght = length;
        this.height = height;
    }

    public double getHeight(){
        return height;
    }

    public double getLenght(){
        return lenght;
    }

    public String getColor(){
        return color;
    }

    public double calculateArea(){
        return height * lenght; 
    }

    public double calculatePerimeter(){
        return 2 * (height + lenght); 
    }

    @Override public String toString(){
        return String.format("Retângulo %.2f x %.2f, %s", height, lenght, color);
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
        
        Rectangle other = (Rectangle) obj;

        if (lenght != other.getLenght()) {
            return false;
        }

        if (height != other.getHeight()) {
            return false;
        }

        if (color.equals(other.getColor())) {
            return false;
        }
        
        return true;
    }
    
}
