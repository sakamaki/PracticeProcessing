CircleObj circleObj = new CircleObj();
RectObj rectObj = new RectObj();
AngleObj angleObj = new AngleObj();

void setup() {
    fullScreen();
    frameRate(120);
    strokeWeight(2);
    background(255);
    float centerX = width / 2;
    float centerY = height / 2;
    angleObj.bx = centerX - angleObj.objSize / 2;
    angleObj.by = centerY - angleObj.objSize / 2;
    rectObj.bx = centerX + angleObj.objSize + 200;
    rectObj.by = centerY;
    circleObj.bx = centerX - angleObj.objSize - 50;
    circleObj.by = centerY;
}


void draw() {
    background(255);
    circleObj.display(1.0);
    rectObj.display(1.0);
    angleObj.display(1.0);
}

void mousePressed() {
    if (circleObj.isSelected()) {
        circleObj.mousePressed();
    } else if (rectObj.isSelected()) {
        rectObj.mousePressed();
    } else if (angleObj.isSelected()) {
        angleObj.mousePressed();
    }
}

void mouseDragged() {
    if (circleObj.isSelected()) {
        circleObj.mouseDragged();
    } else if (rectObj.isSelected()) {
        rectObj.mouseDragged();
    } else if (angleObj.isSelected()) {
        angleObj.mouseDragged();
    }
}

void mouseReleased() {
    circleObj.mouseReleased();
    rectObj.mouseReleased();
    angleObj.mouseReleased();
}
