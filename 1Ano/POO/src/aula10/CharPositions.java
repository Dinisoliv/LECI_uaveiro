package aula10;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CharPositions {
    private HashMap<Character, List<Integer>> charMap;

    public CharPositions() {
        charMap = new HashMap<>();
    }

    public void findCharPositions(String input) {
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (charMap.containsKey(c)) {
                charMap.get(c).add(i);
            } else {
                List<Integer> positions = new ArrayList<>();
                positions.add(i);
                charMap.put(c, positions);
            }
        }
    }

    public void printCharPositions() {
        System.out.println(charMap);
    }
}