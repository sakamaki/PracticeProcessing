import de.bezier.data.sql.*;

SQLite db;
Deck deck;

void setup() {
  textSize(10);
  fullScreen();
  frameRate(60);
  strokeWeight(1);
  db = new SQLite(this, "income.db");
  if (db.connect()) {
    println("connected");
    deck = new Deck(db);
  } else {
    println("Error: can not connected db");
  }
}

void draw() {
    background(255);
    deck.display();
}
