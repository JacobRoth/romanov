final int SCREEN_WIDTH = 195;
final int SCREEN_HEIGHT = 363;



void setup()
{
 size(195,363);
 fill(255,255,255);
 rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  textSize(16);
  fill(0, 0, 0);
  text("Photo Gallery", 2, 20);
  line(0, 24, 195, 24);
}

void draw()
{
noLoop();
pictures();
}

void pictures()
{
image [] pictures = new pictures [2];
}