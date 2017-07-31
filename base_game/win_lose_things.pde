class LoseState implements ProcedureState {
  PImage loseScreenImage; 
  LoseState() {
    this.loseScreenImage = loadImage("game_over.png");} 
    void draw(Game g) {
      background(255,0,0);
      image(this.loseScreenImage,0,0);
      // also need to add some text here
    }
    void mouseClicked(Game g) {
      g.isOver=true;
  }
}


class WinState implements ProcedureState {
  PImage winScreenImage; 
  WinState() {
    this.winScreenImage = loadImage("win_screen.png");} 
    void draw(Game g) {
      background(255,0,0);
      image(this.winScreenImage,0,0);
    }
    void mouseClicked(Game g) {
      g.isOver=true;
  }
}