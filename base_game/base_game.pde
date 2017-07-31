import ddf.minim.*;

Game game;
Minim minim;
AudioPlayer audioPlayer;  // maybe this should be a property of Game?

final int phoneScreenOriginX = 27;
final int phoneScreenOriginY = 34;
final int phoneScreenW = 195;
final int phoneScreenH = 363;

final int rotatedPhoneScreenOriginX = 105;
final int rotatedPhoneScreenOriginY = 34;	

void setup() {
  size(1200,450);
  minim = new Minim(this);
  game = new Game(); 
  
}

void draw() {
  game.currentState.draw(game);
  if(game.isOver) {
    game = new Game();
  }
}

void mouseClicked() {
  game.currentState.mouseClicked(game);
}

class Game {
  boolean isOver;

  TileMap t;
  int currentDay;
  int phonePower;
  int maxPhonePower;
  PImage phoneHorizontal;
  PImage phoneVertical;

  int anastasiaGridX; //note that these coordinates are in grid coords
  int anastasiaGridY; // not screen coords
  PImage anastasiaAvatar;

  //ArrayList<ProcedureState> states;
  ProcedureState openingAnimation;
  ProcedureState mapState;
  ProcedureState movingAnimation;
  ProcedureState loseState;
  ProcedureState phoneHomeScreen;
  ProcedureState newsApp;
  ProcedureState textApp;
  
  ProcedureState currentState;
 
  Game() {
    this.isOver=false;
    // first set up the phone stats and put anastasia on the start square
    this.phonePower = 100;
    this.maxPhonePower = 100;
    this.currentDay = 0;
    this.anastasiaGridX = 0;
    this.anastasiaGridY = 0;
    // load anastasia's image
    this.anastasiaAvatar = loadImage("avatar.png");
    // now get those phone image
    phoneHorizontal = loadImage("phone_horizontal.png");
    phoneVertical = loadImage("phone_vertical.png");
    // then create the game map.
    boolean isBad = true;
    while (isBad) {
      this.t = new TileMap(11,6,rotatedPhoneScreenOriginX,rotatedPhoneScreenOriginY);
      isBad = ( this.t.shortestPath(this.t.tiles[10][5],this.t.tiles[0][0])==Integer.MAX_VALUE) || ( this.t.shortestPath(this.t.tiles[10][5],this.t.tiles[0][0]) >= 20) ;
    }
    // now create the procedure states
    this.openingAnimation = new OpeningAnimationState();
    this.mapState = new MapState();
    this.movingAnimation = new MovingAnimationState();
    this.loseState = new LoseState();
    this.phoneHomeScreen = new PhoneHomeState(this);
    this.textApp = new TextingAppState();
    this.newsApp = new NewsAppState();

    // make the home screen state the current
    this.currentState = this.phoneHomeScreen;
  }
  Tile anastasiaTile() {
    //return the tile Anastastia is currently standing on
    return(this.t.tiles[anastasiaGridX][anastasiaGridY]);
  }
  void doDay() {
    // change the variables like they need to be changed for a day
    this.maxPhonePower -= 50;
    this.currentDay++;
    if (this.maxPhonePower <= 0) {
      this.currentState = this.loseState;
    }
  }
}

interface ProcedureState {
  void draw(Game g);
  void mouseClicked(Game g);
}