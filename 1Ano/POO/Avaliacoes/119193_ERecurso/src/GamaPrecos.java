public enum GamaPrecos {
    GRATUITO, BAIXO, MEDIO;

    public String toString() {
        switch (this) {
            case GRATUITO:
                return "Gratuito";
            case BAIXO:
                return "Baixo";
            case MEDIO:
                return "Médio";
            default:
                throw new IllegalStateException("Unexpected value: " + this);
        }
    }

    public static GamaPrecos fromString(String value) {
        for (GamaPrecos gamaPrecos : GamaPrecos.values()) {
            if (gamaPrecos.name().equalsIgnoreCase(value)) {
                return gamaPrecos;
            }
        }
        throw new IllegalArgumentException("No constant with value " + value + " found");
    }
}
