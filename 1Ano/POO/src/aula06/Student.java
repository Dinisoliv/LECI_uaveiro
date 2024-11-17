package aula06;

import java.time.LocalDate;
import aula05.DateYMD;

    public class Student extends Person{
        private int nextRegistrationNumber = 100;
        private int nMec;
        private DateYMD registrationDate;

        public Student(String name, int idNumber, DateYMD dateOfBirth, DateYMD registrationDate){
            super(name, idNumber, dateOfBirth);
            this.nMec = nextRegistrationNumber++;
            this.registrationDate = registrationDate;
        }

        public Student(String name, int idNumber, DateYMD dateOfBirth){
            super(name, idNumber, dateOfBirth);
            this.nMec = nextRegistrationNumber++;
            this.registrationDate = new DateYMD(LocalDate.now().getDayOfMonth(), LocalDate.now().getMonthValue(), LocalDate.now().getYear());
        }

        public int getNMEc(){
            return nMec;
        }

        public DateYMD getregistrationDate(){
            return registrationDate;
        }

        public void setNMec(int nMec){
            this.nMec = nMec;
        }

        public void setregistrationDate(DateYMD registrationDate){
            this.registrationDate = registrationDate;
        }

        public String toString(){
            return String.format(" nome:%s id:%d birthday:%s NMEc:%d DataIncrição:%s ", 
                        getName(), getIdNumber(), getDateOfBirth(), nMec, registrationDate);
        }
    }
