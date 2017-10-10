class MtBuilding extends Mountain {
  int story;
  int budget;
  MtBudget m_budget;

  MtBuilding(float lon, int story, int currentMax, float minLon, float maxLon) {
    this.offsetX = 50;
    this.offsetY = 80;
    this.lon = lon;
    this.story = story;
    this.mapX = map(this.lon, minLon, maxLon, 300, width-300);
    // this.mapY = map(this.story, 0, currentMax<=10?10:currentMax, height-this.offsetY, this.offsetY);
    this.mapY = map(this.story, 0, 13, height-80, 0);
  }

  void display(float offset) {
    fill(124/this.story, 255/this.story, 124);
    // if (this.story <= 15) {
    //   fill(124-map((float)this.story, 1, 15, 0, 124), 255-map((float)this.story, 1, 15, 0, 255), 200);
    // } else {
    //   fill(124/this.story, 255/this.story, 124);
    // }
    // fill(124/this.story, 255/this.story, 124);
    // fill(124-map((float)this.story, 1, 53, 0, 124), 255/this.story, 124);
    // stroke(50, 50, 50);
    // fill(124/this.story, 255-map((float)this.story, 1, 53, 0, 200), 200);
    float y;
    if (mapY < height - offsetY - offset) {
      y = height - offsetY - offset;
      appeared = false;
    } else {
      y = mapY;
      appeared = true;
    }
    int o = (int)map(this.budget, 2000, 15000, 5, 500);
    strokeWeight(1);
    stroke(0,0,0, 80);
    beginShape();
    vertex(mapX, y);
    vertex(mapX+o, height - offsetY);
    vertex(mapX-o, height - offsetY);
    endShape(CLOSE);
    // this.m_budget.display(offset);
  }
}
