package util;

import java.util.Arrays;
import java.util.List;

public class EnumUtil {
    public enum Season {
        SPRING, SUMMER, FALL, WINTER
    }

    public static void main(String[] args) {
        // Using valueOf(String val)
        String seasonString = "SPRING";
        Season season = Season.valueOf(seasonString);
        System.out.println("The season is: " + season);

        // Using ordinal()
        Season summer = Season.SUMMER;
        int position = summer.ordinal();
        System.out.println("The position of " + summer + " is: " + position);

        // Using values()
        Season[] allSeasons = Season.values();
        System.out.println("All seasons:");
        for (Season s : allSeasons) {
            System.out.println(s);
        }

        // Using valueOf(String val) with error handling
        String invalidSeasonString = "AUTUMN"; // invalid season
        try {
            Season invalidSeason = Season.valueOf(invalidSeasonString);
            System.out.println("The season is: " + invalidSeason);
        } catch (IllegalArgumentException e) {
            System.out.println("Invalid season: " + invalidSeasonString);
        }

        // Using values() with stream operations
        List<Season> seasonsList = Arrays.asList(Season.values());
        long count = seasonsList.stream().filter(s -> s.name().startsWith("S")).count();
        System.out.println("Number of seasons starting with 'S': " + count);
    }
}

