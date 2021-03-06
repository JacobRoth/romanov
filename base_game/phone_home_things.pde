class App {
  private PImage icon;
  private int originX;
  private int originY;
  private ProcedureState clickState;
  
  App(PImage icon, int originX, int originY, ProcedureState clickState) {
    this.icon = icon;
    this.originX = originX;
    this.originY = originY;
    this.clickState = clickState;
  }
  
  void drawIcon() {
    //println(this.clickState);
    image(icon, originX, originY);
  }
  
  Boolean inBox(int x, int y) {
    return ((x >= this.originX) && (x <= this.originX + this.icon.width) && (y >= this.originY) &&
            (y <= this.originY + this.icon.height));
  }
  
  ProcedureState getClickState() {
    return this.clickState;
  }
}

class PhoneHomeState implements ProcedureState {
  private App rubleMaps;
  private App messaging;
  private App news;
  private App photos;
  private App camera;
  private App flashlight;
  private App plantID;
  private App tinder;
  private App songID;
  private ArrayList<App> appsList = new ArrayList<App>();
  
  PhoneHomeState(Game g) {
    int[] xCoords = {42, 102, 162};
    int[] yCoords = {50, 150, 250};
    this.messaging = new App(loadImage("texting_app.png"), xCoords[0], yCoords[0], g.textApp);
    this.news = new App(loadImage("news_app.png"), xCoords[1], yCoords[0], g.newsApp);
    this.rubleMaps = new App(loadImage("maps_app.png"), xCoords[2], yCoords[0], g.mapState);
    this.photos = new App(loadImage("photos_app.png"), xCoords[0], yCoords[1], this);
    this.camera = new App(loadImage("camera_app.png"), xCoords[1], yCoords[1], this);
    this.flashlight = new App(loadImage("flashlight_app.png"), xCoords[2], yCoords[1], this);
    this.plantID = new App(loadImage("plantID_app.png"), xCoords[0], yCoords[2], this);
    this.tinder = new App(loadImage("tinder_app.png"), xCoords[1], yCoords[2], this);
    this.songID = new App(loadImage("songID_app.png"), xCoords[2], yCoords[2], this);
    this.appsList.add(messaging);
    this.appsList.add(news);
    this.appsList.add(rubleMaps);
    this.appsList.add(photos);
    this.appsList.add(camera);
    this.appsList.add(flashlight);
    this.appsList.add(plantID);
    this.appsList.add(tinder);
    this.appsList.add(songID);

    
  }
  
  void draw(Game g) {
    //println(g.newsApp);
    //println(g.mapState);
    //println(g.newsApp);
    //println(this.rubleMaps.getClickState());
    //println(this.news.getClickState());
    image(g.phoneVertical, 0, 0);
    PImage background = loadImage("phone_home.png");
    image(background, phoneScreenOriginX, phoneScreenOriginY);
    for(int i = 0; i < appsList.size(); i++) {
      appsList.get(i).drawIcon();
    }
  }
  
  void mouseClicked(Game g) {
    for(int i = 0; i< appsList.size(); i++) {
      if(appsList.get(i).inBox(mouseX, mouseY)) {
        if(appsList.get(i) == this.news) {
          g.newsApp.setArticleQualities(g);
        }
        g.currentState = appsList.get(i).getClickState();
      }
    }
  }
}