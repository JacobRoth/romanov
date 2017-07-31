class LoseState implements ProcedureState {
  PImage loseScreenImage; // Zoe - can you make a good image here?
  LoseState() {} // trivial constructor now, will load image later
  void draw(Game g) {
    background(255,0,0);
    // also need to add some text here
  }
  void mouseClicked(Game g) {
    g.isOver=true;
  }
}


// also need to add a win state which triggers if you get to 
// Rasputin's house
