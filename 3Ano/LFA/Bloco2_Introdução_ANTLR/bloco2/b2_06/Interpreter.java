import java.util.HashMap;

public class Interpreter extends CalculatorVarsBaseVisitor<Long> {

    private HashMap<String, Long> vars = new HashMap<>();

    @Override
    public Long visitProgram(CalculatorVarsParser.ProgramContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public Long visitStatAssignment(CalculatorVarsParser.StatAssignmentContext ctx) {
        Long value = visit(ctx.assignment().expr());
        vars.put(ctx.assignment().ID().getText(), value);
        System.out.println(ctx.assignment().ID().getText() + " = " + value);
        return value;
    }

    @Override
    public Long visitStatExpr(CalculatorVarsParser.StatExprContext ctx) {
        Long result = visit(ctx.expr());
        if (result != null)
            System.out.println(result);
        return null;
    }

    @Override
    public Long visitStatEmpty(CalculatorVarsParser.StatEmptyContext ctx) {
        return null;
    }

    @Override
    public Long visitExprId(CalculatorVarsParser.ExprIdContext ctx) {
        String name = ctx.ID().getText();
        if (!vars.containsKey(name)) {
            System.err.println("Error: undefined variable '" + name + "'");
            return null;
        }
        return vars.get(name);
    }

    @Override
    public Long visitExprInteger(CalculatorVarsParser.ExprIntegerContext ctx) {
        return Long.parseLong(ctx.Integer().getText());
    }

    @Override
    public Long visitExprParent(CalculatorVarsParser.ExprParentContext ctx) {
        return visit(ctx.expr());
    }

    @Override
    public Long visitExprUnary(CalculatorVarsParser.ExprUnaryContext ctx) {
        Long val = visit(ctx.expr());
        if (val == null) return null;
        switch (ctx.op.getText()) {
            case "+": return val;
            case "-": return -val;
            default: throw new RuntimeException("Unknown unary operator: " + ctx.op.getText());
        }
    }

    @Override
    public Long visitExprMultDivMod(CalculatorVarsParser.ExprMultDivModContext ctx) {
        Long left  = visit(ctx.expr(0));
        Long right = visit(ctx.expr(1));
        if (left == null || right == null) return null;
        switch (ctx.op.getText()) {
            case "*": return left * right;
            case "/":
                if (right == 0L) {
                    System.err.println("Error: division by zero");
                    return null;
                }
                return left / right;
            case "%":
                if (right == 0L) {
                    System.err.println("Error: modulo by zero");
                    return null;
                }
                return left % right;
            default: throw new RuntimeException("Unknown operator: " + ctx.op.getText());
        }
    }

    @Override
    public Long visitExprAddSub(CalculatorVarsParser.ExprAddSubContext ctx) {
        Long left  = visit(ctx.expr(0));
        Long right = visit(ctx.expr(1));
        if (left == null || right == null) return null;
        switch (ctx.op.getText()) {
            case "+": return left + right;
            case "-": return left - right;
            default: throw new RuntimeException("Unknown operator: " + ctx.op.getText());
        }
    }
}