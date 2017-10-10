abstract class Mountain {
  float lon;
  float mapX;
  float mapY;
  int offsetX;
  int offsetY;
  boolean appeared = false;

  abstract void display(float offset);
}
