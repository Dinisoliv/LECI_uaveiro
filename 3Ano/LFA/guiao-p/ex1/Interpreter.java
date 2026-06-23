import java.util.*;

public class Interpreter extends StrLangBaseVisitor<String> {

    private HashMap<String, String> vars = new HashMap<>();

    // strip surrounding quotes from STRING token
    private String strip(String s) {
        return s.substring(1, s.length() - 1);
    }

    @Override
    public String visitProgram(StrLangParser.ProgramContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public String visitStatPrint(StrLangParser.StatPrintContext ctx) {
        String val = visit(ctx.expr());
        if (val != null) {
            System.out.println(val);
            System.out.flush();
        }
        return null;
    }

    @Override
    public String visitStatAssign(StrLangParser.StatAssignContext ctx) {
        String val = visit(ctx.expr());
        if (val != null)
            vars.put(ctx.ID().getText(), val);
        return null;
    }

    @Override
    public String visitStatEmpty(StrLangParser.StatEmptyContext ctx) {
        return null;
    }

    @Override
    public String visitExprString(StrLangParser.ExprStringContext ctx) {
        return strip(ctx.STRING().getText());
    }

    @Override
    public String visitExprId(StrLangParser.ExprIdContext ctx) {
        String name = ctx.ID().getText();
        if (!vars.containsKey(name)) {
            System.err.println("Error: undefined variable '" + name + "'");
            return null;
        }
        return vars.get(name);
    }

    @Override
    public String visitExprParen(StrLangParser.ExprParenContext ctx) {
        return visit(ctx.expr());
    }

    @Override
    public String visitExprConcat(StrLangParser.ExprConcatContext ctx) {
        String left  = visit(ctx.expr(0));
        String right = visit(ctx.expr(1));
        if (left == null || right == null) return null;
        return left + right;
    }

    @Override
    public String visitExprRemove(StrLangParser.ExprRemoveContext ctx) {
        String left  = visit(ctx.expr(0));
        String right = visit(ctx.expr(1));
        if (left == null || right == null) return null;
        return left.replace(right, "");
    }

    @Override
    public String visitExprTrim(StrLangParser.ExprTrimContext ctx) {
        String val = visit(ctx.expr());
        if (val == null) return null;
        return val.trim();
    }

    @Override
    public String visitExprReplace(StrLangParser.ExprReplaceContext ctx) {
        String base    = visit(ctx.expr());
        String target  = strip(ctx.STRING(0).getText());
        String replace = strip(ctx.STRING(1).getText());
        if (base == null) return null;
        return base.replace(target, replace);
    }

    @Override
    public String visitExprInput(StrLangParser.ExprInputContext ctx) {
        String prompt = strip(ctx.STRING().getText());
        System.out.print(prompt);
        System.out.flush();
        Scanner scanner = new Scanner(System.in);
        return scanner.nextLine();
    }
}