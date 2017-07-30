
TileMap t;

void setup() {
  size(1200,450);
  t = new TileMap(11,6);
}

void draw() {
  t.render();
}

void mouseClicked() {
  int wIndex = floor(mouseX/t.tileWidth);
  int hIndex = floor(mouseY/t.tileWidth);
  if (wIndex < t.tiles.length) {
    if (hIndex < t.tiles[wIndex].length) { 
      println(t.tiles[wIndex][hIndex].type);
    }
  }
}