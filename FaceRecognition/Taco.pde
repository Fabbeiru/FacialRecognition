// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Taco {
  
  PImage taco;

  float xtPos, ytPos;
  float xtSpeed, ytSpeed;
  float xtReset, ytReset;
  
  Taco() {
    this.xtPos = random(450);
    this.ytPos = random(450);
    this.xtSpeed = 2.5;
    this.ytSpeed = 2.0;
    taco = loadImage("taco.png");
  }
  
  void tacoControls() {
    image(taco, xtPos, ytPos, 80, 75);
    
    xtPos = xtPos + xtSpeed;
    ytPos = ytPos + ytSpeed;
  
    if ((xtPos > width) || (xtPos < 0)) {
      xtSpeed = xtSpeed * -1;
    }
  
    if ((ytPos > height) || (ytPos < 0)) {
      ytSpeed = ytSpeed * -1;
    }
    
    if (found) {
      if ((xtPos<=(0-posePosition.x)+width+mouthWidth*4) && (xtPos>=(0-posePosition.x)+width - mouthWidth*5) && (ytPos<=posePosition.y+mouthHeight*4) && (ytPos>=posePosition.y-mouthHeight*4)) {
        tacoReset();
        xtPos = xtReset;
        ytPos = ytReset;
        thread ("eat");
        score+= 1;
      }
    }
  }
  
  void tacoReset() {
    xtReset = random(450);
    ytReset = random(450);
  }
}
