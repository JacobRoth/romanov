import ddf.minim.*;

class OpeningAnimationState implements ProcedureState {
  PImage ana1;
  PImage ana2;
  PImage ana3;
  PImage ana4;
  PImage ana5;
  PImage ana6;
  PImage ana7;
  PImage ana8;
  PImage ana9;
  PImage ana10;
  PImage ana11;
  PImage ana12;
  PImage ana13;
  PImage ana14;
  PImage ana15;
  PImage ana16;
  PImage ana17;

  int startTime;
  int delta;

  OpeningAnimationState() {
    this.ana1 = loadImage("ana1.png");
    this.ana2 = loadImage("ana2.png");
    this.ana3 = loadImage("ana3.png");
    this.ana4 = loadImage("ana4.png");
    this.ana5 = loadImage("ana5.png");
    this.ana6 = loadImage("ana6.png");
    this.ana7 = loadImage("ana7.png");
    this.ana8 = loadImage("ana8.png");
    this.ana9 = loadImage("ana9.png");
    this.ana10 = loadImage("ana10.png");
    this.ana11 = loadImage("ana11.png");
    this.ana12 = loadImage("ana12.png");
    this.ana13 = loadImage("ana13.png");
    this.ana14 = loadImage("ana14.png");
    this.ana15 = loadImage("ana15.png");
    this.ana16 = loadImage("ana16.png");
    this.ana17 = loadImage("ana17.png");   
    this.startTime = millis();
    audioPlayer = minim.loadFile("mainTheme.wav");
    audioPlayer.play();
  }
  void draw(Game g) { // note that this doesn't actually depend
  // on anything from g - just the interface requires it is all

    this.delta = (millis() - startTime)/1000;
    if ( this.delta < 4){
      background(0,0,0);
      image(ana1,width/2-250,10);
    }
    else if (this.delta >4 && this.delta<10){
      image(ana2,width/2-250,10);
    }
    else if (this.delta >10 && this.delta<14){
      image(ana3,width/2-250,10);
    }
    else if (this.delta >14 && this.delta<19){
      image(ana4,width/2-250,10);
    }
    else if (this.delta >19 && this.delta<25){
      image(ana5,width/2-250,10);
    }
    else if (this.delta >25 && this.delta<31){
      image(ana6,width/2-250,10);
    }
    else if (this.delta >31 && this.delta<37){
      image(ana7,width/2-250,10);
    }
    else if (this.delta >37 && this.delta<41){
      image(ana8,width/2-250,10);
    }
    else if (this.delta >41 && this.delta<45){
      image(ana9,width/2-250,10);
    }
    else if (this.delta >45 && this.delta<49){
      image(ana10,width/2-250,10);
    }
    else if (this.delta >49 && this.delta<54){
      image(ana11,width/2-250,10);
    }
    else if (this.delta >54 && this.delta<56){
      image(ana12,width/2-250,10);
    }
    else if (this.delta>56 && this.delta<60){
      image(ana13,width/2-250,10);
    }
    else if (this.delta > 60 && this.delta < 64){
      image(ana14,0,0);
    }
    else if (this.delta>64 && this.delta<70){
      background(0,0,0);
      image(ana15,width/2-250,10);
    }
    else if (this.delta>70 && this.delta<76){
      image(ana16,width/2-250,10);
    }
    else if (this.delta>76 && this.delta<81){
      image(ana17,width/2-250,10);
    }
    else if (this.delta>75){
      g.currentState = g.mapState; // set current state to test map thing
    }
  }
  void mouseClicked(Game g) {} // may make this skip to title later
}
