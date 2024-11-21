package aula05;

public abstract class Date{
    public abstract void set(int day, int month, int year);
    public abstract int getDay();
    public abstract int getMonth();
    public abstract int getYear();
    public abstract boolean valid(int day, int month, int year);
    public abstract void increment();
    public abstract void decrement();
    public abstract boolean equals(Object obj);
}
