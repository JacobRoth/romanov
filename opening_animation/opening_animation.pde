//import processing.sound.*;
//SoundFile file;
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
  size(1200,450);
  background(0,0,0);
  //file = new SoundFile(this, "mainTheme.wav");
  //file.play();
  startTime = millis();
}


void draw(){
  int delta = millis() - startTime;
  if ( delta < 4000){
    image(ana1,width/2-250,10);
  }
  else if (delta >4000 && delta<8000){
    image(ana2,width/2-250,10);
  }
  else if (delta >8000 && delta<12000){
    image(ana3,width/2-250,10);
  }
  else if (delta >12000 && delta<16000){
    image(ana4,width/2-250,10);
  }
  else if (delta >16000 && delta<20000){
    image(ana5,width/2-250,10);
  }
  else if (delta >20000 && delta<24000){
    image(ana6,width/2-250,10);
  }
  else if (delta >24000 && delta<28000){
    image(ana7,width/2-250,10);
  }
  else if (delta >28000 && delta<32000){
    image(ana8,width/2-250,10);
  }
  else if (delta >32000 && delta<36000){
    image(ana9,width/2-250,10);
  }
  else if (delta >36000 && delta<40000){
    image(ana10,width/2-250,10);
  }
  else if (delta >40000 && delta<44000){
    image(ana11,width/2-250,10);
  }
  else if (delta >44000 && delta<48000){
    image(ana12,width/2-250,10);
  }
}