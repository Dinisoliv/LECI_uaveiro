@SuppressWarnings("CheckReturnValue")
public class Interpreter extends PrefixCalculatorBaseVisitor<Double> {

   @Override public Double visitProgram(PrefixCalculatorParser.ProgramContext ctx) {
      Double res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Double visitStat(PrefixCalculatorParser.StatContext ctx) {
      if (ctx.expr() != null) {
         Double result = visit(ctx.expr());
         if (result != null) {
            System.out.println(result);
         }
      }
      return null;
   }

   @Override public Double visitExprPrefix(PrefixCalculatorParser.ExprPrefixContext ctx) {
      Double left = visit(ctx.expr(0));
      Double right = visit(ctx.expr(1));
      switch (ctx.op.getText()) {
         case "+":
            return left + right;
         case "-":
            return left - right;
         case "*":
            return left * right;
         case "/":
            if (right == 0.0) {
               System.err.println("Error: Division by zero");
               return null;
            }
         return left / right;
      }
      return null; // Should never reach here
   }

   @Override public Double visitExprNumber(PrefixCalculatorParser.ExprNumberContext ctx) {
      return Double.parseDouble(ctx.Number().getText());
   }
}
