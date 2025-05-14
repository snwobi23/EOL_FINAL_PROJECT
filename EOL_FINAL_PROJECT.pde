Star[] stars;
ArrayList<WindSwirl> swirls = new ArrayList<WindSwirl>();
float lowestY;

void setup() {
  size(1250, 850);
  background(20, 30, 70);

  // Initialize stars
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

  // Find lowest star Y
  lowestY = 0;
  for (Star s : stars) {
    if (s.y > lowestY) lowestY = s.y;
  }
}

void draw() {
  background(20, 30, 70);

  // Update wind swirls
  for (int i = swirls.size() - 1; i >= 0; i--) {
    WindSwirl w = swirls.get(i);
    w.update();
    w.display();
    if (w.isDead()) swirls.remove(i);
  }

  if (frameCount % 5 == 0) {
    float yOffset = 300 + sin(frameCount * 0.01) * 40;
    swirls.add(new WindSwirl(0, yOffset, random(30, 60)));
    swirls.add(new WindSwirl(width / 2, yOffset + 80, random(60, 80)));
  }

  for (Star s : stars) {
    s.update();
    s.display();
  }

  drawMoon(1120, 150);
  drawWaves(lowestY + 120);  // Draw behind tree
  drawTree();                // Foreground
}

// -- Moon --
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

// -- Waves (Background) --
void drawWaves(float baseY) {
  noStroke();
  for (int layer = 0; layer < 3; layer++) {
    float offset = layer * 25;
    fill(30, 60 + layer * 20, 100 + layer * 30, 200);

    beginShape();
    for (int x = 0; x <= width; x += 10) {
      float wave = sin((x * 0.01) + frameCount * 0.02 + layer) * 12;
      vertex(x, baseY + wave + offset);
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }
}

void drawTree() {
  pushMatrix();
  translate(100, height);  // Anchor to bottom-left

  noStroke();
  fill(101, 67, 33); // Brown

  beginShape();
  vertex(-90, 0);  // Narrower base start
  bezierVertex(-70, -100, -50, -300, -30, -500);
  bezierVertex(-10, -650, -10, -800, 0, -880);
  bezierVertex(10, -800, 30, -650, 40, -500);
  bezierVertex(50, -300, 70, -100, 90, 0);  // Narrower base end
  endShape(CLOSE);

  // Optional branch
  fill(110, 70, 40);
  beginShape();
  vertex(10, -400);
  bezierVertex(60, -460, 80, -520, 50, -540);
  bezierVertex(30, -560, 20, -520, 20, -470);
  endShape(CLOSE);

  popMatrix();
}
