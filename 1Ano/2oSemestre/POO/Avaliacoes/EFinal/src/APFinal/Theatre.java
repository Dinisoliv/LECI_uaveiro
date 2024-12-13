package APFinal;

public class Theatre extends Event {
    private String author;
    private String company;

    public Theatre(String name, String author, String company, int duration) {
        super(name, duration);
        this.author = author;
        this.company = company;
    }

    

    public String getAuthor() {
        return author;
    }



    public String getCompany() {
        return company;
    }



    @Override
    public String toString() {
        return "Theatre [" + super.toString() + ", author=" + author + ", company=" + company + "]";
    }

    
}
