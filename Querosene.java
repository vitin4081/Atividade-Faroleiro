public class Querosene implements RecursoDoFarol {
    private String id;
    private int valor;

    public Querosene(String id, int valor) {
        this.id = id;
        setValor(valor);
    }

    private void setValor(int valor) {
        if (valor <= 0) {
            this.valor = 1;
        } else {
            this.valor = valor;
        }
    }

    @Override
    public int usar() {
        return valor;
    }
}
