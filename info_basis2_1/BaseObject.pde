abstract class BaseObject {
    int CIRCLE = 1;
    int ANGLE = 2;
    int RECT = 3;
    int objectKind;
    int objSize;
    int statndardSize = 100;
    float easing;
    float bx;
    float by;
    float xOffset = 0.0;
    float yOffset = 0.0;
    boolean overObj = false;
    boolean locked = false;

    abstract void display(float offset);

    boolean isSelected() {
        if (mouseX > this.bx-this.objSize/2 &&
             mouseX < this.bx+this.objSize/2 &&
              mouseY > this.by-this.objSize/2 &&
               mouseY < this.by+this.objSize/2) {
            return true;
        } else {
            return false;
        }
    }

    void mouseDragged() {
        if (locked) {
            float targetX = mouseX;
            float dx = targetX - this.bx;
            this.bx += dx * easing;

            float targetY = mouseY;
            float dy = targetY - this.by;
            this.by += dy * easing;
        }
    }

    void mousePressed() {
        if(this.overObj) {
            this.locked = true;
            fill(255, 255, 255);
        } else {
            this.locked = false;
        }
        this.xOffset = mouseX-this.bx;
        this.yOffset = mouseY-this.by;
    }

    void mouseReleased() {
        this.locked = false;
    }

    void mouseOver() {
        if (this.isSelected()) {
            this.overObj = true;
            if(!this.locked) {
                stroke(0);
                fill(153);
            }
        } else {
            stroke(153);
            fill(153);
            this.overObj = false;
        }
    }
}
