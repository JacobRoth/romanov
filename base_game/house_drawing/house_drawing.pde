void setup() {
  size(2800, 200);
}

void draw() {

  if (mousePressed) { 
    fill(70,200,250);
    rect(0,0,width,200);
    fill(60,180,0);
    rect(0,100,width,100);
    float[] reds = new float[7];
    float[] greens = new float[7];
    float[] blues = new float[7];
    for (int i = 0; i < 7; i = i+1) {
      reds[i] = random(150,255);
      greens[i] = random(150,255);
      blues[i] = random(150,255);
      }
    int x = 20;
    int y = 40;
    for (int i = 0; i < 6; i = i+1){
      makeHouse1(x,y,reds[i],greens[i],blues[i],reds[i+1],greens[i+1],blues[i+1]);
      x = x +200;
    }
    makeHouse1(x,y,reds[6],greens[6],blues[6],reds[0],greens[0],blues[0]);
    x = x+220;
    for (int i = 0; i < 6; i = i+1){
      makeHouse2(x,y,reds[i],greens[i],blues[i],reds[i+1],greens[i+1],blues[i+1]);
      x = x +200;
    }
    makeHouse2(x,y,reds[6],greens[6],blues[6],reds[0],greens[0],blues[0]);
    
    save("houseTest.png");
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