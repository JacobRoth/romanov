class NewsAppState implements ProcedureState {
  private String turncoat;
  String articleOneHeadline;
  String articleTwoHeadline;
  String articleThreeHeadline;
  Boolean articleOneLeft;
  Boolean articleTwoLeft;
  Boolean articleThreeLeft;
  
  NewsAppState() {}
  
  void findTurncoat(Game g) {
    //determine loyalist and traitor
    Tile anaTile = g.anastasiaTile();
    Tile[] neighbors = anaTile.getNeighbors();
    ArrayList<Person> traitors = new ArrayList<Person>();
    for(int i = 0; i<neighbors.length; i++) {
      if(neighbors[i] != null) {
        if(neighbors[i].allegedSafeHouseOwner.isTurned) {
          traitors.add(neighbors[i].allegedSafeHouseOwner);
        }
      }
    }
    if(traitors.isEmpty()) {
      this.turncoat = null;
    }
    else {
      this.turncoat = traitors.get(0).name;
    }
  }
  
  void setTurncoat(String turncoat) {
    this.turncoat = turncoat;
  }
  
  void setArticleQualities(Game g) {
     //generate and shuffle headlines
    this.findTurncoat(g);
    String[] headlines = new String[3];
    if(turncoat != null) {
      headlines[0] = getRealHeadline(turncoat);
    }
    else {
      headlines[0] = getTabloidHeadline();
    }
    headlines[1] = getTabloidHeadline();
    headlines[2] = getTabloidHeadline();
  
    IntList indices = new IntList(0, 1, 2);
    indices.shuffle();
    String[] shuffledHeadlines = new String[3];
    for(int i = 0; i < 3; i++) {
      shuffledHeadlines[i] = headlines[indices.get(i)];
    }
    articleOneHeadline = shuffledHeadlines[0];
    articleTwoHeadline = shuffledHeadlines[1];
    articleThreeHeadline = shuffledHeadlines[2];
    articleOneLeft = randBool();
    articleTwoLeft = randBool();
    articleThreeLeft = randBool();
  }
  
  void draw(Game g) {
    this.findTurncoat(g);
      generateFrontPage();
      //noLoop();
  }
  
  void mouseClicked(Game g) {
    g.currentState = g.phoneHomeScreen;
  }

  void generateFrontPage() {
    //background
    fill(255, 255, 255);
    rect(phoneScreenOriginX, phoneScreenOriginY, phoneScreenW, phoneScreenH);
  
    //title of news source
    line(phoneScreenOriginX+2, phoneScreenOriginY+4, phoneScreenOriginX+192, phoneScreenOriginY+4);
    textSize(16);
    fill(0, 0, 0);
    text("The Heights Happenings", phoneScreenOriginX+2, phoneScreenOriginY+20);
    line(phoneScreenOriginX+2, phoneScreenOriginY+24, phoneScreenOriginX+192, phoneScreenOriginY+24);
  
   
  
    //articles
    article(phoneScreenOriginX+15, phoneScreenOriginY+30, articleOneHeadline, articleOneLeft);
    article(phoneScreenOriginX+15, phoneScreenOriginY+140, articleTwoHeadline, articleTwoLeft);
    article(phoneScreenOriginX+15, phoneScreenOriginY+250, articleThreeHeadline, articleThreeLeft);

    //needed to make lines at top appear
    stroke(153);
  }

  String getTabloidHeadline() {
    String[] headlines = {"Pyotr Lipnitskaya's Last Moments", "Poklonskaya Married Again", "Did Czar Nicholas Drink Blood?",
                        "Queen Victoria Returned to Life?", "Inside the Kaiser's Sex Dungeon", "Rasputin's Grand Duchess ORGIES",
                        "Lenin Lifts Paint Color Restrictions", "Bolsheviks Oust Lawncare Co. For Co-op",
                        "Will the Revolution Hurt Property Values?", "Bolsheviks Ban Property Values",
                        "Marx's Socialized Lawn Care Theory", "But What About the Children?"};
    int index = int(random(headlines.length));
    return headlines[index];
  }

  String getRealHeadline(String turncoat) {
    String headline = "";
    int randomBit = int(random(2));
    if(randomBit == 1) {
      headline = turncoat + " Captured!";
    }
    else {
      headline = turncoat + ": A Rebel Spy?";
    }
    return headline;
  }

  void article(int x, int y, String headline, Boolean pictureLeft) {
    fill(0, 0, 0);
    if(pictureLeft) {
      text(headline, x+65, y, 105, 100);
      PImage marx;
      marx = loadImage("marx.png");
      image(marx, x, y);
    }
    else {
      text(headline, x, y, 105, 100);
      PImage nicky;
      nicky = loadImage("nicholasII.jpg");
      image(nicky, x+110, y);
    }
  }
  
  Boolean randBool() {
    return (random(1) > .5);
  }
}