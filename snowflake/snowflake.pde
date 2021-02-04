// Modified code from "The Coding Train - Coding Challenge #127: Brownian Tree Snowflake" at www.youtube.com/watch?v=XUA8UREROYE

Particle current;
ArrayList<Particle> snowflake;

void setup() {
  size(64,64);
  current = new Particle(width/2, 0);
  snowflake = new ArrayList<Particle>();
}

void draw() {
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
