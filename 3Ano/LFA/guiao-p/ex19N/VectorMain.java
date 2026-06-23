import java.io.IOException;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class VectorMain {
    public static void main(String[] args) throws IOException {

        // Read input: from file (first argument) or from stdin
        CharStream input = (args.length > 0)
                ? CharStreams.fromFileName(args[0])
                : CharStreams.fromStream(System.in);

        // ── Lexical analysis ──────────────────────────────────────────────────
        VectorLexer  lexer  = new VectorLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // ── Syntactic analysis ────────────────────────────────────────────────
        VectorParser parser = new VectorParser(tokens);
        ParseTree    tree   = parser.program();   // start rule

        // Stop if there were syntax errors
        if (parser.getNumberOfSyntaxErrors() != 0) {
            System.err.println("Aborting due to syntax errors.");
            System.exit(1);
        }

        // ── Semantic analysis + execution (visitor) ───────────────────────────
        VectorVisitor visitor = new VectorVisitor();
        visitor.visit(tree);
    }
}
