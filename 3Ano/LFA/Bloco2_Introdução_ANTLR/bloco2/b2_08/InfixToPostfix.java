@SuppressWarnings("CheckReturnValue")
public class InfixToPostfix extends CalculatorVarsBaseVisitor<String> {

   @Override public String visitProgram(CalculatorVarsParser.ProgramContext ctx) {
      String res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public String visitStatAssignment(CalculatorVarsParser.StatAssignmentContext ctx) {
      String postfix = visit(ctx.assignment().expr());
        System.out.println(ctx.assignment().ID().getText() + " = " + postfix);
        return null;
   }

   @Override public String visitStatExpr(CalculatorVarsParser.StatExprContext ctx) {
      String postfix = visit(ctx.expr());
      if (postfix != null) {
         System.out.println(postfix);
      }
      return null;
   }

   @Override public String visitStatEmpty(CalculatorVarsParser.StatEmptyContext ctx) {
      String res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public String visitAssignment(CalculatorVarsParser.AssignmentContext ctx) {
      String res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public String visitExprParent(CalculatorVarsParser.ExprParentContext ctx) {
      return visit(ctx.expr());
   }

    @Override
    public String visitExprUnary(CalculatorVarsParser.ExprUnaryContext ctx) {
        String operand = visit(ctx.expr());
        // unary + and - become !+ and !-
        return operand + " !" + ctx.op.getText();
    }

    @Override
    public String visitExprMultDivMod(CalculatorVarsParser.ExprMultDivModContext ctx) {
        String left  = visit(ctx.expr(0));
        String right = visit(ctx.expr(1));
        return left + " " + right + " " + ctx.op.getText();
    }

    @Override
    public String visitExprAddSub(CalculatorVarsParser.ExprAddSubContext ctx) {
        String left  = visit(ctx.expr(0));
        String right = visit(ctx.expr(1));
        return left + " " + right + " " + ctx.op.getText();
    }

   @Override public String visitExprInteger(CalculatorVarsParser.ExprIntegerContext ctx) {
      return ctx.Integer().getText();
   }

   @Override public String visitExprId(CalculatorVarsParser.ExprIdContext ctx) {
      return ctx.ID().getText();
   }

   private String getOriginalText(ParserRuleContext ctx) {
    int start = ctx.start.getStartIndex();
    int stop  = ctx.stop.getStopIndex();
    return ctx.start.getTokenSource().getInputStream()
               .getText(new org.antlr.v4.runtime.misc.Interval(start, stop));
}
}
