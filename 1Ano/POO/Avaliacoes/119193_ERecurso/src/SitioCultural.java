public class SitioCultural extends Local{
    private TipoCultural tipoCultural;
    private GamaPrecos gamaPrecos;
    
    public SitioCultural(String nome, TipoCultural tipoCultural, GamaPrecos gamaPrecos) {
        super(nome);
        this.tipoCultural = tipoCultural;
        this.gamaPrecos = gamaPrecos;
    }

    public TipoCultural getTipoCultural() {
        return tipoCultural;
    }

    public GamaPrecos getGamaPrecos() {
        return gamaPrecos;
    }

    @Override
    public String toString() {
        return super.toString();
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = super.hashCode();
        result = prime * result + ((tipoCultural == null) ? 0 : tipoCultural.hashCode());
        result = prime * result + ((gamaPrecos == null) ? 0 : gamaPrecos.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (!super.equals(obj))
            return false;
        if (getClass() != obj.getClass())
            return false;
        SitioCultural other = (SitioCultural) obj;
        if (tipoCultural != other.tipoCultural)
            return false;
        if (gamaPrecos != other.gamaPrecos)
            return false;
        return true;
    }

    

    
}
