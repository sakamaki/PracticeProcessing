float MAX_DIST = 30f;
float MIN_DIST = 0f;
float MAX_WEIGHT = 40f;
float MIN_WEIGHT = 3f;
float EASING = 0.05f;
float x = 0f;
float y = 0f;
float px = 0f;
float py = 0f;


void setup() {
  fullScreen();
  frameRate(60);
}


void draw() {
  if (pmouseX == 0 && pmouseY == 0) return;
  drawLine();
}


void drawLine() {
  float tmpMouseX = mouseX;
  float tmpMouseY = mouseY;
  x += (tmpMouseX - x) * EASING;
  y += (tmpMouseY - y) * EASING;
  float tmp_d = dist(x, y, px, py);

  strokeWeight(tmp_d);

  setStroke();

  if (mousePressed == true) {
    line(x, y, px, py);
  }

  px = x;
  py = y;
}


void setStroke() {
  if (keyPressed) {
    if (key == char(116)) {
      stroke(0, 50);
    } else if (key == char(110)) {
      stroke(0, 255);
    }
  }
}
