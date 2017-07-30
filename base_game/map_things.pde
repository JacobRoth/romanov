enum TileType { SUBDIVISION, EMPTY, IMPASS }; 

class Tile {
  Tile northNeighbor;
  Tile southNeighbor;
  Tile eastNeighbor;
  Tile westNeighbor;
  PImage image;
  TileType type;
  Tile() {
    // will deal with tiles having images and things happen in them later.
  }
}
 
class TileMap {
  Tile[][] tiles;
  TileMap(int w, int h) {
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
}