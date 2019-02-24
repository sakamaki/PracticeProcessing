class Panel {
    int x, y, w, h, classId, amount, moneyCount, bulkMoneyWidth, centerX, centerY;
    int bulkMoneyColumnCount = 5;
    PImage characterImg, bulkMoneyImg;
    boolean isSrcPanel;
    String [][] classImageList = {
      {"money_single_mother_poor.png"}, // 貧困層
      {"company_black_baito.png",
       "business_black_kigyou.png",
       "job_yarigai_sausyu_suit.png"}, // マイルド貧困層
      {"restaurant_rich_family.png"}, // 中間層
      {"kaisya_desk1_syachou_young_man.png"}, // 富裕層
    };
    int[] moneyList = {200, 300, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 2000, 3000};
    String rankName;
    String[] rankNameList = {"200万円", "300万円", "400万円", "500万円", "600万円", "700万円", "800万円", "900万円", "1000万円", "1250万円", "1500万円", "2000万円", "3000万円"};
    PFont amountFont = createFont("HiraKakuPro-W3", 24);

    Panel(int x, int y, int w, int h, int classId, int rank, boolean isSrcPanel) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.classId = classId;
        this.isSrcPanel = isSrcPanel;
        int imageId = 0;
        switch(classId) {
            case 2:
                imageId = round(random(0, classImageList[classId-1].length-1));
                break;
        }
        characterImg = loadImage("img/" + classImageList[classId-1][imageId]);
        bulkMoneyImg = loadImage("img/money_satsutaba.png");
        bulkMoneyWidth = w / bulkMoneyColumnCount;
        amount = (isSrcPanel) ? moneyList[rank-1] * 10000 : 0;
        rankName = rankNameList[rank-1];
        centerX = x + w/2;
        centerY = y + h/2;
    }

    void updateAmount(int consumedMoney) {
        amount = (isSrcPanel) ? amount-consumedMoney : amount+consumedMoney;
        moneyCount = int(floor(amount / 1000000)); // 札束の個数
    }

    private void displayClassImage() {
        pushMatrix();
        translate(x+w/2, y+h/2);
        characterImg.resize(0, h-100);
        tint(255, 255);
        imageMode(CENTER);
        image(characterImg, 0, 0);
        popMatrix();
    }

    void displayAmount() {
        pushMatrix();
        fill(0);
        translate(x+w/2, y+h/2);
        textFont(amountFont, 24);
        textMode(CENTER);
        textAlign(CENTER);
        if (isSrcPanel) {
            text(String.format("年収%s, 残金: %d万円", rankName, amount/10000), 0, h/2 - 20);
        } else {
            text(String.format("%d万円", amount/10000), 0, h/2 - 20);
        }
        popMatrix();
    }

    void displayMoneyCount() {
        int rowCount = -1;
        int columnCount = 0;

        for (int i=0; i<moneyCount; i++) {
            if (i % bulkMoneyColumnCount == 0) {
                rowCount++;
            }
            if (columnCount == bulkMoneyColumnCount) {
                columnCount = 0;
            }
            pushMatrix();
            translate(x, y);
            bulkMoneyImg.resize(bulkMoneyWidth, 0);
            tint(255, 255);
            imageMode(CORNER);
            image(bulkMoneyImg, columnCount*bulkMoneyWidth, rowCount*bulkMoneyImg.height);
            columnCount++;
            popMatrix();
        }
    }

    void display(int consumedMoney) {
        fill(255);
        rect(x, y, w, h);
        updateAmount(consumedMoney);
        if (isSrcPanel) {
            displayClassImage();
        }
        displayAmount();
        displayMoneyCount();
    }
}
