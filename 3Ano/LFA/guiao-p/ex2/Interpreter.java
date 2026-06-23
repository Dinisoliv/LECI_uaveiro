import java.util.HashMap;

import java.util.Scanner;

@SuppressWarnings("CheckReturnValue")
public class Interpreter extends FracLangBaseVisitor<Fraction> {

   private HashMap<String, Fraction> vars = new HashMap<>();

   private Scanner sc = new Scanner(System.in); 

   @Override public Fraction visitProgram(FracLangParser.ProgramContext ctx) {
      Fraction res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Fraction visitStatDisplay(FracLangParser.StatDisplayContext ctx) {
      Fraction val = visit(ctx.expr());
      if (val != null) {
         System.out.println(val);
      }
      return null;
   }

   @Override public Fraction visitStatAssign(FracLangParser.StatAssignContext ctx) {
      Fraction val = visit(ctx.expr());
      if (val != null) {
         vars.put(ctx.ID().getText(), val);
      }
      return null;
   }

   @Override public Fraction visitStatEmpty(FracLangParser.StatEmptyContext ctx) {
      return null;
   }

   @Override public Fraction visitExprFraction(FracLangParser.ExprFractionContext ctx) {
      int num = Integer.parseInt(ctx.INT(0).getText());
      int den = Integer.parseInt(ctx.INT(1).getText());
      /*
      if (den == 0){
         System.err.println("Error: zero denominator");
         return null;
      }
      */
      return new Fraction(num, den);

   }

   @Override public Fraction visitExprInteger(FracLangParser.ExprIntegerContext ctx) {
      return new Fraction(Integer.parseInt(ctx.INT().getText()), 1);
   }

   @Override public Fraction visitExprId(FracLangParser.ExprIdContext ctx) {
      String name = ctx.ID().getText();
      if (!vars.containsKey(name)) {
         System.err.println("Error: undefined variable '" + name + "'");
         return null;
      }
      return vars.get(name);
   }

   @Override
   public Fraction visitExprUnary(FracLangParser.ExprUnaryContext ctx) {
      Fraction val = visit(ctx.expr());
      if (val == null) return null;
      return ctx.op.getText().equals("-") ? val.neg() : val;
   }

   @Override
   public Fraction visitExprMulDiv(FracLangParser.ExprMulDivContext ctx) {
      Fraction left  = visit(ctx.expr(0));
      Fraction right = visit(ctx.expr(1));
      if (left == null || right == null) return null;
      return ctx.op.getText().equals("*") ? left.mul(right) : left.div(right);
   }

   @Override
   public Fraction visitExprAddSub(FracLangParser.ExprAddSubContext ctx) {
      Fraction left  = visit(ctx.expr(0));
      Fraction right = visit(ctx.expr(1));
      if (left == null || right == null) return null;
      return ctx.op.getText().equals("+") ? left.add(right) : left.sub(right);
   }

   @Override
   public Fraction visitExprParen(FracLangParser.ExprParenContext ctx) {
      return visit(ctx.expr());
   }

   @Override public Fraction visitExprRead(FracLangParser.ExprReadContext ctx) {
      String prompt = ctx.STRING().getText();
      prompt = prompt.substring(1, prompt.length()-1);

      System.out.println(prompt + ": ");

      String line = sc.nextLine().trim();

      if (line.contains(line)) {
         String[] parts = line.split("/");
         int num = Integer.parseInt(parts[0].trim());
         int den = Integer.parseInt(parts[1].trim());
         if (den == 0) {
            System.err.println("Error: zero denominator");
            return null;
         }
         return new Fraction(num, den);
      }else{
         return new Fraction(Integer.parseInt(line),1);
      }
   }

}
