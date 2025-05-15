class House {
  float x, y, w, h;
  color wallColor, roofColor;
  boolean hasChimney;

  House(float x, float y, float w, float h, color wallColor, color roofColor, boolean hasChimney) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.wallColor = wallColor;
    this.roofColor = roofColor;
    this.hasChimney = hasChimney;
  }

  void display() {
    // House base
    fill(wallColor);
    rect(x, y - h, w, h);

    // Roof
    fill(roofColor);
    triangle(x - 5, y - h, x + w / 2, y - h - w / 2, x + w + 5, y - h);

    // Windows (2 glowing yellow windows)
    fill(255, 240, 100, 220);
    rect(x + w * 0.2, y - h + 15, 8, 12);
    rect(x + w * 0.6, y - h + 15, 8, 12);

    // Chimney
    if (hasChimney) {
      float chimneyX = x + w * 0.75;
      float chimneyY = y - h - w * 0.2;
      fill(roofColor);
      rect(chimneyX, chimneyY, 6, 20);
      drawSmoke(chimneyX + 3, chimneyY);
    }
  }

  void drawSmoke(float sx, float sy) {
    noStroke();
    for (int i = 0; i < 3; i++) {
      float yOffset = sin(frameCount * 0.05 + i) * 3;
      fill(200, 200, 200, 80 - i * 20);
      ellipse(sx + i * 2, sy - i * 15 + yOffset, 12 - i * 3, 12 - i * 3);
    }
  }
}
