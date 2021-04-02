// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Popcorn {
  
  PImage popcorn;

  float xpopPos, ypopPos;
  float xpopSpeed, ypopSpeed;
  float xpopReset, ypopReset;
  
  Popcorn() {
    this.xpopPos = random(450);
    this.ypopPos = random(450);
    this.xpopSpeed = 2.0;
    this.ypopSpeed = 1.8;
    popcorn = loadImage("popcorn.png");
  }
  
  void popcornControls() {
    image(popcorn, xpopPos, ypopPos, 50, 60);
    
    xpopPos = xpopPos + xpopSpeed;
    ypopPos = ypopPos + ypopSpeed;
    
    if ((xpopPos > width) || (xpopPos < 0)) {
      xpopSpeed = xpopSpeed * -1;
    }
    if ((ypopPos > height) || (ypopPos < 0)) {
      ypopSpeed = ypopSpeed * -1;
    }
    
    if (found) {
      if ((xpopPos<=(0-posePosition.x)+width+mouthWidth*4) && (xpopPos>=(0-posePosition.x)+width - mouthWidth*5) && (ypopPos<=posePosition.y+mouthHeight*4) && (ypopPos>=posePosition.y-mouthHeight*4)) {
        popcornReset();
        xpopPos = xpopReset;
        ypopPos = ypopReset;
        thread ("eat");
        score+= 1;
      }
    }
  }
  
  void popcornReset() {
    xpopReset = random(450);
    ypopReset = random(450);
  }
}
