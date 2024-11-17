public enum TipoCultural {
    MUSEUAARTE, MUSEUCIENCIA, HISTORICO, RELIGIOSO;

    public String toString() {
        switch (this) {
            case MUSEUAARTE:
                return "Museu de Arte";
            case MUSEUCIENCIA:
                return "Museu de Ciência";
            case HISTORICO:
                return "Histórico";
            case RELIGIOSO:
                return "Religioso";
            default:
                throw new IllegalStateException("Unexpected value: " + this);
        }
    }

    public static TipoCultural fromString(String value) {
        for (TipoCultural tipoCultural : TipoCultural.values()) {
            if (tipoCultural.name().equalsIgnoreCase(value)) {
                return tipoCultural;
            }
        }
        throw new IllegalArgumentException("No constant with value " + value + " found");
    }
}
