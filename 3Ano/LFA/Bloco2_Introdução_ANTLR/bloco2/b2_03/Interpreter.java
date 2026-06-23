@SuppressWarnings("CheckReturnValue")
public class Interpreter extends CalculatorBaseVisitor<Long> {

    @Override
    public Long visitProgram(CalculatorParser.ProgramContext ctx) {
        return visitChildren(ctx);
    }

    @Override
    public Long visitStat(CalculatorParser.StatContext ctx) {
        if (ctx.expr() != null) {
            Long result = visit(ctx.expr());
            if (result != null)
                System.out.println(result);
        }
        return null;
    }

    @Override
    public Long visitExprInteger(CalculatorParser.ExprIntegerContext ctx) {
        return Long.parseLong(ctx.Integer().getText());
    }

    @Override
    public Long visitExprParent(CalculatorParser.ExprParentContext ctx) {
        return visit(ctx.expr());  // just evaluate what's inside
    }

    @Override
    public Long visitExprMultDivMod(CalculatorParser.ExprMultDivModContext ctx) {
        Long left  = visit(ctx.expr(0));
        Long right = visit(ctx.expr(1));
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
               }
            return null;
    }

    @Override
    public Long visitExprAddSub(CalculatorParser.ExprAddSubContext ctx) {
        Long left  = visit(ctx.expr(0));
        Long right = visit(ctx.expr(1));
        switch (ctx.op.getText()) {
            case "+": return left + right;
            case "-": return left - right;
         }
         return null;
    }

    @Override
    public Long visitExprUnary(CalculatorParser.ExprUnaryContext ctx) {
        Long val = visit(ctx.expr());
        switch (ctx.op.getText()) {
            case "+": return val;
            case "-": return -val;
         }
         return null;
      }
}

