Star[] stars;

void setup() {
  size(1250,850);
  background(20,30,70);
  
  stars = new Star[9]; // Reduced array size
  
  stars[0]  = new Star(60, 430, 0.01, 28);      // farthest middle-left
  stars[1]  = new Star(190, 470, -0.015, 24);   // farthest middle-left
  stars[2]  = new Star(90, 60, 0.012, 34);
  stars[3]  = new Star(430, 150, -0.01, 30);    // spaced out
  stars[4]  = new Star(610, 200, 0.02, 26);
  stars[5]  = new Star(960, 250, -0.013, 32);  // moved right slightly
  stars[6]  = new Star(900, 150, -0.012, 26);   // safely left of moon
  stars[7]  = new Star(270, 260, 0.014, 22);
  stars[8]  = new Star(570, 280, -0.016, 20);
}

void draw() {
  background(20,30,70);
  
  for(int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].display();
  }
  drawMoon(1120,150);
}
  
void drawMoon(float x, float y) { 
  noStroke();
  
  // Glowing layers
  for (int i = 8; i >= 1; i--) {
    float r = 90 + i * 12;
    int alpha = int(120 * (1.0 / i));
    fill(255, 240, 150, alpha);
    ellipse(x, y, r, r);
  }

  // Outer crescent shape
  fill(255, 240, 180);
  ellipse(x, y, 90, 90);

  // Cutout to create crescent effect
  fill(20, 30, 70); // Background color
  ellipse(x + 20, y, 75, 75);
}
