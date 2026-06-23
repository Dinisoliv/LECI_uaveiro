package b2_10;

import java.util.List;

public class Question {
    public String id;
    public String text;
    public List<Answer> answers;

    public Question(String id, String text, List<Answer> answers) {
        this.id      = id;
        this.text    = text;
        this.answers = answers;
    }
}