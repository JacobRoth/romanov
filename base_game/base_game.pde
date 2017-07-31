import ddf.minim.*;

Game game;
Minim minim;
AudioPlayer audioPlayer;  // maybe this should be a property of Game?

final int phoneScreenOriginX = 27;
final int phoneScreenOriginY = 34;
final int phoneScreenW = 195;
final int phoneScreenH = 363;

final int rotatedPhoneScreenOriginX = 62;
final int rotatedPhoneScreenOriginY = 52;	

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

class Game {
  TileMap t;
  int phonePower;
  int maxPhonePower;
  PImage phoneHorizontal;
  PImage phoneVertical;

  //ArrayList<ProcedureState> states;
  ProcedureState openingAnimation;
  ProcedureState testMap;
  ProcedureState movingAnimation;
  
  ProcedureState currentState;
 
  Game() {
    // first set up the phone stats
    this.phonePower = 100;
    this.maxPhonePower = 100;
    // now get those phone image
    phoneHorizontal = loadImage("phone_horizontal.png");
    phoneVertical = loadImage("phone_vertical.png");
    // then create the game map.
    this.t = new TileMap(11,6,50,50);
    while (this.t.shortestPath(this.t.tiles[10][5],this.t.tiles[0][0])==Integer.MAX_VALUE) {
      this.t = new TileMap(11,6,rotatedPhoneScreenOriginX,rotatedPhoneScreenOriginY);
    }
    // now create the procedure states
    this.openingAnimation = new OpeningAnimationState();
    this.testMap = new TestMapState();
    this.movingAnimation = new MovingAnimationState();

    // make the map state the current
    this.currentState = this.testMap;
  }
}

interface ProcedureState {
  void draw(Game g);
  void mouseClicked(Game g);
}
