// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class ParticleSystem {

  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();
    origin = v.get();
    for (int i = 0; i < num; i++) {
      particles.add(new Confetti(origin));
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    float r = random(1);
    if (r>0.6) {
    particles.add(new Confetti(origin));
    }
    if (r<0.3) {
    particles.add(new SquareParticle(origin));
    }
    else {
      particles.add(new Particle(origin));
    }
  }

  // A method to check if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}

class SquareParticle extends Particle {
  
  SquareParticle(PVector l) {
    super(l);
  }
  
  void display() {
    //fill(int(random(255)), int(random(255)), int(random(255)));
    fill(255,255,153, lifespan);
    stroke(255,255,0);
    rectMode(CENTER);
    // new code
    pushMatrix();
    translate(location.x,location.y);
    float theta = map(location.x,0,width,0,TWO_PI*3);
    rotate(theta);
    rect(0,0,13,13);
    popMatrix();
  }
}

class Confetti extends Particle {

  Confetti(PVector l) {
    super(l);
  }

  void display() {
    rectMode(CENTER);
    fill(255,102,255,lifespan);
    stroke(255,0,153,lifespan);
    strokeWeight(2);
    pushMatrix();
    translate(location.x,location.y);
    float theta = map(location.x,0,width,0,TWO_PI*2);
    rotate(theta);
    rect(0,0,12,12);
    popMatrix();
  }
}

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,-0.05);
    velocity = new PVector(random(-1,1),random(0,2));
    location = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.sub(acceleration);
    location.sub(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    stroke(51,51,255,lifespan);
    strokeWeight(2);
    fill(102,153,255,lifespan);
    ellipse(location.x,location.y,12,12);
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
