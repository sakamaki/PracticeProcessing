class MtBudget extends Mountain {
  int budget;

  MtBudget(float lon, int budget, int currentMax, float minLon, float maxLon) {
    this.offsetX = 50;
    this.offsetY = 80;
    this.lon = lon;
    this.budget = budget;
    this.mapX = map(this.lon, minLon, maxLon, width/2+30+this.offsetX, width-30-this.offsetX);
    this.mapY = map(this.budget, 0, currentMax<=5000?5000:currentMax-this.offsetY, height, this.offsetY);
  }

  void display(float offset) {
    float y;
    if (mapY < height - offsetY - offset) {
      y = height - offsetY - offset;
      appeared = false;
    } else {
      y = mapY;
      appeared = true;
    }
    beginShape();
    vertex(mapX, y);
    vertex(mapX+30, height - offsetY);
    vertex(mapX-30, height - offsetY);
    endShape(CLOSE);
  }
}
