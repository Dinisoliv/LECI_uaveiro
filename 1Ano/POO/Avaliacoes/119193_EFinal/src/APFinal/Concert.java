package APFinal;

public class Concert extends Event{
    private String artist;

    public Concert(String name, String artist, int duration) {
        super(name, duration);
        this.artist = artist;
        //this.typeEvent = typeEvent.MUSIC;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getArtist() {
        return artist;
    }
    
    

    @Override
    public String toString() {
        return "Concert [" + super.toString() + ", artist=" + artist + "]";
    }

    

}
