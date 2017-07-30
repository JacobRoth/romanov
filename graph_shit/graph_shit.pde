class Point { //<>//
  float x;
  float y;
  Point(float x, float y) { 
    this.x = x;
    this.y = y;
  }
}
    

class SimpleGraph {
  Point[] points;
  Boolean[][] adjacencyMatrix;
  
  SimpleGraph() {
    Point[] tempPoints = { new Point(random(1.0),random(1.0)), new Point(random(1.0),random(1.0)), new Point(random(1.0),random(1.0)), new Point(random(1.0),random(1.0)) };
     this.points = tempPoints;
     this.adjacencyMatrix = new Boolean[this.points.length][this.points.length];
     for (int iii = 0; iii < this.points.length; iii++) {
       for (int jjj = 0; jjj < this.points.length; jjj++) {
         // something here
       }
     } 
  }
}

SimpleGraph sim;

void setup() {
  size(700,700);
  sim = new SimpleGraph();
}
void draw() {
  for (int iii=0; iii < sim.points.length; iii++) {
    ellipse(sim.points[iii].x*700,sim.points[iii].y*700,10,10);
  }
}