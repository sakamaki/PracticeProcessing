class PanelInfo {
  float maxLon;
  float minLon;
  int shopCount;
  int maxStory;
  int maxBudget;
  MtBuilding[] m_buildings;
  boolean stoppedCenter = false;
  boolean appearedMountain = false;
  PFont areaNameFont;
  PFont scaleFont;
  PFont footerFont;
  PFont lonFont;
  String areaNameText;
  int areaNameFontSize = 24;
  int scaleFontSize = 12;
  int footerFontSize = 20;
  int lonFontSize = 8;
  FloatDict storyDict = new FloatDict();
  FloatDict budgetDict = new FloatDict();
  IntList storyList = new IntList();
  float globalOffsetX = 50;
  float globalOffsetY = 80;

  PanelInfo(SQLite db, String area) {
    // Setup a panel's information
    String sql = String.format(
      "SELECT MAX(a.longitude) as max_lon, MIN(a.longitude) as min_lon, count(*) as shop_count, MAX(c.story) as max_story, MAX(d.name) AS max_budget, b.name AS area_name FROM shop AS a JOIN area AS b ON b.code=a.area JOIN building AS c ON c.shop_id=a.id JOIN budget AS d ON d.code=a.budget WHERE b.code = '%s';", area
      );
    db.query(sql);
    maxLon = db.getFloat("max_lon");
    minLon = db.getFloat("min_lon");
    maxStory = db.getInt("max_story");
    maxBudget = db.getInt("max_budget");
    shopCount = db.getInt("shop_count");
    areaNameText = db.getString("area_name") + "エリア";

    // Setup the font
    areaNameFont = createFont("HiraKakuPro-W3", areaNameFontSize);
    scaleFont = createFont("HiraKakuPro-W3", scaleFontSize);
    lonFont = createFont("HiraKakuPro-W3", lonFontSize);
    footerFont = createFont("HiraKakuPro-W3", footerFontSize);

    _setupBuildings(area);

    _setupBudgets(area);
  }

  void _setupBuildings(String area) {
    m_buildings = new MtBuilding[shopCount];
    String s1 = String.format("SELECT a.longitude AS lon, c.story, d.name AS budget FROM shop AS a JOIN area AS b ON b.code=a.area JOIN building AS c ON c.shop_id=a.id JOIN budget AS d ON d.code=a.budget WHERE b.code = '%s' ORDER BY c.story DESC", area);
    db.query(s1);
    int currentStory = -1;
    int hashKey = 0;
    for (int i=0; db.next(); i++) {
      float lon = db.getFloat("lon");
      int story = db.getInt("story");
      int budget = db.getInt("budget");
      this.m_buildings[i] = new MtBuilding(lon, story, this.maxStory, this.minLon, this.maxLon);
      this.m_buildings[i].budget = budget;
      this.storyDict.set(String.format("%02dF", story), this.m_buildings[i].mapY);
    }
  }

  void _setupBudgets(String area) {
    String s2 = String.format("SELECT a.longitude AS lon, d.name AS budget FROM shop AS a JOIN area AS b ON b.code=a.area JOIN building AS c ON c.shop_id=a.id JOIN budget AS d ON d.code=a.budget WHERE b.code='%s' ORDER BY c.story DESC", area);
    db.query(s2);
    for (int i=0; db.next(); i++) {
      float lon = db.getFloat("lon");
      int budget = db.getInt("budget");
      this.m_buildings[i].m_budget = new MtBudget(lon, budget, this.maxBudget, this.minLon, this.maxLon);
      this.budgetDict.set(String.format("%dYen", budget), this.m_buildings[i].m_budget.mapY);
    }
  }

  void _displayScale() {
    fill(0);
    textFont(scaleFont, scaleFontSize);
    textAlign(RIGHT, CENTER);
    float y;
    for (int i=-1; i<13; i++) {
      if (i == -1) {
        // Ground line
        line(0, height-globalOffsetY, width, height-globalOffsetY);
      } else if (i == 0) {
        continue;
      } else {
        y = map(i, 0, 13, height-80, 0);
        stroke(0, 0, 0, 90);
        strokeWeight(0.5);
        line(40, y, width, y);
        fill(50);
        text(String.format("%s", i), 30, y);
      }
    }
    strokeWeight(1);
    textAlign(LEFT, TOP);
  }

  void display(float offset) {
    /* Draw Content */

    // Display Mountains
    for (int i=0; i<this.m_buildings.length; i++) {
      this.m_buildings[i].display(offset);
    }

    _displayScale();

    // Area name
    fill(0);
    textFont(areaNameFont, areaNameFontSize);
    text(areaNameText, width-textWidth(areaNameText)-60, 80);

    // Footer
    textAlign(CENTER, CENTER);
    String footerText1 = "←West";
    String footerText2 = "East→";
    textFont(areaNameFont, footerFontSize);
    text(footerText1, textWidth(footerText1) + 30, height - 40);
    text(footerText2, width - textWidth(footerText2) - 30, height - 40);
  }

  boolean isTerminated(float offset) {
    return int(offset) > int(width * 2);
  }

  boolean isAppeared() {
    boolean allAppeared = true;
    for (int i=0; i<this.m_buildings.length; i++) {
      if (this.m_buildings[i].appeared == false) {
        allAppeared = false;
        break;
      }
    }
    return allAppeared;
  }

  void reset() {
    for (int i=0; i<this.m_buildings.length; i++) {
      this.m_buildings[i].appeared = false;
    }
  }
}
