import java.util.Collections;

//enum TileType { SUBDIVISION, EMPTY, IMPASS }; 
// processing doesn't like enums for some reason,
// so we'll just use the strings "subdivision", "lake", and "park".
// clunky but functional
final String[] tileTypes = {"lake","park","subdivision","start","end"};
final String[] traversableTileTypes = {"subdivision","end","start"};

Boolean isTypeTraversable(String t) {
  // bullshit function i had to write to check if
  // thing is in array
  for (int iii=0; iii < traversableTileTypes.length; iii++) {
    if(traversableTileTypes[iii].equals(t)) {
      return(true);
    }
  }
  return(false);
}   


class Tile {
  Tile northNeighbor;
  Tile southNeighbor;
  Tile eastNeighbor;
  Tile westNeighbor;
  PImage image;
  String type;
  Person allegedSafeHouseOwner;
  Tile(String typ, Person p) {
    this.type = typ ;
    this.image = loadImage(this.type+".png"); // placeholder code
    this.allegedSafeHouseOwner = p;
  }
  Tile[] getNeighbors() {
    Tile[] returnMe = {this.northNeighbor,this.southNeighbor,this.westNeighbor,this.eastNeighbor};
    return(returnMe);
  }
  boolean isNeighbor(Tile otherTile) {
    Tile[] neighbors = this.getNeighbors();
    for (int iii=0; iii < neighbors.length; iii++) {
      if ( otherTile.equals(neighbors[iii])) {
        return(true);
      }
    }
    return(false);
  }
}

String randomTileType() { 
    float r = random(1);
    if (r < 0.2) {
      return("lake");
    } else if (r > 0.8) {
      return("park");
    } else {
      return("subdivision");
    }
    // will deal with tiles having things happen in them later.
}

Person randomPerson() {
  return new Person("Some random dude",false);
}

