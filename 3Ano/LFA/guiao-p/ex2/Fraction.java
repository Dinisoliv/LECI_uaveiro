public class Fraction {
    public int num;
    public int den;
    
    public Fraction(int num, int den){
        if (den < 0) { num = -num; den = -den; }
        this.num = num;
        this.den = den;
    }

    public Fraction add(Fraction fraction2){
        return new Fraction(num * fraction2.den + den * fraction2.num, den * fraction2.den);
    }

    public Fraction sub(Fraction fraction2){
        return new Fraction(num * fraction2.den - den * fraction2.num, den * fraction2.den);
    }

    public Fraction mul(Fraction fraction2){
        return new Fraction(num * fraction2.num, den * fraction2.den);
    }

    public Fraction div(Fraction fraction2){
        return new Fraction(num * fraction2.den, den * fraction2.num);
    }

    public Fraction neg(){
        return new Fraction(-num, den);
    }

    @Override
    public String toString() {
        if (den == 1) return Integer.toString(num);
        return num + "/" + den;
    }

}