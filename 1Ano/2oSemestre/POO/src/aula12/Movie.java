package aula12;

public class Movie implements Comparable<Movie>{
    private String name;
    private double score;
    private String rating;
    private Genre genre;
    private int runningTime;
    
    public Movie(String name, double score, String rating, Genre genre, int runningTime) {
        this.name = name;
        this.score = score;
        this.rating = rating;
        this.genre = genre;
        this.runningTime = runningTime;
    }

    @Override
    public String toString() {
        return "Movie [name=" + name + ", score=" + score + ", rating=" + rating + ", genre=" + genre + ", runningTime="
                + runningTime + "]";
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }

    public int getRunningTime() {
        return runningTime;
    }

    public void setRunningTime(int runningTime) {
        this.runningTime = runningTime;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        long temp;
        temp = Double.doubleToLongBits(score);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        result = prime * result + ((rating == null) ? 0 : rating.hashCode());
        result = prime * result + ((genre == null) ? 0 : genre.hashCode());
        result = prime * result + runningTime;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Movie other = (Movie) obj;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (Double.doubleToLongBits(score) != Double.doubleToLongBits(other.score))
            return false;
        if (rating == null) {
            if (other.rating != null)
                return false;
        } else if (!rating.equals(other.rating))
            return false;
        if (genre != other.genre)
            return false;
        if (runningTime != other.runningTime)
            return false;
        return true;
    }

    @Override
    public int compareTo(Movie other) {
        // Compare by genre first
        int genreComparison = this.genre.compareTo(other.genre);
        if (genreComparison != 0) {
            return genreComparison;
        }

        // Then compare by score
        int scoreComparison = Double.compare(this.score, other.score);
        if (scoreComparison != 0) {
            return scoreComparison;
        }

        // Then compare by name
        int nameComparison = this.name.compareTo(other.name);
        if (nameComparison != 0) {
            return nameComparison;
        }

        // Then compare by running time
        int runningTimeComparison = Integer.compare(this.runningTime, other.runningTime);
        if (runningTimeComparison != 0) {
            return runningTimeComparison;
        }

        // Finally compare by rating
        return this.rating.compareTo(other.rating);
    }

    
}
