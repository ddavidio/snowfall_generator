class Slider{
  float xInitial, x, y, w, h;
  float value;
  int min, max;
  String descriptor;
  boolean lock = false;
  
  Slider(float x, float y, int min, int max, String d) {
    this.xInitial = x;
    this.x = x;
    this.y = y;
    this.min = min;
    this.max = max;
    this.w = 40;
    this.h = 20;
    this.descriptor = d;
  }
  
  void draw(){
    // Draw the slider line
    float lineLength = width/2;
    float lineHeight = 4;
    float lineColor = map(x, xInitial, xInitial+lineLength, 128, 255);
    fill(color(lineColor));
    rect(xInitial, y, lineLength, lineHeight);
    
    // Draw the slider knob
    fill(255);
    rect(this.x, this.y-(this.h/2)+(lineHeight/2), this.w, this.h);
    
    // Draw the slider value
    this.value = map(lineColor, 128, 255, this.min, this.max);
    fill(0);
    textAlign(CENTER);
    text(int(this.value), this.x+21, this.y+7);
    
    fill(255);
    textAlign(RIGHT);
    text(this.descriptor + " (" + this.min + " to " + this.max + "): ", this.xInitial, this.y+7);
    
    // Take in input
    float inputX = constrain(mouseX, xInitial, xInitial+lineLength);
    if (lock) this.x = inputX;
  }
  
  boolean isHovered(){
    return (this.x + this.w >= mouseX) &&
           (mouseX >= this.x) &&
           (this.y + this.h >= mouseY) &&
           (mouseY >= this.y);
  }
}