class TileMap {
  Tile[][] tiles;
  int tileHeight;
  int tileWidth;
  int originX;
  int originY; // the coordinates of the top left corner of the map
  TileMap(int w, int h,int x, int y) {
    this.originX = x;
    this.originY = y;
    this.tileHeight = 64;
    this.tileWidth = 64;
    this.tiles = new Tile[w][h];
    for (int iii=0; iii < w; iii++) {
      for (int jjj=0; jjj < h; jjj++) {
        this.tiles[iii][jjj] = new Tile(randomTileType(),randomPerson());
      }
    }
    // we want to put the special start and end tiles in, overwriting what's there
    this.tiles[0][0] = new Tile("start",null);
    this.tiles[w-1][h-1] = new Tile("end",new Person("Grigori Rasputin",false));

    // having put all the tiles in the array, we loop over them
    // again to wire up neighbor connections
    for (int iii=0; iii < w; iii++) {
      for (int jjj=0; jjj < h; jjj++) {
        if (0==iii) {
          this.tiles[iii][jjj].eastNeighbor = null;
        } else {
          this.tiles[iii][jjj].eastNeighbor = this.tiles[iii-1][jjj]; 
        }
        if (w-1==iii) {
          this.tiles[iii][jjj].westNeighbor = null;
        } else {
          this.tiles[iii][jjj].westNeighbor = this.tiles[iii+1][jjj]; 
        }
        if (0==jjj) {
          this.tiles[iii][jjj].northNeighbor = null;
        } else {
          this.tiles[iii][jjj].northNeighbor = this.tiles[iii][jjj-1]; 
        }
        if (h-1==jjj) {
          this.tiles[iii][jjj].southNeighbor = null;
        } else {
          this.tiles[iii][jjj].southNeighbor = this.tiles[iii][jjj+1]; 
        }
      }
    }
  }
  public void render() { // draw the map to the screen
    for (int iii = 0; iii < this.tiles.length; iii++) {
      for (int jjj = 0; jjj < this.tiles[iii].length; jjj++) {
        image(this.tiles[iii][jjj].image,this.tileWidth*iii+this.originX,this.tileHeight*jjj+this.originY);
      }
    }
  }
  public int shortestPath(Tile startTile, Tile endTile) {
    // find the shortest path between two tiles
    // we are going to implement Djikstra's algorithm
    ArrayList<Tile> nodeQueue = new ArrayList();
    ArrayList<Tile> alreadyVisitedQueue = new ArrayList();
    ArrayList<Integer> costQueue = new ArrayList();
    
    // put the first node on the queue
    nodeQueue.add(startTile);
    costQueue.add(0);

    while (true) {
      //println(nodeQueue);

      assert nodeQueue.size() == costQueue.size(); // should always be manipulating these in lockstep
      if (nodeQueue.isEmpty()) {
        // this means we visited all nodes and could not find end tile
        return(Integer.MAX_VALUE);
      }
      Integer minCostCurrently = Collections.min(costQueue);
      int queueIndex = costQueue.indexOf(minCostCurrently);
      // now that we have the lowest cost in the list, pop those off the lists

      int lowestCost = costQueue.remove(queueIndex);
      Tile lowestCostTile = nodeQueue.remove(queueIndex);
      // now we have the thing. Is it the destination? if so, return the cost.
      if (lowestCostTile.equals(endTile)) {
        return(lowestCost);
      }

      // now also mark this thing visited
      alreadyVisitedQueue.add(lowestCostTile);

      // now, we add all the neighbors of this tile to the queue, each with a cost that is one more than the current cost 
      Tile[] neighbors = {lowestCostTile.northNeighbor,lowestCostTile.southNeighbor,lowestCostTile.eastNeighbor,lowestCostTile.westNeighbor};

      for (int iii =0; iii < neighbors.length; iii++) {
        Tile neighbor = neighbors[iii];
        if (neighbor != null) {
          if (isTypeTraversable(neighbor.type)) {
            //make sure that we haven't already visited it 
            if (!(alreadyVisitedQueue.contains(neighbor))) {
              if (nodeQueue.contains(neighbor)) {
                // we have to handle the case where its already in queue
                // then we check its cost and compare it to lowestCost+1.
                int indexOfNeighbor = nodeQueue.indexOf(neighbor);
                costQueue.set(indexOfNeighbor, min( lowestCost+1, costQueue.get(indexOfNeighbor)));

              } else {
                nodeQueue.add(neighbor);
                costQueue.add(lowestCost+1);
              }
            }
          }
        }
      }
    }
  }
  public Integer[] gridIndiciesFromScreenCoords(int inputX,int inputY) {
    Integer wIndex = null;
    Integer hIndex = null;
    if ((inputX > this.originX) && (inputX < this.originX + this.tileWidth*this.tiles.length)) {
      wIndex = floor((inputX-this.originX)/this.tileWidth);
    }
     if ((inputY > this.originY) && (inputY < this.originY + this.tileHeight*this.tiles[0].length)) {
      hIndex = floor((inputY-this.originY)/this.tileHeight);
    }
    Integer[] returnMe = {wIndex,hIndex};
    // java has no tuples so have to return a two element array
    return(returnMe);
  }
}


class MapState implements ProcedureState {
  MapState() {} // trivial constructor, nothing to see here
  void draw(Game g) {
    background(255,255,255);
    image(g.phoneHorizontal,0,0);
    g.t.render();
    image(g.anastasiaAvatar,g.t.tileWidth*g.anastasiaGridX+g.t.originX,g.t.tileHeight*g.anastasiaGridY+g.t.originY);
  }
  void mouseClicked(Game g) {
    Integer[] indicies = g.t.gridIndiciesFromScreenCoords(mouseX,mouseY);
    Integer wIndex = indicies[0];
    Integer hIndex = indicies[1];
    if ((wIndex != null) && (hIndex != null)) {
        Tile clickedTile = g.t.tiles[(int)wIndex][(int)hIndex];
        //println(clickedTile.type);
        //println(clickedTile.northNeighbor.equals(clickedTile));
        println(g.t.shortestPath(g.t.tiles[0][0],clickedTile));
        if(g.t.tiles[g.anastasiaGridX][g.anastasiaGridY].isNeighbor(clickedTile) && isTypeTraversable(clickedTile.type)) {
	  g.anastasiaGridX=wIndex;
	  g.anastasiaGridY=hIndex;
          g.movingAnimation = new MovingAnimationState();
          g.currentState=g.movingAnimation;
	}
    }
  }
} 

