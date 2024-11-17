package aula04;

public class Triangle extends Form{
    private double side1;
    private double side2;
    private double side3;
    
    public Triangle(double side1, double side2, double side3, String color){
        super(color);
        assert(side1 > 0 && side2 > 0 && side3 > 0);
        assert(side1 + side2 > side3 && side1 + side3 > side2 && side2 + side3 > side1);
        this.side1 = side1;
        this.side2 = side2;
        this.side3 = side3;
    }

    public double getSide1(){
        return side1;
    }

    public double getSide2(){
        return side2;
    }

    public double getSide3(){
        return side3;
    }

    public String getColor(){
        return color;
    }

    public double calculateArea(){
        double p = calculatePerimeter() / 2; 
        return Math.sqrt(p * (p - side1) * (p - side2) * (p -side3));
    }

    public double calculatePerimeter(){
        return side1 + side2 + side3;
    }

    @Override public String toString(){
        return String.format("Triângulo de lados %.2f, %.2f, %.2f, %s", side1, side2, side3, color);
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
        
        Triangle other = (Triangle) obj;

        if (side1 != other.getSide1()) {
            return false;
        }

        if (side2 != other.getSide2()) {
            return false;
        }

        if (side3 != other.getSide3()) {
            return false;
        }

        if (color.equals(other.getColor())) {
            return false;
        }

        return true;

    }

}
