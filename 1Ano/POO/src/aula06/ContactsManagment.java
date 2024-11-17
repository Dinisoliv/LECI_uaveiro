package aula06;

import java.util.ArrayList;
import java.util.Scanner;

import aula05.DateYMD;

public class ContactsManagment {    
    public static final Scanner sc = new Scanner(System.in);
        
    public static void main(String[] args) {
        String menu = "Selecione uma opção:\n1. Inserir contacto\n2. Alterar contacto\n3. Apagar contacto\n4. Procurar contacto\n5. Listar contactos\n0. Sair\n> ";
        int option;
        ArrayList<Contacts> contacts = new ArrayList<Contacts>();

        while (true) {
            System.out.print(menu);
            option = sc.nextInt();
            sc.nextLine();
            switch (option) {
                case 0:
                    System.out.println("Exiting...");
                    System.exit(0);
                    break;
                case 1:
                    addContact(contacts);
                    break;
                case 2:
                    changeContact(contacts);
                    break;
                case 3:
                    deleteContact(contacts);
                    break;
                case 4:
                    searchContact(contacts);
                    break;
                case 5:
                    listContacts(contacts);
                    break;
                default:
                    System.out.println("Opção inválida");
                    break;
            }
        }
    }

    static void addContact(ArrayList<Contacts> contacts){
        System.out.println("Insira o nome: ");
        String name = sc.nextLine();
        System.out.println("Insira o cc: ");
        String idStr = sc.nextLine();
        int id = Integer.parseInt(idStr);
        System.out.println("Insira data de nascimento(dd-mm-yyyy): ");
        String date = sc.nextLine();
        String[] dateParts = date.split("-");

        DateYMD birthDate = new DateYMD(Integer.parseInt(dateParts[0]), Integer.parseInt(dateParts[1]), Integer.parseInt(dateParts[2])); 
        Person person = new Person(name, id, birthDate);

        System.out.println("Email: ");
        String email = sc.nextLine();
        System.out.println("Número de telemóvel: ");
        String phoneNumber = sc.nextLine();

        Contacts contact = new Contacts(person, phoneNumber, email);

        for (int i = 0; i < contacts.size(); i++) {
            if (contacts.get(i).getPerson().equals(contact.getPerson())) {
                System.out.println("Esse contacto já existe, pretende criar um novo(s)?");
                String answer = sc.nextLine();
                if (answer.equalsIgnoreCase("s")) {
                    contacts.set(i, contact);
                    return;
                }
                else{
                    return;
                }
            }
        }
        contacts.add(contact);
    }

    static void changeContact(ArrayList<Contacts> contacts){
        ArrayList<Integer> indexToChange = new ArrayList<>();

        System.out.println("Introduza o nome ou número da pessoa: ");
        String infoPerson = sc.nextLine();
        for (int i = 0; i < contacts.size(); i++) {
            if (contacts.get(i).getPerson().getName().equals(infoPerson) || contacts.get(i).getPhoneNumber().equals(infoPerson)) {
                indexToChange.add(i);
            }
        }
        if (indexToChange.size() > 1) {
            for (int i = 0; i < indexToChange.size(); i++) {
                System.out.println(contacts.get(indexToChange.get(i)));
            }
            System.out.println("Introduza o ID de qual pretende alterar: ");
            int idPersonToChange = sc.nextInt();

            for (int i = 0; i < indexToChange.size(); i++) {
                if (contacts.get(indexToChange.get(i)).getId() == idPersonToChange) {
                    System.out.println("Email: ");
                    String email = sc.nextLine();
                    System.out.println("Número de telemóvel: ");
                    String phoneNumber = sc.nextLine();
                    if (email.isEmpty() && !phoneNumber.isEmpty()) {
                        contacts.get(indexToChange.get(i)).setPhoneNumber(phoneNumber);
                    }
                    else if (phoneNumber.isEmpty() && !email.isEmpty()){
                        contacts.get(indexToChange.get(i)).setEmail(email);
                    }
                    else {
                        contacts.get(indexToChange.get(i)).setPhoneNumber(phoneNumber);
                        contacts.get(indexToChange.get(i)).setEmail(email);
                    }
                    break;
                }
            }
        }
        else if (indexToChange.size() == 1) {
            System.out.println(contacts.get(indexToChange.get(0)));
            System.out.println("Email: ");
            String email = sc.nextLine();
            System.out.println("Número de telemóvel: ");
            String phoneNumber = sc.nextLine();
            if (email.isEmpty()) {
                contacts.get(indexToChange.get(0)).setPhoneNumber(phoneNumber);
            }
            else if (phoneNumber.isEmpty()){
                contacts.get(indexToChange.get(0)).setEmail(email);
            }
            else {
                contacts.get(indexToChange.get(0)).setPhoneNumber(phoneNumber);
                contacts.get(indexToChange.get(0)).setEmail(email);
            }
        }
        else{
            System.out.println("No contacts found");
        }
    }

    static void deleteContact(ArrayList<Contacts> contacts){
        int indexToChange = contactSelect(contacts);
        if (indexToChange == -1) {
            System.out.println("Contact not found");
        }
        else{
            contacts.remove(indexToChange);
        }
    }

    static void searchContact(ArrayList<Contacts> contacts){
        int indexToChange = contactSelect(contacts);
        if (indexToChange == -1) {
            System.out.println("Contact not found");
        }
        else{
            System.out.println(contacts.get(indexToChange));

        }
    }

    static void listContacts(ArrayList<Contacts> contacts){
        for (Contacts contact : contacts) {
            System.out.println(contact);
        }
    }


    static int contactSelect(ArrayList<Contacts> contacts){
        ArrayList<Integer> indexToChange = new ArrayList<>();
        int idPersonToChange;
        
        System.out.println("Introduza o nome ou número da pessoa: ");
        String infoPerson = sc.nextLine();
        for (int i = 0; i < contacts.size(); i++) {
            if (contacts.get(i).getPerson().getName().equals(infoPerson) || contacts.get(i).getPhoneNumber().equals(infoPerson)) {
                indexToChange.add(i);
            }
        }
        if (indexToChange.size() > 1) {
            for (int i = 0; i < indexToChange.size(); i++) {
                System.out.println(contacts.get(indexToChange.get(i)));
            }
            System.out.println("Introduza o ID de qual pretende alterar: ");
            idPersonToChange = sc.nextInt();

            for (int i = 0; i < indexToChange.size(); i++) {
                if (contacts.get(indexToChange.get(i)).getId() == idPersonToChange) {
                    //return idPersonToChange;
                    return indexToChange.get(i);
                }
            }
        }
        else if (indexToChange.size() == 1) {
            //return contacts.get(indexToChange.get(0)).getId();
            return indexToChange.get(0);
        }
        return -1;
    }
}
