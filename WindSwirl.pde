class WindSwirl {
  float x, y;
  float angle;
  float length;
  float opacity;
  color swirlColor;

  WindSwirl(float x, float y, float length) {
    this.x = x;  // Start position X (can be left or center)
    this.y = y;
    this.angle = random(TWO_PI);
    this.length = length;
    this.opacity = 150; // Semi-transparent color
    // Random baby blue color shades
    swirlColor = color(random(180, 230), random(200, 255), random(230, 255), opacity);
  }

  void update() {
    // Move the wind swirl from left to right until it reaches the right side
    if (x < width) {
      x += 8; // Move to the right across the screen
    }

    angle += 0.01; // Rotate to create swirling motion
    opacity -= 1.5; // Fade the swirl over time

    // Add some randomness to the length to mimic the flow of wind
    length += sin(angle * 0.3) * 2;
    if (opacity <= 0) {
      opacity = 0;
    }

    // Adjust the color to keep the baby blue theme with some randomness
    swirlColor = color(random(180, 230), random(200, 255), random(230, 255), opacity);
  }

  void display() {
    noFill();
    stroke(swirlColor); // Use the dynamically adjusted baby blue color
    strokeWeight(3);

    beginShape();
    for (float i = 0; i < length; i += 5) {
      float xOffset = cos(angle + i * 0.1) * i * 0.4;
      float yOffset = sin(angle + i * 0.1) * i * 0.4;
      vertex(x + xOffset, y + yOffset);
    }
    endShape();
  }

  boolean isDead() {
    return opacity <= 0 || (x >= width && this.x == 0) || (x >= width / 1.5 && this.x != 0);
  }
}
