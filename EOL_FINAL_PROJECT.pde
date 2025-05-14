Star[] stars;
ArrayList<WindSwirl> swirls = new ArrayList<WindSwirl>();
float lowestY;

void setup() {
  size(1250, 850);


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
  drawSkyGradient();
  drawCloudHorizon();

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
  drawTree();    // Foreground
  drawGrassBushes();
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
  bezierVertex(-10, -650, -10, -800, 0, -750);
  bezierVertex(10, -800, 30, -650, 40, -500);
  bezierVertex(50, -300, 70, -100, 90, 0);  // Narrower base end
  endShape(CLOSE);

  fill(110, 70, 40);
  beginShape();
  vertex(10, -400);
  bezierVertex(60, -460, 80, -520, 50, -540);
  bezierVertex(30, -560, 20, -520, 20, -470);
  endShape(CLOSE);

  popMatrix();
}

void drawGrassBushes() {
  pushMatrix();
  translate(0, height - 20); // Start at bottom-left corner

  int totalBlades = 20; // Increase number of blades
  for (int i = 0; i < totalBlades; i++) {
    float xOffset = i * 10;
    float sway = sin(frameCount * 0.05 + i) * 8;
    float curl = cos(frameCount * 0.03 + i) * 25;
    float heightVariation = random(60, 120); // Random height range

    fill(30, 120 + (i % 5) * 10, 50); // Slight variation in green
    beginShape();
    vertex(xOffset, 20);
    bezierVertex(xOffset - 8 + sway, 10,
                 xOffset - 6 + sway, -10,
                 xOffset + sway, -heightVariation + curl);
    bezierVertex(xOffset + 6 + sway, -10,
                 xOffset + 8 + sway, 10,
                 xOffset, 20);
    endShape(CLOSE);
  }

  popMatrix();
}

void drawSkyGradient() {
  for (int y = 0; y < height; y++) {
    float lerpAmt = map(y + sin(frameCount * 0.002 + y * 0.02) * 30, 0, height, 0, 1);
    
    // Top of the sky (deep indigo)
    color top = color(15, 20, 50);
    
    // Horizon (lighter blue-gray)
    color bottom = color(60, 90, 130);
    
    stroke(lerpColor(top, bottom, lerpAmt));
    line(0, y, width, y);
  }
}

void drawCloudHorizon() {
  noStroke();
  fill(255, 255, 255, 100);  // Soft white with transparency

  beginShape();
  for (float x = 0; x <= width; x += 20) {
    // Lower y-value = higher in sky; stays below stars
    float y = height * 0.60 + sin(x * 0.015 + frameCount * 0.005) * 15;
    vertex(x, y);
  }
  vertex(width, height);  // Bottom right corner
  vertex(0, height);      // Bottom left corner
  endShape(CLOSE);
}
