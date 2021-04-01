// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Pizza {
  
  PImage pizza;

  float xpPos, ypPos;
  float xpSpeed, ypSpeed;
  float xpReset, ypReset;
  
  Pizza() {
    this.xpPos = random(450);
    this.ypPos = random(450);
    this.xpSpeed = 3;
    this.ypSpeed = 2.0;
    pizza = loadImage("pizza.png");
  }
  
  void pizzaControls() {
    image(pizza, xpPos, ypPos, 70, 70);
    
    xpPos = xpPos + xpSpeed;
    ypPos = ypPos + ypSpeed;
    
    if ((xpPos > width) || (xpPos < 0)) {
      xpSpeed = xpSpeed * -1;
    }
    if ((ypPos > height) || (ypPos < 0)) {
      ypSpeed = ypSpeed * -1;
    }
    
    if (found) {
      if ((xpPos<=(0-posePosition.x)+width+mouthWidth*4) && (xpPos>=(0-posePosition.x)+width - mouthWidth*5) && (ypPos<=posePosition.y+mouthHeight*4) && (ypPos>=posePosition.y-mouthHeight*4)) {
        xpPos= xpReset ;
        ypPos = ypReset;
        score+= 1;
      }
    }
  }
  
  void pizzaReset() {
    xpReset = random(450);
    ypReset = random(450);
  }
}
