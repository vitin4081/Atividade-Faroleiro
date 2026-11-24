public class Contrabandista extends HabitanteDaIlha
{
    private String tipo;

    public Contrabandista(String id, int posX, int posY, int energia, int pontuacao) {
        super(id, posX, posY, energia);
        this.tipo = tipo;
    }

    @Override
    public void patrulhar() {
        moverPosicao(1, 0);
        setEnergia(getEnergia() - 10);
        System.out.println(getId() + " patrulha o farol");
    }

    public void operarRecurso(RecursoDoFarol recurso) throws RecursoInvalidoException {
        if (recurso == null) {
            throw new RecursoInvalidoException("Não foi possível operar: o recurso fornecido não existe (é nulo).");
        }
        setEnergia(getEnergia() + recurso.usar());
        System.out.println(getId() + " operou o recurso com sucesso!");
    }
}
