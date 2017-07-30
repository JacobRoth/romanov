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
  
  SimpleGraph(int numPoints, float connectivityThreshold, float shakeAmount) {
     float connectivityThresholdSquared = connectivityThreshold*connectivityThreshold; // square of the euclidian distance between two points for them being connected.
     this.points = new Point[numPoints]; 
     
     // one approach - start with evenly spaced grid, then distort it.
     final int pointsWide = ceil(sqrt(numPoints));
     int pointsPlacedSoFar = 0;
     for (int iii=0; iii < pointsWide; iii++) {
       for (int jjj=0; jjj < pointsWide; jjj++) {
         if (pointsPlacedSoFar < numPoints) {
           this.points[pointsPlacedSoFar] = new Point((float)iii/pointsWide,(float)jjj/pointsWide);
           pointsPlacedSoFar++;
         }
       }
     }
     
     //now comes the distortion
     for (int iii=0; iii < numPoints; iii++) {
       this.points[iii].x = max(0 , min ( 1, this.points[iii].x+random(-shakeAmount,shakeAmount)));
       this.points[iii].y = max(0 , min ( 1, this.points[iii].y+random(-shakeAmount,shakeAmount)));
     }
     
     this.adjacencyMatrix = new Boolean[this.points.length][this.points.length];
     for (int iii = 0; iii < this.points.length; iii++) { // this is the pair of loops where we set up graph connections
       for (int jjj = 0; jjj < this.points.length; jjj++) {
         adjacencyMatrix[iii][jjj] =  ((pow(this.points[iii].x-this.points[jjj].x,2)+pow(this.points[iii].y-this.points[jjj].y,2)) < connectivityThresholdSquared);
       }
     } 
  }
}

SimpleGraph sim;

void setup() {
  size(700,700);
  sim = new SimpleGraph(36,0.25,0.08);
}
void draw() {
  for (int iii=0; iii < sim.points.length; iii++) {
    ellipse(sim.points[iii].x*700,sim.points[iii].y*700,10,10);
    // now draw the lines between the points 
    for (int jjj=0; jjj < sim.points.length; jjj++) {
      if (sim.adjacencyMatrix[iii][jjj]) {
        line(sim.points[iii].x*700,sim.points[iii].y*700,sim.points[jjj].x*700,sim.points[jjj].y*700);
      }
    }
  }
}