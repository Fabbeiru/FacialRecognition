// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

import processing.sound.*;
import oscP5.*;
OscP5 oscP5;

// FaceOSC
PVector posePosition;
boolean found;
float mouthHeight;
float mouthWidth;
float poseScale;

// Others
PFont font;
PImage menuImage;
int score = 0;
int maxScore = 10;
boolean startGame, menu, victory, particleAdded;
ArrayList<ParticleSystem> systems;
SoundFile eat;
SoundFile wrongFood;

// Objects
Bone bone;
Mouth mouth;
Pizza pizza;
Popcorn popcorn;
Taco taco;

void setup() {
  size(640, 480);
  frameRate(45);
  smooth(); 
  font = loadFont("Consolas-Italic-48.vlw");
  textFont(font);
  
  mouth = new Mouth();
  bone = new Bone();
  pizza = new Pizza();
  popcorn = new Popcorn();
  taco = new Taco();
  
  startGame = false;
  victory = false;
  menu = true;
  particleAdded = false;

  // FaceOSC
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
  
  systems = new ArrayList<ParticleSystem>();
  eat = new SoundFile(this, "score.wav");
  wrongFood = new SoundFile(this, "hit.wav");
}

void draw() {
  if (menu) menu();
  else {
    background(120);
    showHelp();
    initFood();
    if (victory) victoryScreen();
    if (!found) errorScreen();
  }
}

void resetGame() {
  bone.boneReset();
  pizza.pizzaReset();
  popcorn.popcornReset();
  taco.tacoReset();
  victory = false;
  score = 0;
  particleAdded = false;
}

void showHelp() {
  textAlign(LEFT);
  textSize(20);
  text("> Move your head to control the cartoon mouth.", 20, 40);
  text("> Eat a piece of food to add 1 point to your score", 20, 70);
  text("> If you eat the bone you lose 1 point.", 20, 100);
  text("> Press R to restart game.", 20, 130);
  text("> Reach 10 points to win.", 20, 160);
  textAlign(CENTER);
  text("Score", 570, 420);
  text(score, 570, 450);
  if (score == maxScore) victory = true;
}

void menu() {
  background(0);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("Face Recognition", width/2, height/2-180);
  text("Game", width/2, height/2-130);
  textSize(25);
  text("by Fabián B.", width/2, height/2-80);
  fill(255, 0, 0);
  text("If you eat 10 pieces of food you win.", width/2, height/2+150);
  fill(255);
  text("Press ENTER to continue", width/2, height/2+200);
}

void errorScreen() {
  background(120);
  textSize(20);
  textAlign(CENTER);
  text("Please, turn on FaceOSC aplication or check if", width/2, height/2-10);
  text("it is working correctly in order to play the game.", width/2, height/2+10);
}

void initFood() {
  mouth.mouthControls();
  bone.boneControls();
  pizza.pizzaControls();
  popcorn.popcornControls();
  taco.tacoControls();
}

void eat() {
  eat.play();
}

void wrongFood() {
  wrongFood.play();
}

void victoryScreen() {
  if (!particleAdded) {
    particleAdded = true;
    systems.add(new ParticleSystem(1,new PVector(320,600)));
  }
  background(#7CED41);
  for (ParticleSystem ps: systems) {
    ps.run();
    ps.addParticle(); 
  }
  fill(255);
  textAlign(CENTER);
  textSize(25);
  text("Congratulations, you have beaten the game!", width/2, height/2-100);
  text("To restart the game press R.", width/2, height/2-50);
  text("To close the game press ESC.", width/2, height/2);
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

void keyPressed() {
  if (keyCode == ENTER) menu = false;
  if (key == 'R' || key == 'r') {
    victory = false;
    resetGame();
    systems.clear();
  }
}
