// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Bone {
  
  PImage bone;

  float xbPos, ybPos;
  float xbSpeed, ybSpeed;
  float xbReset, ybReset;
  
  Bone() {
    this.xbPos = random(450);
    this.ybPos = random(450);
    this.xbSpeed = 2.2;
    this.ybSpeed = 1.5;
    bone = loadImage("bone.png");
  }
  
  void boneControls() {
    image(bone, xbPos, ybPos, 80, 60);
    
    xbPos = xbPos + xbSpeed;
    ybPos = ybPos + ybSpeed;
    
    if ((xbPos > width) || (xbPos < 0)) {
      xbSpeed = xbSpeed * -1;
    }
    if ((ybPos > height) || (ybPos < 0)) {
      ybSpeed = ybSpeed * -1;
    }
    
    if (found) {
      if ((xbPos<=(0-posePosition.x)+width + mouthWidth*4) && (xbPos>=(0-posePosition.x)+width-mouthWidth*5) && (ybPos<=posePosition.y+mouthHeight*4) && (ybPos>=posePosition.y-mouthHeight*4)) {
        xbPos= xbReset ;
        ybPos = ybReset;
        score+= -1;
      }
    }
  }
  
  void boneReset() {
    xbReset = random(450);
    ybReset = random(450);
  }
}
