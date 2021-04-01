// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

import processing.net.*;
import oscP5.*;
OscP5 oscP5;

PFont font;
String input;
int data[];

PVector posePosition;
boolean found;
float mouthHeight;
float mouthWidth;
float poseScale;

PImage taco;
PImage bone;
PImage popcorn;
PImage pizza;
PImage mouth;

// variables for bone position
float xPos;
float yPos;
float xSpeed = 2.2;
float ySpeed = 1.5;

//variables for taco position
float xaPos = random (500);
float yaPos = random (500);
float xaSpeed = 3;
float yaSpeed = 2.0;

// variables for doughnut position
float xdPos = random (500);
float ydPos = random (500);
float xdSpeed = 2.0;
float ydSpeed = 1.8;

// variables for pizza position
float xfPos = random (500);
float yfPos = random (500);
float xfSpeed = 2.5;
float yfSpeed = 2.0;

// reset the location of food once it's been eaten 
float xReset;
float yReset;
float xaReset;
float yaReset;
float xdReset;
float ydReset;
float xfReset;
float yfReset;

// set score equal to zero in beginning
int score = 0;

ArrayList<ParticleSystem> systems;

void setup() {
  size(640, 480);
  frameRate(45);
  smooth(); 
  font = loadFont("Consolas-Italic-48.vlw");
  textFont(font);

  // faceOSC data
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseScale", "/pose/scale");

  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  noStroke();
  fill(0);
  textSize(20);

  // load images
  mouth= loadImage("mouth.png");
  taco = loadImage("taco.png");
  bone = loadImage("bone.png");
  popcorn = loadImage("popcorn.png");
  pizza = loadImage("pizza.png");
  
  systems = new ArrayList<ParticleSystem>();
  systems.add(new ParticleSystem(1,new PVector(320,600)));
}


void draw() {  
  background(120);
  food();
  winScreen();
}

void food() {
  // once the food is eaten, move it to a random position on the screen
  xReset = random(500);
  yReset = random(500);
  xaReset = random(500);
  yaReset = random(500);
  xdReset = random(500);
  ydReset = random(500);
  xfReset = random(500);
  yfReset = random(500);

  // place score headline text

  text("Your Score", width-130, 40);
  text("Opponent's Score", 130, 40);

  //update score text
  text(score, width-130, 80);

  //CONTROLS bone LOCATION
  xPos = xPos + xSpeed;
  yPos = yPos + ySpeed;

  // make sure the bone stays on the page
  if ((xPos > width) || (xPos < 0)) {
    xSpeed = xSpeed * -1;
  }
  if ((yPos > height) || (yPos < 0)) {
    ySpeed = ySpeed * -1;
  }

  //controls taco location
  xaPos = xaPos + xaSpeed;
  yaPos = yaPos + yaSpeed;

  // make sure taco stays on the page
  if ((xaPos > width) || (xaPos < 0)) {
    xaSpeed = xaSpeed * -1;
  }
  if ((yaPos > height) || (yaPos < 0)) {
    yaSpeed = yaSpeed * -1;
  }

  //move doughnut and make sure makesure doughnut stays on the screen
  xdPos = xdPos + xdSpeed;
  ydPos = ydPos + ydSpeed;
  if ((xdPos > width) || (xdPos < 0)) {
    xdSpeed = xdSpeed * -1;
  }
  if ((ydPos > height) || (ydPos < 0)) {
    ydSpeed = ydSpeed * -1;
  }

  //move pizza and makesure pizza stays on the screen
  xfPos = xfPos + xfSpeed;
  yfPos = yfPos + yfSpeed;

  if ((xfPos > width) || (xfPos < 0)) {
    xfSpeed = xfSpeed * -1;
  }

  if ((yfPos > height) || (yfPos < 0)) {
    yfSpeed = yfSpeed * -1;
  }

  // place images
  image(bone, xPos, yPos, 80, 80);
  image(taco, xaPos, yaPos, 80, 80);
  image(popcorn, xdPos, ydPos, 60, 60);
  image(pizza, xfPos, yfPos, 70, 70);


  if (found) {

    // if the coordinates of the bone are within the mouth vector, add a point and move the bone to a random location
    if ((xPos<=(0-posePosition.x)+width + mouthWidth*4) && (xPos>=(0-posePosition.x)+width-mouthWidth*5) && (yPos<=posePosition.y+mouthHeight*4) && (yPos>=posePosition.y-mouthHeight*4)) {
      xPos= xReset ;
      yPos = yReset;
      score+= -1;
    }

    // if the coordinates of the taco are within the mouth vector, add a point and move the taco to a random location
    if ((xaPos<=(0-posePosition.x)+width+mouthWidth*4) && (xaPos>=(0-posePosition.x)+width - mouthWidth*5) && (yaPos<=posePosition.y+mouthHeight*4) && (yaPos>=posePosition.y-mouthHeight*4)) {
      xaPos= xaReset ;
      yaPos = yaReset;
      score+= 1;
    }

    // if the coordinates of the popcorn are within the mouth vector, add a point and move the popcorn to a random location
    if ((xdPos<=(0-posePosition.x)+width+mouthWidth*4) && (xdPos>=(0-posePosition.x)+width - mouthWidth*5) && (ydPos<=posePosition.y+mouthHeight*4) && (ydPos>=posePosition.y-mouthHeight*4)) {
      xdPos= xdReset ;
      ydPos = ydReset;
      score+= 1;
    }

    // if the coordinates of the pizza are within the mouth vector, add a point and move the pizza to a random location
    if ((xfPos<=(0-posePosition.x)+width+mouthWidth*4) && (xfPos>=(0-posePosition.x)+width - mouthWidth*5) && (yfPos<=posePosition.y+mouthHeight*4) && (yfPos>=posePosition.y-mouthHeight*4)) {
      xfPos= xdReset ;
      yfPos = ydReset;
      score+= 1;
    }

    // import image of the mouth, controled by location of mouth on FaceOSC app
    image(mouth, (0-posePosition.x)+width, posePosition.y-mouthHeight*4, mouthWidth*10, mouthHeight+50);
  }
}

void winScreen() {
  if (score>=1) {
    background(#7CED41);
    for (ParticleSystem ps: systems) {
      ps.run();
      ps.addParticle(); 
    }
    fill(255);
    textAlign(CENTER);
    text("Congratulations, you have beaten the game!", width/2, height/2-100);
    text("To restart the game press R.", width/2, height/2-50);
    text("To close the game press ESC.", width/2, height/2);
    xSpeed = 0;
    ySpeed = 0;
    xaSpeed = 0;
    yaSpeed = 0;
    yfSpeed = 0;
    xfSpeed = 0;
    ydSpeed = 0;
    xdSpeed = 0;
  }
}

public void mouthWidthReceived(float w) {
  //println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  //println("mouth height: " + h);
  mouthHeight = h;
}

public void found(int i) {
  //println("found: " + i); // 1 == found, 0 == not found
  found = i == 1;
}

public void posePosition(float x, float y) {
  //println("pose position\tX: " + x + " Y: " + y );
  posePosition = new PVector(x, y);
}

public void poseScale(float s) {
  //println("scale: " + s);
  poseScale = s;
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    //println("UNPLUGGED: " + theOscMessage);
  }
}
