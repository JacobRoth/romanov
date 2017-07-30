//enum TileType { SUBDIVISION, EMPTY, IMPASS }; 
// processing doesn't like enums for some reason,
// so we'll just use the strings "subdivision", "lake", and "park".
// clunky but functional
final String[] tileTypes = {"lake","subdivision","park"};

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
          this.tiles[iii][jjj].northNeighbor = null;
        } else {
          this.tiles[iii][jjj].northNeighbor = this.tiles[iii-1][jjj]; 
        }
        if (w-1==iii) {
          this.tiles[iii][jjj].southNeighbor = null;
        } else {
          this.tiles[iii][jjj].southNeighbor = this.tiles[iii+1][jjj]; 
        }
        if (0==jjj) {
          this.tiles[iii][jjj].eastNeighbor = null;
        } else {
          this.tiles[iii][jjj].eastNeighbor = this.tiles[iii][jjj-1]; 
        }
        if (h-1==jjj) {
          this.tiles[iii][jjj].westNeighbor = null;
        } else {
          this.tiles[iii][jjj].westNeighbor = this.tiles[iii][jjj+1]; 
        }
      }
    }
  }
  public void render() {
    for (int iii = 0; iii < this.tiles.length; iii++) {
      for (int jjj = 0; jjj < this.tiles[iii].length; jjj++) {
        image(this.tiles[iii][jjj].image,this.tileWidth*iii,this.tileHeight*jjj);
      }
    }
  }
}