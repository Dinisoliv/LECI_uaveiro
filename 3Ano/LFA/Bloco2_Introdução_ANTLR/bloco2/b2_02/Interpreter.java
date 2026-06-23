   @SuppressWarnings("CheckReturnValue")
public class Interpreter extends SuffixCalculatorBaseVisitor<Double> {

    @Override
    public Double visitProgram(SuffixCalculatorParser.ProgramContext ctx) {
        return visitChildren(ctx);  // visit all stats
    }

    @Override
    public Double visitStat(SuffixCalculatorParser.StatContext ctx) {
        if (ctx.expr() != null) {
            Double result = visit(ctx.expr());
            if (result != null) {                
                System.out.println(result);  // print the result of each line
            }
        }
        return null;
    }

    @Override
    public Double visitExprNumber(SuffixCalculatorParser.ExprNumberContext ctx) {
        // Convert the Number token text to a double
        return Double.parseDouble(ctx.Number().getText());
    }

    @Override
    public Double visitExprSuffix(SuffixCalculatorParser.ExprSuffixContext ctx) {
        // Visit left and right operands first
        Double left  = visit(ctx.expr(0));
        Double right = visit(ctx.expr(1));
        // Then apply the operator
        switch (ctx.op.getText()) {
            case "+": return left + right;
            case "-": return left - right;
            case "*": return left * right;
            case "/":
                if (right == 0.0) {
                    System.err.println("Error: division by zero");
                }
                return left / right;
            }
        return null;
    }
}
