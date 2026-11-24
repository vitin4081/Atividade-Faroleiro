public class Main {
    public static void main(String[] args) {
        Faroleiro f = new Faroleiro("F1", 0, 0, 120, 0);        // linha 1
        RecursoDoFarol q = new Querosene("Q1", 15);                                   // linha 2
        RecursoDoFarol l = new LenteDeCristal("L1", -4);                                    // linha 3
        RecursoDoFarol o = new OndaGigante("O1", 70);                                 // linha 4
        f.patrulhar();                                                                         // linha 5
        f.operarRecurso(o);                                                                    // linha 6
        f.operarRecurso(l);                                                                    // linha 7
        f.operarRecurso(null);                                                         // linha 8
        f.operarRecurso(o);                                                                    // linha 9
        f.operarRecurso(q);                                                                    // linha 10
        System.out.println(f.getId() + " termina com energia " + f.getEnergia());                      // linha 11
    }
}