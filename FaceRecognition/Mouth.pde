// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Mouth {
  
  PImage mouth;
  
  Mouth() {
    mouth= loadImage("mouth.png");
  }
  
  void mouthControls() {
    if (found) {
      image(mouth, (0-posePosition.x)+width, posePosition.y-mouthHeight*4, mouthWidth*10, mouthHeight+50);
    }
  }
}
