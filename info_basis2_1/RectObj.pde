class RectObj extends BaseObject {
    RectObj() {
        this.objectKind = this.RECT;
        this.objSize = 300;
        this.easing = 0.01f;
    }

    void display(float offset) {
        rectMode(CENTER);
        this.mouseOver();
        rect(this.bx, this.by, this.objSize, this.objSize);
    }
}
