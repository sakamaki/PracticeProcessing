import de.bezier.data.sql.*;

SQLite db;
// String[] areas = {"X040", "X097", "X090", "X110", "X065", "X045", "X130", "X005"}; // TODO: test data
String[] areas = {"X005",
"X020",
"X145",
"X150",
"X160",
"X220",
"XA00",
"X115",
"X097",
"X200",
// "X222",
// "X130",
// "X125",
// "X210",
// "X045",
// "XA9B",
// "X060",
// "X165",
"XA06"};

PanelInfo[] p = new PanelInfo[areas.length];
int roopCount = 0;
float offset = 0;

void setup() {
  textSize(10);
  fullScreen(P2D);
  frameRate(60);
  // noStroke();
  strokeWeight(1);
  db = new SQLite(this, "shops.db");
  if (db.connect()) {
    for (int i=0; i<areas.length; i++) {
      p[i] = new PanelInfo(db, areas[i]);
    }
  }
}

void draw() {
  // background(0, 120, 196);
  // background(200, 200, 200);
  background(255);
  stroke(35, 31, 32);
  if (roopCount == areas.length) {
    roopCount = 0;
    offset = 0;
    for (int i=0; i<areas.length; i++) {
      p[i].reset();
    }
  } else if (p[roopCount].isAppeared()) {
    delay(3000);
    roopCount++;
    offset = 0;
  } else {
    p[roopCount].display(offset);
    offset += 10;
  }
}
