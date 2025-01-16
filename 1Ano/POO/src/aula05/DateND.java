package aula05;

public class DateND{
    private int daysFrom2000;

    public DateND(int daysFrom2000){
        this.daysFrom2000 = daysFrom2000;
    }

    public int getDaysFrom2000 (){
        return daysFrom2000;
    }

    public void increment(int daysFrom2000){
        daysFrom2000++;
    }

    public void decrement(int daysFrom2000){
        daysFrom2000--;
    }

    public DateYMD getDateYMDFormat(int daysFrom2000){
        DateYMD baseDate = new DateYMD(1, 1, 2000);
        for (int i = 0; i < daysFrom2000; i++) {
            baseDate.increment();
        }
        return baseDate;
    }

    @Override
    public boolean equals(Object obj){
        DateND dateND = (DateND) obj;
        return daysFrom2000 == dateND.daysFrom2000;
    }
}
