int CLASS_POOR = 1;
int CLASS_MILD_POOR = 2;
int CLASS_MIDDLE = 3;
int CLASS_WEALTHY = 4;

class Deck {
    Panel srcP1, srcP2, srcP3 ,srcP4, distP1, distP2, distP3, distP4;
    FlyingMoney f1, f2, f3, f4;
    int flyingOffsetY = 0;
    SQLite db;
    int[] incomeList = {200, 300, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 2000, 3000};
    PFont itemNameFont = createFont("HiraKakuPro-W3", 40);

    Deck(SQLite db) {
        this.db = db;
        initialize();
    }

    void initialize() {
        int rank1 = 1;
        int rank2 = int(round(random(2, 4)));
        int rank3 = int(round(random(5, 9)));
        int rank4 = int(round(random(10, 13)));

        // Panelの作成
        int panelW = width/4;
        int panelH = height/3;
        int srcY = height - panelH;
        srcP1 = new Panel(0, srcY, panelW, panelH, CLASS_POOR, rank1, true);
        srcP2 = new Panel(panelW, srcY, panelW, panelH, CLASS_MILD_POOR, rank2, true);
        srcP3 = new Panel(panelW*2, srcY, panelW, panelH, CLASS_MIDDLE, rank3, true);
        srcP4 = new Panel(panelW*3, srcY, panelW, panelH, CLASS_WEALTHY, rank4, true);

        distP1 = new Panel(0, 0, panelW, panelH, CLASS_POOR, rank1, false);
        distP2 = new Panel(panelW, 0, panelW, panelH, CLASS_MILD_POOR, rank2, false);
        distP3 = new Panel(panelW*2, 0, panelW, panelH, CLASS_MIDDLE, rank3, false);
        distP4 = new Panel(panelW*3, 0, panelW, panelH, CLASS_WEALTHY, rank4, false);

        // FlyingMoneyの生成
        f1 = new FlyingMoney(srcP1.centerX, srcP1.centerY, distP1.centerX, distP1.centerY, incomeList[rank1-1]);
        f2 = new FlyingMoney(srcP2.centerX, srcP2.centerY, distP1.centerX, distP1.centerY, incomeList[rank2-1]);
        f3 = new FlyingMoney(srcP3.centerX, srcP3.centerY, distP1.centerX, distP1.centerY, incomeList[rank3-1]);
        f4 = new FlyingMoney(srcP4.centerX, srcP4.centerY, distP1.centerX, distP1.centerY, incomeList[rank4-1]);
        String sql = String.format("select class, kind_name, item_name, sum(annual_amount) as annual_amount from main where rank in (%d, %d, %d, %d) group by class, rank, kind, item_name order by item_kind desc, kind, rank, class;", rank1, rank2, rank3, rank4);
        println(sql);
        db.query(sql);
        dbNext();
    }

    void dbNext() {
        if (db.next()) {
            f1.udpateAmount(db.getInt("annual_amount"));
            db.next();
            f2.udpateAmount(db.getInt("annual_amount"));
            db.next();
            f3.udpateAmount(db.getInt("annual_amount"));
            db.next();
            f4.udpateAmount(db.getInt("annual_amount"));
        } else {
            // 全部表示し終わったら、ループさせる。
            initialize();
        }
    }

    void showItemName() {
        fill(0);
        pushMatrix();
        textFont(itemNameFont, 48);
        textMode(CENTER);
        textAlign(CENTER);
        text(String.format("%s", db.getString("item_name")), width/2, height/2);
        popMatrix();
    }

    void display() {
        srcP1.display(0);
        srcP2.display(0);
        srcP3.display(0);
        srcP4.display(0);
        distP1.display(0);
        distP2.display(0);
        distP3.display(0);
        distP4.display(0);

        showItemName();

        // FlyingMoneyの表示・非表示処理
        if (!f1.isCompleteControlAlpha || !f2.isCompleteControlAlpha || !f3.isCompleteControlAlpha || !f4.isCompleteControlAlpha) {
            f1.controlAlpha();
            f2.controlAlpha();
            f3.controlAlpha();
            f4.controlAlpha();
        } else {
            if (f1.isArrivaled && f2.isArrivaled && f3.isArrivaled && f4.isArrivaled) {
                // 次のFlyingMoneyを準備
                flyingOffsetY = 0;
                distP1.updateAmount(f1.amount);
                distP2.updateAmount(f2.amount);
                distP3.updateAmount(f3.amount);
                distP4.updateAmount(f4.amount);
                srcP1.updateAmount(f1.amount);
                srcP2.updateAmount(f2.amount);
                srcP3.updateAmount(f3.amount);
                srcP4.updateAmount(f4.amount);
                dbNext();
            } else {
                // FlyingMoney移動処理
                f1.display(flyingOffsetY);
                f2.display(flyingOffsetY);
                f3.display(flyingOffsetY);
                f4.display(flyingOffsetY);
            }
            flyingOffsetY += 5;
        }
    }
}
