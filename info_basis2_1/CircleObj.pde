class CircleObj extends BaseObject {
    CircleObj() {
        this.objectKind = this.CIRCLE;
        this.objSize = 100;
        easing = 0.5f;
    }

    void display(float offset) {
        this.mouseOver();

        ellipse(this.bx, this.by, this.objSize, this.objSize);
    }

}
