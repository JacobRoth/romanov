import java.util.Collections;

//enum TileType { SUBDIVISION, EMPTY, IMPASS }; 
// processing doesn't like enums for some reason,
// so we'll just use the strings "subdivision", "lake", and "park".
// clunky but functional
final String[] tileTypes = {"lake","subdivision","park"};
final String[] traversableTileTypes = {"subdivision"};


class Tile {
  Tile northNeighbor;
  Tile southNeighbor;
  Tile eastNeighbor;
  Tile westNeighbor;
  PImage image;
  String type;
  Tile() { // currently coded to be random
    this.type = tileTypes[(int)(random(0,tileTypes.length))];
    this.image = loadImage(this.type+".png"); // placeholder code
    // will deal with tiles having images and things happen in them later.
  }
}
 
class TileMap {
  Tile[][] tiles;
  int tileHeight;
  int tileWidth;
  TileMap(int w, int h) {
    this.tileHeight = 64;
    this.tileWidth = 64;
    this.tiles = new Tile[w][h];
    for (int iii=0; iii < w; iii++) {
      for (int jjj=0; jjj < h; jjj++) {
        this.tiles[iii][jjj] = new Tile();
      }
    } 
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
        image(this.tiles[iii][jjj].image,this.tileWidth*iii,this.tileHeight*jjj);
      }
    }
  }
  public int shortestPath(Tile startTile, Tile endTile) {
    // find the shortest path between two tiles
    // we are going to implement Djikstra's algorithm
    ArrayList<Tile> nodeQueue = new ArrayList();
    ArrayList<Integer> costQueue = new ArrayList();

    // put the first node on the queue
    nodeQueue.add(startTile);
    costQueue.add(0);

    while (true) {
      Integer minCostCurrently = Collections.min(costQueue);
      int queueIndex = costQueue.indexOf(minCostCurrently);
      // now that we have the lowest cost in the list, pop those off the lists
      int lowestCost = costQueue.remove(queueIndex);
      Tile lowestCostTile = nodeQueue.remove(queueIndex);
      // now we have the thing. Is it the destination? if so, return the cost.
      if (lowestCostTile.equals(endTile)) {
        return(lowestCost);
      }

      // now, we add all the traversable neighbors of this tile to the queue. 
      if (lowestCostTile.northNeighbor != null) {
        if (traverseableTileTypes.contains(lowestCostTile.northNeighbor.type)) {
          //make sure that we don't already have it
          if (!(nodeQueue.contains(lowestCostTile.northNeighbor))) {
            nodeQueue.add(lowestCostTile.northNeighbor);
            costQueue.add(lowestCost+1);
          }
        }
      }
      // do that again for south, west, and east
      if (lowestCostTile.southNeighbor != null) {
        if (traverseableTileTypes.contains(lowestCostTile.southNeighbor.type)) {
          //make sure that we don't already have it
          if (!(nodeQueue.contains(lowestCostTile.southNeighbor))) {
            nodeQueue.add(lowestCostTile.southNeighbor);
            costQueue.add(lowestCost+1);
          }
        }
      }
      if (lowestCostTile.eastNeighbor != null) {
        if (traverseableTileTypes.contains(lowestCostTile.eastNeighbor.type)) {
          //make sure that we don't already have it
          if (!(nodeQueue.contains(lowestCostTile.eastNeighbor))) {
            nodeQueue.add(lowestCostTile.eastNeighbor);
            costQueue.add(lowestCost+1);
          }
        }
      }
      if (lowestCostTile.westNeighbor != null) {
        if (traverseableTileTypes.contains(lowestCostTile.westNeighbor.type)) {
          //make sure that we don't already have it
          if (!(nodeQueue.contains(lowestCostTile.westNeighbor))) {
            nodeQueue.add(lowestCostTile.westNeighbor);
            costQueue.add(lowestCost+1);
          }
        }
      }
    }
  }
}
