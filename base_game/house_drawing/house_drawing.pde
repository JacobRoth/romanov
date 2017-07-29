void setup() {
  size(1200, 200);
}

void draw() {
  if (mousePressed) {
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
    for (int i = 0; i < 7; i = i+1){
      makeHouse1(x,y,reds[i],greens[i],blues[i]);
      x = x +200;
    }
    
  } 
}

void makeHouse1(int x, int y, float r, float g, float b){

  //basic rectangle house body
  fill(r,g,b);
  rect(x, y, 180, 120);
  //make door
  fill(random(255),random(255),random(255));
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