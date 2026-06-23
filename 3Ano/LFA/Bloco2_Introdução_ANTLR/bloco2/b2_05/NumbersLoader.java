import java.util.HashMap;

public class NumbersLoader extends NumbersBaseListener {

    private HashMap<Integer, String> numbers = new HashMap<>();

    @Override
    public void exitLine(NumbersParser.LineContext ctx) {
        int key     = Integer.parseInt(ctx.INT().getText());
        String name = ctx.WORD().getText();
        numbers.put(key, name);
    }

    public HashMap<Integer, String> getNumbers() {
        return numbers;
    }
}