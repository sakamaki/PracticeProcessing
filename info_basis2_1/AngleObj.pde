class AngleObj extends BaseObject {
    AngleObj() {
        this.objectKind = this.ANGLE;
        this.objSize = 180;
    }

    boolean isSelected() {
        if (mouseX > this.bx-this.objSize &&
             mouseX < this.bx+this.objSize &&
              mouseY > this.by-this.objSize &&
               mouseY < this.by+this.objSize) {
            return true;
        } else {
            return false;
        }
    }

    void mouseDragged() {
        if(this.locked) {
            this.bx = mouseX - this.xOffset;
            this.by = mouseY - this.yOffset;
        }
    }

    void display(float offset) {
        this.mouseOver();
        triangle(
            100+bx,
            20+by,
            this.objSize+bx,
            this.objSize+by,
            20+bx,
            this.objSize+by);
    }
}
