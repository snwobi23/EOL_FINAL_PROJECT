class House {
  float x, y, w, h;
  color bodyColor, roofColor;
  boolean hasChimney;
  int roofType; // 0 = triangle, 1 = slanted

  House(float x, float y, float w, float h, color bodyColor, color roofColor, boolean hasChimney, int roofType) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.bodyColor = bodyColor;
    this.roofColor = roofColor;
    this.hasChimney = hasChimney;
    this.roofType = roofType;
  }

  void display() {
    noStroke();
    fill(bodyColor);
    rect(x, y - h, w, h);

    fill(roofColor);
    if (roofType == 0) {
      // Triangle roof
      triangle(x, y - h, x + w / 2, y - h - w / 2, x + w, y - h);
    } else {
      // Slanted roof
      quad(x, y - h, x + w, y - h - 10, x + w, y - h, x, y - h + 10);
    }

    if (hasChimney) {
      fill(roofColor);
      rect(x + w * 0.75, y - h - 20, 6, 20);
    }
  }
}
