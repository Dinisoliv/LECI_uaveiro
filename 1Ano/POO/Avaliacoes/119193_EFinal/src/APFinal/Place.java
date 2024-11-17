package APFinal;

public class Place {
    private String name;
    private int capacity;

    public Place(String name, int capacity) {
        this.name = name;
        this.capacity = capacity;
    }

    

    public int getCapacity() {
        return capacity;
    }

    public String getName() {
        return name;
    }



    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + capacity;
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
        Place other = (Place) obj;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (capacity != other.capacity)
            return false;
        return true;
    }



    
}
