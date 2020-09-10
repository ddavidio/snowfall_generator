class Particle{
  PVector pos;
  int r;
  
  Particle(float x, float y){
    pos = new PVector(x, y);
    r = 3;
  }
  
  void update() {
    pos.x -= 1;
    pos.y += random(-3, 3);
    
    float angle = pos.heading();
    angle = constrain(angle, 0, PI/6);
    float magnitude = pos.mag();
    pos = PVector.fromAngle(angle);
    pos.setMag(magnitude);
  }
  
  void show() {
    fill(255);
    stroke(255);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  boolean finished(){
    return (this.pos.x < 1);
  }
  
  boolean intersects(ArrayList<Particle> snowflake){
    boolean result = false;
    for (Particle s: snowflake){
      float d = dist(s.pos.x, s.pos.y, this.pos.x, this.pos.y);
      if(d<r*2){
        result = true;
        break;
      }
    }
    return result;
  }
}