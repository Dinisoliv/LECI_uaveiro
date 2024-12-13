package APFinal;

import java.util.Arrays;

public class Cinema extends Event{
    private String director;
    private int year;
    private String[] actors;

    public Cinema(String name, String director, int year, String[] actors, int duration)  {
        super(name, duration);
        this.director = director;
        this.year = year;
        this.actors = actors;
    }

    

    public String getDirector() {
        return director;
    }



    public int getYear() {
        return year;
    }



    public String[] getActors() {
        return actors;
    }



    @Override
    public String toString() {
        return "Cinema [" + super.toString() + ", director=" + director + ", year=" + year
                + ", actors=" + Arrays.toString(actors) + "]";
    }

    
}
