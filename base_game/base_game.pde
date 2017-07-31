TileMap t;

void setup() {
  size(1200,450);
  t = new TileMap(11,6);
  while (t.shortestPath(t.tiles[10][5],t.tiles[0][0])==Integer.MAX_VALUE) {
    t = new TileMap(11,6);
  }
}

void draw() {
  t.render();
}

void mouseClicked() {
  int wIndex = floor(mouseX/t.tileWidth);
  int hIndex = floor(mouseY/t.tileWidth);
  if (wIndex < t.tiles.length) {
    if (hIndex < t.tiles[wIndex].length) { 
      Tile clickedTile = t.tiles[wIndex][hIndex];
      //println(clickedTile.type);
      //println(clickedTile.northNeighbor.equals(clickedTile));
      println(t.shortestPath(t.tiles[0][0],clickedTile));

    }
  }
}


