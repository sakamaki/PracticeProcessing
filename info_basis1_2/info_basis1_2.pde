float angle = 0.0;
boolean stop = false;
int roopCount = 0;


void setup() {
  fullScreen();
  frameRate(120);
  strokeWeight(2);
  background(255);
}


void draw() {
  if (roopCount == 2000) {
    return;
  }

  stroke(255);
  drawSigmoid(5);

  pushMatrix();
    stroke(0, 50);
    translate(width, height);
    rotate(angle);
    drawSigmoid(10);
  popMatrix();

  angle += 0.09;
  roopCount += 1;
}


void drawSigmoid(float weight) {
  for (float i=-6; i<8; i+=0.1) {
    float x = map(i, -6, 7, 0, width);
    float y = map(sigmoid(i), -6, 7, height, 0);
    strokeWeight(weight);
    point(x,y);
  }
}


float sigmoid(float x){
  return 1.0 / (exp(-10.0 * (x - 0.5)) + 1.0);
}
