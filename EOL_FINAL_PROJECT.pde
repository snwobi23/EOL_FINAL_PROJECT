Star[] stars;
ArrayList<WindSwirl> swirls = new ArrayList<WindSwirl>();

void setup() {
  size(1250, 850);
  background(20, 30, 70);

  stars = new Star[9];
  stars[0] = new Star(60, 430, 0.01, 28);
  stars[1] = new Star(190, 470, -0.015, 24);
  stars[2] = new Star(90, 60, 0.012, 34);
  stars[3] = new Star(430, 150, -0.01, 30);
  stars[4] = new Star(610, 200, 0.02, 26);
  stars[5] = new Star(960, 250, -0.013, 32);
  stars[6] = new Star(900, 150, -0.012, 26);
  stars[7] = new Star(270, 260, 0.014, 22);
  stars[8] = new Star(570, 280, -0.016, 20);
}

void draw() {
  background(20, 30, 70);

  for (int i = swirls.size() - 1; i >= 0; i--) {
    WindSwirl w = swirls.get(i);
    w.update();
    w.display();
    if (w.isDead()) {
      swirls.remove(i);
    }
  }

  if (frameCount % 5 == 0) {
    float yOffset = 300 + sin(frameCount * 0.01) * 40; // Sinusoidal motion for variety
    swirls.add(new WindSwirl(0, yOffset, random(30, 60)));  // Wind from left
    swirls.add(new WindSwirl(width / 2, yOffset + 80, random(100, 100)));  // Wind from the center
  }

  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].display();
  }

  drawMoon(1120, 150);

  float lowestY = 0;
  for (int i = 0; i < stars.length; i++) {
    if (stars[i].y > lowestY) {
      lowestY = stars[i].y;
    }
  }

  // Draw waves under the lowest star
  drawWaves(lowestY + 120);
}

void drawMoon(float x, float y) {
  noStroke();
  for (int i = 8; i >= 1; i--) {
    float r = 90 + i * 12;
    int alpha = int(120 * (1.0 / i));
    fill(255, 240, 150, alpha);
    ellipse(x, y, r, r);
  }
  fill(255, 240, 180);
  ellipse(x, y, 90, 90);
  fill(20, 30, 70);
  ellipse(x + 20, y, 75, 75);
}

void drawWaves(float yBase) {
  int layers = 3;
  float baseWaveHeight = 8;  // Smaller height for distant waves
  float baseSpacing = 15;

  for (int l = 0; l < layers; l++) {
    float yOffset = yBase + l * baseSpacing;
    float waveHeight = baseWaveHeight - l * 1.5;  // Get flatter as they go back
    float alpha = 60 - l * 15;  // Lower opacity for farther layers
    float blue = 170 - l * 20;  // Less saturated blue as it recedes

    noStroke();
    fill(blue, blue + 20, blue + 40, alpha);  // Washed-out distant colors

    beginShape();
    vertex(0, height);      // Bottom left corner
    vertex(0, yOffset);

    for (float x = 0; x <= width; x += 12) {
      float y = yOffset + sin((x * 0.015) + (frameCount * 0.02) + l) * waveHeight;
      vertex(x, y);
    }

    vertex(width, height);  // Bottom right corner
    endShape(CLOSE);
  }
}




asd
