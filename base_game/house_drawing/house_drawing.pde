void setup() {
//  size(3750, 450);
  size(1200,450);
}


float[] reds = randColors();
float[] greens = randColors();
float[] blues = randColors();
float[] types = houseTypes();
int x = 20;
int y = 200;
int numHouses = 8;
int stopPoint = doorPos(numHouses, types);
int numIters = stopPoint/3;
int counter = 0;

  
  
void draw() {
    //draw sky and ground
    fill(70,200,250);
    rect(0,0,width,height);
    fill(60,180,0);
    rect(0,300,width,height);    
    //for animation purposes, keep track of where we started
    int initialx = x;
    //draw 15 houses    
    for (int i = 0; i < 15; i = i+1){
      if (types[i] < 1){
        makeHouse1(x,y,reds[i],greens[i],blues[i],reds[i+1],greens[i+1],blues[i+1]);
        x = x+220;
      }
      
      else if (types[i] >2){
        makeHouse3(x,y,reds[i],greens[i],blues[i],reds[i+1],greens[i+1],blues[i+1]);
        x = x +250;
      }
      else {makeHouse2(x,y,reds[i],greens[i],blues[i],reds[i+1],greens[i+1],blues[i+1]);
        x = x +200;
      }      
    } 
    //draw us :)
    fill(222,118,41);
    rect(160, 300, 15, 30);
    fill(255,174,201);
    rect(160,310,15,20);
    //we're going forward!
    x = initialx - 3;
    counter = counter +1;
    if (numIters < counter){
      noLoop();
    }
} 




void makeHouse1(int x, int y, float r, float g, float b,
                float dr, float dg, float db){

  //basic rectangle house body
  fill(r,g,b);
  rect(x, y, 180, 120);
  //make door
  fill(dr,dg,db);
  rect(x+75,y+60,30,60);
  ellipse(x+80,y+90,5,5);
  //make windows
  fill(170,210,200);
  rect(x+30,y+40,25,25);
  rect(x+125,y+40,25,25);
  //make roof
  fill(140,50,50);
  triangle(x+2,y,x+90,y-30,x+178,y);
 
}

void makeHouse2(int x, int y, float r, float g, float b,
                float dr, float dg, float db){
    //2-story house w/chimney
  fill(r,g,b);
  rect(x, y, 150, 120);
  //make door
  fill(dr,dg,db);
  rect(x+60,y+60,30,60);
  ellipse(x+85,y+90,5,5);
  //make windows
  fill(170,210,200);
  rect(x+20,y+50,25,25);
  rect(x+105,y+50,25,25);
  rect(x+65,y+15,25,25);
  //make chimney
  fill(140,50,50);
  rect(x+130,y-30,15,30);
  //make roof
  triangle(x+2,y,x+75,y-30,x+148,y);           
}

void makeHouse3(int x, int y, float r, float g, float b,
                float dr, float dg, float db){
  //house with car hole
  fill(r,g,b);
  rect(x, y+10, 140, 110);
  //make car hole
  rect(x+140,y+40, 80, 80);
  fill(dr,dg,db);
  rect(x+150,y+50, 60, 70);
  //make door
  fill(dr,dg,db);
  rect(x+55,y+60,30,60);
  ellipse(x+80,y+90,5,5);
  //make windows
  fill(170,210,200);
  rect(x+15,y+40,25,25);
  rect(x+100,y+40,25,25);
  //make roof
  fill(140,50,50);
  triangle(x+2,y+10,x+75,y-20,x+138,y+10);
  triangle(x+140,y+40, x+180,y+10, x+220, y+40);
}

private float[] randColors(){
  float[] colors = new float[16];
    for (int i = 0; i < 16; i = i+1) {
      colors[i] = random(150,255);
    }
   return colors;
}
private float[] houseTypes(){
  float[] types = new float[16];
  for (int i = 0; i < 16; i = i+1) {
      types[i] = random(3);
    }
  return types;
}

private int doorPos(int n, float[] types){
  int pos = 0;
  for (int i =0; i<n-1; i=i+1){
    if (types[i] <1){
      pos = pos + 200;
    }
    else if (types[i] >2){
      pos = pos + 250;
    }
    else {
      pos = pos + 200;
    }
  }
  return pos;
}
