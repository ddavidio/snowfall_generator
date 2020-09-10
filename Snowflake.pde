public class Snowflake{
  PVector pos, vel, acc, force;
  int r, rMultiplier = 20;
  float terminalVel;
  Snowflake(){
    this.pos = new PVector(random(width), random((-height - 10), -10));
    this.vel = new PVector(0, random(0, 20));
    this.acc = new PVector();
    
    this.r = (int) pseudoRandom(rMultiplier);
    this.terminalVel = this.r;
  }
  
  float pseudoRandom(int multiplier){
    return constrain(abs(random(1) - random(1)) * multiplier, 3, rMultiplier);
  }
  
  void applyForce(PVector force){
    PVector f = force.copy();
    f.mult(this.r);
    this.acc.add(f);
  }
  
  void render(){
    stroke(255);
    strokeWeight(this.r);
    point(this.pos.x, this.pos.y);
  }
  
  void update(){
    this.vel.add(this.acc);
    this.vel.limit(this.terminalVel);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  boolean offScreen(){
    return (this.pos.y > (height + this.r));
  }
}
