class House {
  float x, y, w, h;
  color bodyColor, roofColor;
  boolean hasChimney;
  int roofType; // 0 = triangle, 1 = slanted
  boolean lightsOn;

  House(float x, float y, float w, float h, color bodyColor, color roofColor, boolean hasChimney, int roofType) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.bodyColor = bodyColor;
    this.roofColor = roofColor;
    this.hasChimney = hasChimney;
    this.roofType = roofType;
    this.lightsOn = true;
  }

  void display() {
    noStroke();

    // House Color
    fill(bodyColor);
    rect(x, y - h, w, h);

    // Roof
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
      drawSmoke(x + w * 0.75 + 3, y - h - 20);
    }
    // Windows
    float winW = w / 5;
    float winH = h / 5;
    fill(lightsOn ? color(255, 255, 100, random(180, 255)) : color(20, 20, 30));
    float leftX = x + w * 0.2;
    float rightX = x + w * 0.6;
    float winY = y - h + h * 0.3;

    rect(leftX, winY, winW, winH);
    rect(rightX, winY, winW, winH);

    // Bars on windows
    stroke(40);
    strokeWeight(1);
    for (int i = 1; i < 3; i++) {
      float lx = leftX + i * winW / 3;
      float rx = rightX + i * winW / 3;
      line(lx, winY, lx, winY + winH);
      line(rx, winY, rx, winY + winH);
    }
    line(leftX, winY + winH / 2, leftX + winW, winY + winH / 2);
    line(rightX, winY + winH / 2, rightX + winW, winY + winH / 2);
    noStroke();
  }

  void drawSmoke(float sx, float sy) {
    noStroke();
    for (int i = 0; i < 5; i++) {
      fill(150, 150, 150, 100 - i * 20);
      ellipse(sx + random(-3, 3), sy - i * 8 + random(-2, 2), 10 - i, 10 - i);
    }
  }

  void toggleLights() {
    lightsOn = !lightsOn;
  }
}
