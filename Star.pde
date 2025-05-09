class Star {
  float x, y;
  float angle;
  float speed;
  float size;

  Star(float x, float y, float speed, float size) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.size = size;
    this.angle = random(TWO_PI);
  }

  void update() {
    angle += speed;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();

    int layers = 10;
    for (int i = layers; i >= 1; i--) {
      float r = size + i * 6;
      int alpha = int(255 * (1.0 / i));  // Fade the outer rings
      fill(255, 255, 100, alpha);
      ellipse(0, 0, r, r);
    }

    // Inner core of the star
    fill(255, 255, 150);
    ellipse(0, 0, size, size);

    popMatrix();
  }
}
