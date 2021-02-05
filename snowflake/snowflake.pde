// Modified code from "The Coding Train - Coding Challenge #127: Brownian Tree Snowflake" at www.youtube.com/watch?v=XUA8UREROYE

Particle p;
ArrayList<Particle> snowflake;

int targetNumSnowflakes = 10;
int currentNumSnowflakes = 0;

void setup() {
  size(128,128);
  //surface.setVisible(false);
  p = new Particle(width/2, 0);
  snowflake = new ArrayList<Particle>();
}

void draw() {
  generateSnowflake();
}

void generateSnowflake(){
  boolean isFinished = true;
  
  translate(width/2, height/2);
  rotate(PI/6); // reorient the snowflake
  background(0);
  while(!p.finished() && !p.intersects(snowflake)){
    isFinished = false;
    p.update();
  }

  snowflake.add(p);
  p = new Particle(width/2, 0);
  
  for (int i = 0; i < 6; i++){
    rotate(PI/3);
    p.show();
    for(Particle particle : snowflake){
      particle.show();
    }
    pushMatrix();
    scale(1, -1); // reflect around the x-axis
    p.show();
    for(Particle particle : snowflake){
      particle.show();
    }
    popMatrix();
  }
  
  if(isFinished){
    saveTransparentImage("snowflake"+currentNumSnowflakes+".png");
    currentNumSnowflakes++;
    if(currentNumSnowflakes == targetNumSnowflakes)
      noLoop();
    else
      snowflake = new ArrayList<Particle>();
  }
}

void saveTransparentImage(final String name){
  final PImage canvas = this.get();
  canvas.format = ARGB;
  final color p[] = canvas.pixels;
  for (int i = 0; i != p.length; ++i) if (p[i] == #000000) p[i] = ~#000000;
  canvas.updatePixels();
  canvas.save(dataPath(name));
}

int nearestPowOf2(int n){
  return n == 0 ? 0 : 32 - Integer.numberOfLeadingZeros(n - 1);
}
