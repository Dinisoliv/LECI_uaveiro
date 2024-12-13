package aula08.ex2;

public enum VariedadeCarne {
    VACA, PORCO, PERU, FRANGO, OUTRA;
    
    public static VariedadeCarne fromString(String string) {
        return switch (string.toUpperCase()) {
            case "VACA" -> VACA;
            case "PORCO" -> PORCO;
            case "PERU" -> PERU;
            case "FRANGO" -> FRANGO;
            default -> OUTRA;
        };
    }

    @Override
    public String toString() {
        return switch (this) {
            case VACA -> "VACA";
            case PORCO -> "PORCO";
            case PERU -> "PERU";
            case FRANGO -> "FRANGO";
            default -> "OTHER";
        };
    }
}
