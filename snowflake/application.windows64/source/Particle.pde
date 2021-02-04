class Particle{
  PVector pos;
  float r;
  int dx, dy;
  Particle(float x, float y) {
   this.pos = new PVector(x, y);
   this.r = 1;
   this.dx = 1;
   this.dy = 3;
  }
  
  void update() {
    pos.x -= dx;
    pos.y += random(-1 * this.dy, this.dy);
    
    // <!> Constrain the angle that the particle can go on
    float angle = pos.heading();
    angle = constrain(angle, 0, PI/6);
    float magnitude = pos.mag();
    pos = PVector.fromAngle(angle);
    pos.setMag(magnitude);
    // </!>
  }

  void show() {
    fill(255);
    stroke(255);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  boolean finished() {
    return pos.x<1;
  }
  
  boolean intersects(ArrayList<Particle> snowflake){
    boolean result = false;
    for(Particle s: snowflake){
      float d = dist(s.pos.x, s.pos.y, this.pos.x, this.pos.y);
      if (d < r*2){
        result = true;
        break;
      }
    }
    return result;
  }
}
