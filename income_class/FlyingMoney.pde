class FlyingMoney {
    PImage flyingMoneyImg;
    boolean isArrivaled = false;
    boolean isCompleteControlAlpha = false;
    int srcX, srcY, distX, distY, amount, imgWidth, income;
    int maxAlpha = 255;
    int currentAlpha = 0;
    PFont amountFont = createFont("HiraKakuPro-W3", 30);
    int[] List = {200, 300, 400, 500, 600, 700, 800, 900, 1000, 1250, 1500, 2000, 3000};
    FlyingMoney(int srcX, int srcY, int distX, int distY, int income) {
        this.srcX = srcX;
        this.srcY = srcY;
        this.distX = distX;
        this.distY = distY;
        this.income = income;
        flyingMoneyImg = loadImage("img/money_fly_yen.png");
    }

    void udpateAmount(int amount) {
        this.amount = amount;
        isArrivaled = false;
        isCompleteControlAlpha = false;
        imgWidth = int(map(this.amount, 0, 800000, 80, 180));
    }

    void controlAlpha() {
        pushMatrix();
        imageMode(CENTER);
        flyingMoneyImg.resize(imgWidth, 0);
        if (isArrivaled) {
            // フェードアウト処理開始
            if (currentAlpha > 0) {
                currentAlpha -= 3;
                tint(255, currentAlpha);
                image(flyingMoneyImg, srcX, distY);
                showAmount(srcX, distY+flyingMoneyImg.height/2+20);
            } else {
                isCompleteControlAlpha = true;
            }
        } else {
            // フェードイン処理開始
            tint(255, currentAlpha);
            image(flyingMoneyImg, srcX, srcY);
            if (currentAlpha >= maxAlpha) {
                isCompleteControlAlpha = true;
            }
            currentAlpha += 5;
        }
        popMatrix();
    }

    void showAmount(int x, int y) {
        fill(255, 0, 0);
        textFont(amountFont, 32);
        textMode(CENTER);
        textAlign(CENTER);
        text(String.format("%,d円", amount), x, y);
    }

    void display(int offsetY) {
        // 目的地に到着したか判定
        if (distY > srcY-offsetY) {
            // 目的地到着
            isArrivaled = true;
            // フェードアウト処理開始
            isCompleteControlAlpha = false;
        } else {
            pushMatrix();
            imageMode(CENTER);
            flyingMoneyImg.resize(imgWidth, 0);
            image(flyingMoneyImg, srcX, srcY-offsetY);
            showAmount(srcX, srcY-offsetY+flyingMoneyImg.height/2+20);
            popMatrix();
        }
    }
}
