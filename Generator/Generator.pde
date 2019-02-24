import processing.sound.*;
AudioIn in;
FFT fft;
int bands = 128;
float scale = 50000.0;
float diameter;
float hue;

Initializer initial;
/*
図形の種類：initial.geometry
図形の間隔：initial.interval[100]
*/

void setup() {
  fullScreen();
  // Initializer: (month, day) of your birthday
  initial = new Initializer(4, 30);
  noStroke();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);
  in = new AudioIn(this, 0);
  in.start();
  fft = new FFT(this, bands);
  fft.input(in);
}

void draw() {
  background(0);
  fft.analyze();
  fill(255);
  text(initial.geometry, 10, 20);
  float x = 0.;
  float w = width / float(bands) / 2.0;
  for (int i = 0; i < 100; i++) {
    diameter = fft.spectrum[i] * scale;
    x += initial.interval[i] * 10.;
    hue = map(x, 0.0, 1000.0, 100, 255);
    fill(255, int(hue), 153);
    ellipse(
        width / 2.0 + x * w,
        height / 2.0,
        diameter,
        diameter
    );
    ellipse(
        width / 2.0 - x * w,
        height / 2.0,
        diameter,
        diameter
    );
  }
}
