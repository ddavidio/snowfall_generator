import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class snowflake extends PApplet {

// Modified code from "The Coding Train - Coding Challenge #127: Brownian Tree Snowflake" at www.youtube.com/watch?v=XUA8UREROYE

Particle current;
ArrayList<Particle> snowflake;

public void setup() {
  
  current = new Particle(width/2, 0);
  snowflake = new ArrayList<Particle>();
}

public void draw() {
  translate(width/2, height/2);
  rotate(PI/6); // reorient the snowflake
  background(0);
  while(!current.finished() && !current.intersects(snowflake)){
    current.update();
  }

  snowflake.add(current);
  current = new Particle(width/2, 0);
  
  for (int i = 0; i < 6; i++){
    rotate(PI/3);
    current.show();
    for(Particle p : snowflake){
      p.show();
    }
    pushMatrix();
    scale(1, -1); // reflect around the x-axis
    current.show();
    for(Particle p : snowflake){
      p.show();
    }
    popMatrix();
  }
}


// TODO: optimize it so that it's not an ArrayList, but a linked list
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
  
  public void update() {
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

  public void show() {
    fill(255);
    stroke(255);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  public boolean finished() {
    return pos.x<1;
  }
  
  public boolean intersects(ArrayList<Particle> snowflake){
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
  public void settings() {  size(64,64); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "snowflake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
