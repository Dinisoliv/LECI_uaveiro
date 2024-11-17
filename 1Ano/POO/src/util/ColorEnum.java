package util;

public enum ColorEnum {
    RED("#FF0000"),
    GREEN("#00FF00"),
    BLUE("#0000FF");

    private String hexCode;

    ColorEnum(String hexCode) {
        this.hexCode = hexCode;
    }

    public String getHexCode() {
        return hexCode;
    }

    public String getDescription() {
        switch (this) {
            case RED:
                return "This is the color red";
            case GREEN:
                return "This is the color green";
            case BLUE:
                return "This is the color blue";
            default:
                return "Unknown color";
        }
    }

    public boolean isBright() {
        return this == ColorEnum.RED || this == ColorEnum.GREEN;
    }

    public static ColorEnum fromString(String value) {
        for (ColorEnum color : ColorEnum.values()) {
            if (color.name().equalsIgnoreCase(value)) {
                return color;
            }
        }
        throw new IllegalArgumentException("No constant with value " + value + " found");
    }
}
