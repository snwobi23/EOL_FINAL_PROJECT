class Star {
  float x, y;
  float angle;
  float speed;
  float size;
  float twinkleOffset;

  Star(float x, float y, float speed, float size) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.size = size;
    this.angle = random(TWO_PI);
    this.twinkleOffset = random(TWO_PI);
  }

  void update() {
    angle += speed;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();

    float twinkle = sin(frameCount * 0.05 + twinkleOffset) * 0.5 + 0.5;

    int layers = 10;
    for (int i = layers; i >= 1; i--) {
      float r = size + i * 6;
      int alpha = int(255 * (1.0 / i) * twinkle);  // Fade the outer rings
      fill(255, 255, 255, alpha);
      ellipse(0, 0, r, r);
    }

    // Inner core of the star
    fill(255, 255, 100, int(255 * twinkle));
    ellipse(0, 0, size, size);

    popMatrix();
  }
}
