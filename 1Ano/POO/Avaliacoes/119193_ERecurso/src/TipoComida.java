public enum TipoComida {
    MEDITERRANICA, ORIENTAL, VEGETARIANA;
    
    public String toString() {
        switch (this) {
            case MEDITERRANICA:
                return "Mediterrânea";
            case ORIENTAL:
                return "Oriental";
            case VEGETARIANA:
                return "Vegetariana";
            default:
                throw new IllegalStateException("Unexpected value: " + this);
        }
    }

    public static TipoComida fromString(String value) {
        for (TipoComida tipoComida : TipoComida.values()) {
            if (tipoComida.name().equalsIgnoreCase(value)) {
                return tipoComida;
            }
        }
        throw new IllegalArgumentException("No constant with value " + value + " found");
    }
}
