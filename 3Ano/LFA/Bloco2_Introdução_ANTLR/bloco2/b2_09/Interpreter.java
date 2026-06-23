import java.util.HashMap;

@SuppressWarnings("CheckReturnValue")
public class Interpreter extends FractionsBaseVisitor<Fraction> {

   @Override public Fraction visitProgram(FractionsParser.ProgramContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitStatPrint(FractionsParser.StatPrintContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitStatAssign(FractionsParser.StatAssignContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitStatComment(FractionsParser.StatCommentContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprAddSub(FractionsParser.ExprAddSubContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprParen(FractionsParser.ExprParenContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprMulDiv(FractionsParser.ExprMulDivContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprUnary(FractionsParser.ExprUnaryContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprPowerParen(FractionsParser.ExprPowerParenContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprInteger(FractionsParser.ExprIntegerContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprPower(FractionsParser.ExprPowerContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprReduce(FractionsParser.ExprReduceContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprId(FractionsParser.ExprIdContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitExprFraction(FractionsParser.ExprFractionContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }
}
