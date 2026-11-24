import greenfoot.*;

public abstract class HabitanteDaIlha extends Actor {
    private final String id;
    protected int posX;
    protected int posY;
    private int energia;

    public HabitanteDaIlha(String id, int posX, int posY, int energia) {
        this.id = id;
        this.posX = posX;
        this.posY = posY;
        setEnergia(energia);
    }

    public String getId() {
        return id;
    }

    public int getEnergia() {
        return energia;
    }

    public void setEnergia(int energia) {
        if (energia > 100) {
            this.energia = 100;
        } else if (energia <= 0) {
            this.energia = 0;
            gameOver();
        } else {
            this.energia = energia;
        }
    }

    protected void moverPosicao(int dx, int dy) {
        this.posX = this.posX + dx;
        this.posY = this.posY + dy;
    }

    protected void gameOver() {
        System.out.println(id + ": fim de jogo!");
    }

    public abstract void patrulhar();
}