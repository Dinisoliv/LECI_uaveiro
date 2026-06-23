import org.stringtemplate.v4.*;
import java.util.*;

public class CSVtoHTML extends CSVBaseVisitor<List<String>> {

    private STGroup group = new STGroupFile("html.stg");
    private List<String> headers = new ArrayList<>();
    private List<List<String>> rows = new ArrayList<>();
    private boolean firstRow = true;

    @Override
    public List<String> visitFile(CSVParser.FileContext ctx) {
        visitChildren(ctx);
        
        ST st = group.getInstanceOf("htmlFile");
        st.add("headers", headers);
        st.add("rows", rows);
        System.out.println(st.render());
        return null;
    }

    @Override
    public List<String> visitRow(CSVParser.RowContext ctx) {
        List<String> cells = new ArrayList<>();
        for (CSVParser.FieldContext f : ctx.field())
            cells.add(f.getText());

        if (firstRow) {
            headers = cells;
            firstRow = false;
        } else {
            rows.add(cells);
        }
        return cells;
    }
}  