// This program contains modified code from their respective original authors.
// (1) Snowfall generator by "The Coding Train":
//          https://www.youtube.com/watch?v=cl-mHFCGzYk
// (2) Brownian Tree Snowflake generator by "The Coding Train":
//          https://www.youtube.com/watch?v=XUA8UREROYE&t=918s
// (3) Saving an image with transparent background by "GoToLoop":
//          forum.processing.org/two/discussion/12036/saving-sketch-with-a-transparent-background

// For snowfall (group of snowflakes) generation
Snowflake[] snow = new Snowflake[400];
PVector gravity = new PVector(0, 0.01);

// For individual snowflake generation
Particle current;
ArrayList<Particle> snowflake;
boolean hasStopped;
int totalSnowflakes = 10;
int curSnowflakes = 0;

void setup() {
  size(800, 800);
  frameRate(30);

  // For snowfall (group of snowflakes) generation
  for (int i = 0; i < snow.length; i++) {
    snow[i] = new Snowflake();
  }

  // For individual snowflake generation
  current = new Particle(width/2, random(10));
  snowflake = new ArrayList<Particle>();
}

void draw() {
  //letItSnow();
  generateSnowflake();
}

// For snowfall (group of snowflakes) generation
void letItSnow() {
  background(0);

  for (Snowflake flake : snow) {
    if (flake != null) {
      flake.applyForce(gravity);
      flake.render();
      flake.update();
    }
  }
  for (int i = snow.length - 1; i >= 0; i--) {
    if (snow[i].offScreen()) {
      snow[i] = new Snowflake();
    }
  }
}

// For individual snowflake generation
void generateSnowflake() {
  hasStopped = true;
  translate(width/2, height/2);
  rotate(PI/6);
  background(0, 0);

  while (!(current.finished() || current.intersects(snowflake))) {
    hasStopped = false;
    current.update();
  }
  snowflake.add(current);
  current=new Particle(width/2, 0);

  for (int i = 0; i < 6; i++) {
    rotate(PI/3); // Orient it like a snowflake, as opposed to some generic 6-sided shape

    // Make a particle
    current.show();
    for (Particle p : snowflake) {
      p.show();
    }

    // Make a copy of the particle
    // in order to have a symmetry
    pushMatrix();
    scale(1, -1);
    current.show();
    for (Particle p : snowflake) {
      p.show();
    }
    popMatrix();
  }

  if (hasStopped) {
    saveTransparentImage("snowflake"+curSnowflakes+".png");
    curSnowflakes++;
    snowflake = new ArrayList<Particle>();
    if (curSnowflakes == totalSnowflakes) {
      noLoop();
    }
  }
}

void saveTransparentImage(final String name) {
  final PImage canvas = this.get();
  canvas.format = ARGB;

  final color p[] = canvas.pixels;
  for (int i = 0; i != p.length; ++i)  if (p[i] == #000000)  p[i] = ~#000000;

  canvas.updatePixels();
  canvas.save(dataPath(name));
}


//TODO
// Sliders:
// * deviation of snowflake size (either pseudo random or truly random + lower and upper bounds of size)
// * number, velocity, acceleration of snowflakes
// * wind, gravity strength
// * how many unique snowflakes
// turn on / off Rotating snowflakes
// make file after setting sliders
