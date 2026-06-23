public class Fraction {
    public final long num;  // numerator
    public final long den;  // denominator

    public Fraction(long num, long den) {
        if (den == 0) throw new RuntimeException("Error: zero denominator");
        // normalize sign: denominator always positive
        if (den < 0) { num = -num; den = -den; }
        this.num = num;
        this.den = den;
    }

    // greatest common divisor
    private static long gcd(long a, long b) {
        a = Math.abs(a);
        b = Math.abs(b);
        while (b != 0) { long t = b; b = a % b; a = t; }
        return a;
    }

    public Fraction reduce() {
        long g = gcd(num, den);
        return new Fraction(num / g, den / g);
    }

    public Fraction add(Fraction o) {
        return new Fraction(num * o.den + o.num * den, den * o.den);
    }

    public Fraction sub(Fraction o) {
        return new Fraction(num * o.den - o.num * den, den * o.den);
    }

    public Fraction mul(Fraction o) {
        return new Fraction(num * o.num, den * o.den);
    }

    public Fraction div(Fraction o) {
        if (o.num == 0) throw new RuntimeException("Error: division by zero");
        return new Fraction(num * o.den, den * o.num);
    }

    public Fraction pow(int exp) {
        if (exp < 0) throw new RuntimeException("Error: negative exponent");
        long n = 1, d = 1;
        for (int i = 0; i < exp; i++) { n *= num; d *= den; }
        return new Fraction(n, d);
    }

    public Fraction negate() {
        return new Fraction(-num, den);
    }

    @Override
    public String toString() {
        if (den == 1) return Long.toString(num);
        return num + "/" + den;
    }
}