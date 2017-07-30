import processing.sound.*;
SoundFile file;
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

void setup(){
  ana1 = loadImage("ana1.png");
  ana2 = loadImage("ana2.png");
  ana3 = loadImage("ana3.png");
  ana4 = loadImage("ana4.png");
  ana5 = loadImage("ana5.png");
  ana6 = loadImage("ana6.png");
  ana7 = loadImage("ana7.png");
  ana8 = loadImage("ana8.png");
  ana9 = loadImage("ana9.png");
  ana10 = loadImage("ana10.png");
  ana11 = loadImage("ana11.png");
  ana12 = loadImage("ana12.png");
  ana13 = loadImage("ana13.png");
  ana14 = loadImage("ana14.png");
  ana15 = loadImage("ana15.png");
  ana16 = loadImage("ana16.png");
  ana17 = loadImage("ana17.png");
  size(1200,450);
  background(0,0,0);
  file = new SoundFile(this, "mainTheme.wav");
  file.play();
  startTime = millis();
}


void draw(){
  int delta = (millis() - startTime)/1000;
  if ( delta < 4){
    image(ana1,width/2-250,10);
  }
  else if (delta >4 && delta<8){
    image(ana2,width/2-250,10);
  }
  else if (delta >8 && delta<12){
    image(ana3,width/2-250,10);
  }
  else if (delta >12 && delta<16){
    image(ana4,width/2-250,10);
  }
  else if (delta >16 && delta<20){
    image(ana5,width/2-250,10);
  }
  else if (delta >20 && delta<24){
    image(ana6,width/2-250,10);
  }
  else if (delta >24 && delta<28){
    image(ana7,width/2-250,10);
  }
  else if (delta >28 && delta<32){
    image(ana8,width/2-250,10);
  }
  else if (delta >32 && delta<36){
    image(ana9,width/2-250,10);
  }
  else if (delta >36 && delta<40){
    image(ana10,width/2-250,10);
  }
  else if (delta >40 && delta<44){
    image(ana11,width/2-250,10);
  }
  else if (delta >44 && delta<48){
    image(ana12,width/2-250,10);
  }
  else if (delta>48 && delta<52){
    image(ana13,width/2-250,10);
  }
  else if (delta > 52 && delta < 56){
    image(ana14,0,0);
  }
  else if (delta>56 && delta<60){
    background(0,0,0);
    image(ana15,width/2-250,10);
  }
  else if (delta>60 && delta<64){
    image(ana16,width/2-250,10);
  }
  else if (delta>64 && delta<68){
    image(ana17,width/2-250,10);
  }
}