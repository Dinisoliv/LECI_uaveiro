public enum Transporte {
    AUTOCARRO, TODOTERRENO, BICICLETA;

    public String toString() {
        switch (this) {
            case AUTOCARRO:
                return "Automóvel";
            case TODOTERRENO:
                return "Todo Terreno";
            case BICICLETA:
                return "Bicicleta";
            default:
                throw new IllegalStateException("Unexpected value: " + this);
        }
    }

    public static Transporte fromString(String value) {
        for (Transporte transporte : Transporte.values()) {
            if (transporte.name().equalsIgnoreCase(value)) {
                return transporte;
            }
        }
        throw new IllegalArgumentException("No constant with value " + value + " found");
    }
}
