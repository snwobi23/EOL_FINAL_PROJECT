Star[] stars;
ArrayList<WindSwirl> swirls = new ArrayList<WindSwirl>();
float lowestY;
House[] houses;
boolean flickerLights = false;

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

  // Initialize houses
  float houseBaseY = height * 0.96;
  houses = new House[10];
  for (int i = 0; i < houses.length; i++) {
    float x = 80 + i * 110;
    float terrainY = houseBaseY + sin(x * 0.01) * 25;
    float w = random(35, 55);
    float h = random(50, 75);
    color body = color(random(80, 180), random(60, 140), random(40, 120));
    color roof = color(random(50, 100), random(30, 70), random(20, 60));
    boolean hasChimney = i % 2 == 0;
    int roofType = int(random(2));
    houses[i] = new House(x, terrainY, w, h, body, roof, hasChimney, roofType);
  }
}

void draw() {
  drawSkyGradient();
  drawCloudHorizon();

  // Update and draw swirls
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

  drawHouseGround();

  for (House h : houses) {
    if (flickerLights && frameCount % 10 == 0) {
      h.toggleLights();
    }
    h.display();
  }

  drawMoon(1120, 150);
  drawWaves(lowestY + 120);
  drawTree();
  drawGrassBushes();
}

void keyPressed() {
  if ( key == 'f' || key == 'F') {
    flickerLights =! flickerLights;
  }
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

// -- Waves --
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
    vertex(width, baseY + 100);
    vertex(0, baseY + 100);
    endShape(CLOSE);
  }
}

// -- Tree --
void drawTree() {
  pushMatrix();
  translate(100, height);
  noStroke();
  fill(101, 67, 33);

  beginShape();
  vertex(-90, 0);
  bezierVertex(-70, -100, -50, -300, -30, -500);
  bezierVertex(-10, -650, -10, -800, 0, -750);
  bezierVertex(10, -800, 30, -650, 40, -500);
  bezierVertex(50, -300, 70, -100, 90, 0);
  endShape(CLOSE);

  fill(110, 70, 40);
  beginShape();
  vertex(10, -400);
  bezierVertex(60, -460, 80, -520, 50, -540);
  bezierVertex(30, -560, 20, -520, 20, -470);
  endShape(CLOSE);
  popMatrix();
}

// -- Grass Bushes --
void drawGrassBushes() {
  pushMatrix();
  translate(0, height - 20);

  int totalBlades = 10;
  for (int i = 0; i < totalBlades; i++) {
    float xOffset = i * 10;
    float sway = sin(frameCount * 0.05 + i) * 3;
    float curl = cos(frameCount * 0.3 + i) * 20;
    float heightVariation = random(60, 120);

    fill(30, 120 + (i % 5) * 10, 50);
    beginShape();
    vertex(xOffset, 20);
    bezierVertex(xOffset - 8 + sway, 10,
      xOffset - 6 + sway, -10,
      xOffset + sway, -heightVariation + curl);
    bezierVertex(xOffset + 20 + sway, -50,
      xOffset + 8 + sway, 20,
      xOffset, 20);
    endShape(CLOSE);
  }

  popMatrix();
}

// -- Sky Gradient --
void drawSkyGradient() {
  for (int y = 0; y < height; y++) {
    float lerpAmt = map(y + sin(frameCount * 0.002 + y * 0.02) * 30, 0, height, 0, 1);
    color top = color(15, 20, 50);
    color bottom = color(60, 90, 130);
    stroke(lerpColor(top, bottom, lerpAmt));
    line(0, y, width, y);
  }
}

// -- Cloud Horizon --
void drawCloudHorizon() {
  noStroke();
  fill(255, 255, 255, 100);

  beginShape();
  for (float x = 0; x <= width; x += 20) {
    float y = height * 0.60 + sin(x * 0.015 + frameCount * 0.005) * 15;
    vertex(x, y);
  }
  float bottomY = height * 0.75;
  vertex(width, bottomY);
  vertex(0, bottomY);
  endShape(CLOSE);
}

void drawHouseGround() {
  noStroke();

  // Ground height and shape
  float topY = height * 0.75;  // Pull it up more

  // Generate grainy texture as image
  PGraphics groundTexture = createGraphics(width, height);
  groundTexture.beginDraw();
  groundTexture.noStroke();
  for (int y = int(topY); y < height; y++) {
    for (int x = 0; x < width; x++) {
      float noiseVal = noise(x * 0.03, y * 0.03);
      color baseColor = color(50, 40, 60);  // dark bluish base
      color grainColor = color(80, 60, 40); // brownish tone
      color blended = lerpColor(baseColor, grainColor, noiseVal * 0.8);
      groundTexture.set(x, y, blended);
    }
  }
  groundTexture.endDraw();
  image(groundTexture, 0, 0);  // draw grainy base first

  // Draw the actual terrain shape over the grain
  fill(0, 0, 0, 40); // subtle shadow fill to darken terrain
  beginShape();
  for (int x = 0; x <= width; x += 10) {
    float yOffset = sin(x * 0.01) * 25;
    vertex(x, topY + yOffset);
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}
