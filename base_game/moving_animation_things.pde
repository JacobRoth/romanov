class MovingAnimationState implements ProcedureState {
  float[] reds;
  float[] greens;
  float[] blues;
  float[] types;
  int x;
  int y;
  int numHouses;
  int stopPoint;
  int numIters;
  int counter;
  int endIters;
  int stopx;
  int housex;

  MovingAnimationState() {
    this.reds = randColors();
    this.greens = randColors();
    this.blues = randColors();
    this.types = houseTypes();
    this.x = 20;
    this.y = 200;
    this.numHouses = 10;
    this.numIters = 150;
    this.endIters = 500;
    this.counter = 0;

  }
  void draw(Game g) {    
      if (this.counter ==0){
        audioPlayer = minim.loadFile("sevenTheme.wav");
        audioPlayer.play();
        this.counter = 1;
      }
      //draw sky and ground
      fill(70,200,250);
      rect(0,0,width,height);
      fill(60,180,0);
      rect(0,300,width,height);
       if (this.counter< this.numIters){
        //for animation purposes, keep track of where we started
        int initialx = this.x;
        //draw some houses    
        for (int i = 0; i < this.numHouses; i = i+1){
          if (this.types[i] < 1){
            this.makeHouse1(this.x,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.x = this.x+220;
          }
          
          else if (this.types[i] >2){
            makeHouse3(this.x,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.x = this.x +250;
          }
          else {this.makeHouse2(this.x,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.x = this.x +200;
          }      
        } 
        //draw us :)
        fill(225,56,0);
        rect(160, 300, 15, 30);
        fill(215,0,91);
        rect(160,310,15,20);
        //we're going forward!
        this.x = initialx - 3;
        this.counter = this.counter +1;
      }
      else if (this.counter == this.numIters){
                int initialx = this.x;
        //draw some houses    
        for (int i = 0; i < this.numHouses; i = i+1){
          if (this.types[i] < 1){
            this.makeHouse1(this.x,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.x = this.x+220;
          }
          
          else if (this.types[i] >2){
            makeHouse3(this.x,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.x = this.x +250;
          }
          else {this.makeHouse2(this.x,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.x = this.x +200;
          }      
        } 
        //draw us :)
        fill(225,56,0);
        rect(160, 300, 15, 30);
        fill(215,0,91);
        rect(160,310,15,20);
        //we're going forward!
        this.x = initialx - 3;
        this.stopx = this.x;
        this.counter = this.counter+1;
      }
      else if (this.counter < this.endIters){
        //ana moves forward, houses stay still
        //for animation purposes, keep track of where we started
        int initialx = this.x;
        this.housex = this.stopx;
        //draw some houses    
        for (int i = 0; i < this.numHouses; i = i+1){
          if (this.types[i] < 1){
            this.makeHouse1(this.housex,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.housex = this.housex+220;
          }
          
          else if (this.types[i] >2){
            makeHouse3(this.housex,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.housex = this.housex +250;
          }
          else {this.makeHouse2(this.housex,this.y,this.reds[i],this.greens[i],this.blues[i],this.reds[i+1],this.greens[i+1],this.blues[i+1]);
            this.housex = this.housex +200;
          }      
        } 
        //draw us :)
        fill(225,56,0);
        rect(this.x-this.stopx+160, 300, 15, 30);
        fill(215,0,91);
        rect(this.x-this.stopx+160,310,15,20);
        //we're going forward!
        this.x = initialx + 3;
        this.counter = this.counter +1;
      }
      else if (this.endIters <= this.counter){
        audioPlayer.close();
        //noLoop(); // this will eventually push us to another state
	g.currentState = g.mapState;
	// need to do things wrt. arriving to a place. Also,
	g.doDay();
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
  

  void mouseClicked(Game g) { } // not clear if this ever needs to be filled in
}