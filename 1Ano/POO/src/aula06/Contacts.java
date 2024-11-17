package aula06;

public class Contacts{
    private String phoneNumber;
    private String email;
    private Person person;
    private int id;
    private int nextid = 1;

    public Contacts(Person person, String phoneNumber, String email){
        if ((email == null || email.isEmpty()) && (phoneNumber == null || phoneNumber.isEmpty()))
            throw new IllegalArgumentException("Either email or phone must be provided");
        this.person = person;
        if (phoneIsValid(phoneNumber)) {
            this.phoneNumber = phoneNumber;
        }
        if (emailIsValid(email)) {
            this.email = email;

        }
        this.id = nextid++;
    }

    public int getId(){
        return id;
    }

    public Person getPerson(){
        return person;
    }

    public String getEmail(){
        return email;
    }
    
    public String getPhoneNumber(){
        return phoneNumber;
    }

    public void setPerson(Person person){
        if (person == null) {
            throw new IllegalArgumentException("Person must be provided");
        }
        this.person = person;
    }

    public void setEmail(String email){
        if (!emailIsValid(email)) {
            throw new IllegalArgumentException("Invalid email");
        }
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber){
        if (!phoneIsValid(phoneNumber)) {
            throw new IllegalArgumentException("Invalid phone number");            
        }
        this.phoneNumber = phoneNumber;
    }

    
    public boolean phoneIsValid(String phoneNumber){
        String[] phoneDigits = phoneNumber.split("");
        if (phoneDigits[0].equals("9") || phoneDigits.length == 9) {
            return true;
        }
        if (phoneNumber == null || phoneNumber.isEmpty()) {
            return false;
        }
        return false;
    }

    public boolean emailIsValid(String email){
        if (email == null || email.isEmpty()) {
            return false;
        }
        if (email.matches("^[a-zA-Z_0-9.]+@[a-zA-Z_0-9.]+\\.[a-zA-Z_0-9]+$")) {
            return true;
        }
        return false;
    }

    @Override
    public String toString(){
        return String.format("ID: %d%nPerson: %s%nEmail: %s%nPhone: %s", this.id, this.person, this.email, this.phoneNumber);
    }
}

