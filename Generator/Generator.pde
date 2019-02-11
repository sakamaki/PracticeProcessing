Initializer initial;
/*
図形の種類：initial.geometry
図形の間隔：initial.interval[100]
*/

void setup() {
  size(1000, 200);
  // Initializer: (month, day) of your birthday
  initial = new Initializer(12, 9);
  background(255);
  noLoop(); 
}

void draw() {
  fill(0);
  text(initial.geometry, 10, 20);
  float x = 0.;
  stroke(0);
  for (int i = 0; i < 100; i++) {
    x += initial.interval[i] * 10.; 
    line(x,50, x, 150); 
  }
}

  