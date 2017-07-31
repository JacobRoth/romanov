import ddf.minim.*;

Game game;
Minim minim;
AudioPlayer audioPlayer;  // maybe this should be a property of Game?

void setup() {
  size(1200,450);
  minim = new Minim(this);
  game = new Game(); 
  
}

void draw() {
  game.currentState.draw(game);
}

void mouseClicked() {
  game.currentState.mouseClicked(game);
}
/*
void mouseClicked() {
  int wIndex = floor(mouseX/game.t.tileWidth);
  int hIndex = floor(mouseY/game.t.tileWidth);
  if (wIndex < game.t.tiles.length) {
    if (hIndex < game.t.tiles[wIndex].length) { 
      Tile clickedTile = game.t.tiles[wIndex][hIndex];
      //println(clickedTile.type);
      //println(clickedTile.northNeighbor.equals(clickedTile));
      println(game.t.shortestPath(game.t.tiles[0][0],clickedTile));
    }
  }
} */

class Game {
  TileMap t;

  ArrayList<ProcedureState> states;
  ProcedureState currentState;
  Game() {
    // first, create the game map.
    this.t = new TileMap(11,6);
    while (this.t.shortestPath(this.t.tiles[10][5],this.t.tiles[0][0])==Integer.MAX_VALUE) {
      this.t = new TileMap(11,6);
    }
    // now deal with the audio things
    // now create the states list
    this.states = new ArrayList();
    this.states.add(new OpeningAnimationState());
    this.states.add(new TestMapState());

    // make the map state the current
    this.currentState = this.states.get(0);
  }
}

interface ProcedureState {
  void draw(Game g);
  void mouseClicked(Game g);
}

class TestMapState implements ProcedureState {
  TestMapState() {} // trivial constructor, nothing to see here
  void draw(Game g) {
    g.t.render(); // right now, just render the tiles
  }
  void mouseClicked(Game g) {
    int wIndex = floor(mouseX/g.t.tileWidth);
    int hIndex = floor(mouseY/g.t.tileWidth);
    if (wIndex < g.t.tiles.length) {
      if (hIndex < g.t.tiles[wIndex].length) { 
        Tile clickedTile = g.t.tiles[wIndex][hIndex];
        //println(clickedTile.type);
        //println(clickedTile.northNeighbor.equals(clickedTile));
        println(g.t.shortestPath(g.t.tiles[0][0],clickedTile));
      }
    }
  }
} 



