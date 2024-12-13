public class Restaurante extends Local{
    private TipoComida tipoComida;

    public Restaurante(String nome, TipoComida tipoComida) {
        super(nome);
        this.tipoComida = tipoComida;
    }

    public TipoComida getTipoComida() {
        return tipoComida;
    }

    @Override
    public String toString() {
        return "Restaurante " + super.toString() + ", " + tipoComida.toString();
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((tipoComida == null) ? 0 : tipoComida.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Restaurante other = (Restaurante) obj;
        if (tipoComida != other.tipoComida)
            return false;
        return true;
    }

    
    
    
}
