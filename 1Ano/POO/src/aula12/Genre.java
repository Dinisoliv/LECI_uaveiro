package aula12;

public enum Genre {
    ACTION,
    COMEDY,
    SUSPENSE,
    HORROR,
    DRAMA;

    public static Genre fromString(String genre) {
        switch (genre.toLowerCase()) {
            case "action":
                return ACTION;
            case "comedy":
                return COMEDY;
            case "suspense":
                return SUSPENSE;
            case "horror":
                return HORROR;
            case "drama":
                return DRAMA;
            default:
                throw new IllegalArgumentException("Unknown genre: " + genre);
            }
        }
    public String toString(){
        return name().charAt(0) + name().substring(1).toLowerCase();
    }
}