class NewsAppState implements ProcedureState {
  private String turncoat;
  
  NewsAppState () {}
  
  void setTurncoat(String turncoat) {
    this.turncoat = turncoat;
  }
  
  void draw(Game g) {
    generateFrontPage(this.turncoat);
    noLoop();
  }
  
  void mouseClicked(Game g) {
    g.currentState = g.phoneHomeScreen;
  }

  void generateFrontPage(String turncoat) {
    //background
    fill(255, 255, 255);
    rect(0, 0, phoneScreenW, phoneScreenH);
  
    //title of news source
    line(phoneScreenOriginX+2, phoneScreenOriginY+4, phoneScreenOriginX+192, phoneScreenOriginY+4);
    textSize(16);
    fill(0, 0, 0);
    text("The Heights Happenings", phoneScreenOriginX+2, phoneScreenOriginY+20);
    line(phoneScreenOriginX+2, phoneScreenOriginY+24, phoneScreenOriginX+192, phoneScreenOriginY+24);
  
    //generate and shuffle headlines
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
  
    //articles
    article(phoneScreenOriginX+15, phoneScreenOriginY+30, shuffledHeadlines[0], randBool());
    article(phoneScreenOriginX+15, phoneScreenOriginY+140, shuffledHeadlines[1], randBool());
    article(phoneScreenOriginX+15, phoneScreenOriginY+250, shuffledHeadlines[2], randBool());

    //needed to make lines at top appear
    stroke(153);
  }

  String getTabloidHeadline() {
    String[] headlines = {"Pyotr Lipnitskaya's Last Moments", "Poklonskaya Married Again", "Did Czar Nicholas Drink Blood?",
                        "Queen Victoria Returned from the Grave?", "Inside the Kaiser's Sex Dungeon", "Rasputin's Grand Duchess ORGIES",
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