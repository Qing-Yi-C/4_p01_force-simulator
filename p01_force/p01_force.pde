float GRAVITY = 0.4;
int MAX_SIZE  = 50;
int MIN_SIZE = 10;
float MAX_MASS = 10;
float MIN_MASS = 1;
float DAMPENING = 0.998;
float MIN_CHARGE = -1 * 1.602 * pow(10, -19);
float MAX_CHARGE = 1.602 * pow(10, -19);

int GRAV_ORBS = 13;
int COMBO_ORBS = 7;
float SPRING_CONST = 0.005;
int SPRING_LENGTH = 100;
float MU = -0.1;
float COULOMB_CONST = 8.99 * pow(10, 9);
ArrayList<Orb> springOrbs;

boolean moving;
boolean gravity;
boolean spring;
boolean friction;
boolean electric;
boolean combo;
boolean springConnected;

Orb[] grav;
Orb[] combos;
Orb f;
Orb atom0, atom1;
FixedOrb fixed;
FixedOrb earth;


void falsify () {
  moving = false;
  gravity = false;
  spring = false;
  friction = false;
  electric = false;
  combo = false;
  springConnected = false;
} //sets all booleans to false


void frame() {
  grav = new Orb[GRAV_ORBS];
  int x = 10;
  int y = 50;
  for (int i = 0; i < grav.length; i++) {
    int s = int(random(MIN_SIZE, MAX_SIZE));
    float m = random(MIN_MASS, MAX_MASS);
    x+= s/2;
    grav[i] = new Orb(x, y, s, m, 0);
    x+= s/2 + 10;
  }
  springOrbs = new ArrayList<Orb>();
  fixed = new FixedOrb(width/2, height/2 - SPRING_LENGTH, 10, 1);
  earth = new FixedOrb(width/2, height * 100, 1, 500);
  f = new Orb(15, height - 213, 25, 1.5, 0); //friction ball
  atom0 = new Orb(int(random(15, width-15)), int(random(15, height-15)), 30, 5, random(MIN_CHARGE, MAX_CHARGE));
  atom1 = new Orb(int(random(15, width-15)), int(random(15, height-15)), 30, 5, random(MIN_CHARGE, MAX_CHARGE));
  if (abs(atom0.charge) > abs(atom1.charge)) {
    atom0.size += 20;
  } else if (abs(atom0.charge) < abs(atom1.charge)) {
    atom1.size += 20;
  }
  combos = new Orb[COMBO_ORBS];
  int a = 10;
  int b = 50;
  for (int i = 0; i < combos.length; i++) {
    int size = int(random(MIN_SIZE, MAX_SIZE));
    float mass = random(MIN_MASS, MAX_MASS);
    a+= size/2;
    combos[i] = new Orb(a, b, size, mass, random(MIN_CHARGE, MAX_CHARGE));
    a+= size/2 + 10;
  }
}// initializes objects


void setup() {
  size(600, 600);
  background(255);
  falsify();
  frame();
}//setup


void draw() {
  background(255);
  displayMode();

  if (gravity) {
    for (int i = 0; i < grav.length; i++) {
      grav[i].display();
    }
    if (moving) {
      for (int i = 0; i < grav.length; i++) {
        PVector g = grav[i].getGravity(earth, GRAVITY);
        grav[i].applyForce(g);
        grav[i].run(true, DAMPENING);
      }
    }//moving
  }// gravity demo

  if (spring) {
    fixed.display();
    for (int i=0; i<springOrbs.size(); i++) {
      Orb part = springOrbs.get(i);
      part.display();
      if (springConnected) {
        if (i == 0) {
          drawSpring(part, fixed);
        } else {
          drawSpring(part, springOrbs.get(i-1));
        }
      } else {
        drawSpring(part, fixed);
      }
    }
    if (moving) {
      for (int h=0; h<springOrbs.size(); h++) {
        Orb part = springOrbs.get(h);
        Orb part1;
        if (h + 1 < springOrbs.size()) {
          part1 = springOrbs.get(h + 1);
        } else {
          part1 = springOrbs.get(0);
        }
        if (springConnected) {
          PVector spring = part.getSpring(part1, SPRING_LENGTH, SPRING_CONST);
          PVector g = part.getGravity(earth, GRAVITY);
          part.applyForce(spring);
          part.applyForce(g);
        } //spring force from next orb
        else {
          PVector spring = part.getSpring(fixed, SPRING_LENGTH, SPRING_CONST);
          PVector g = part.getGravity(earth, GRAVITY);
          part.applyForce(spring);
          part.applyForce(g);
        } //spring force from fixed orb in the middle
        part.run(true, DAMPENING);
      }
    }//moving
  }//spring demo

  if (friction) {
    f.display();
    fill(150);
    rect(0, height - 200, width, 200);
    fill(0, 255, 0);
    rect (200, height - 200, 200, 50);
    if (moving) {
      if (f.position.x < 190) {
        PVector push = new PVector(0.1, 0);
        f.applyForce(push);
      }//initial push of the ball
      if (f.position.x > 200 && f.position.x < 400) {
        if (abs(f.velocity.x) > 0.05) {
          float normal = GRAVITY * f.mass;
          PVector friction = f.velocity.copy();
          friction.normalize();
          friction.mult(MU * normal);
          f.applyForce(friction);
        } else {
          f.velocity.x = 0;
        }//stops ball when its super slow
      }//moving across rough surface
      f.run(true, DAMPENING);
    }//moving
  }//friction demo

  if (electric) {
    atom0.display();
    atom1.display();
    textSize(15);
    text("atom0: " + atom0.charge / (1 * pow(10, -19)) + " x 10^-19", width - 190, 5);
    text("atom1: " + atom1.charge / (1 * pow(10, -19)) + " x 10^-19", width - 190, 20);
    if (moving) {
      PVector elec0 = atom0.getElectricForce(atom1, COULOMB_CONST);
      PVector elec1 = atom1.getElectricForce(atom0, COULOMB_CONST);
      atom0.applyForce(elec1);
      atom1.applyForce(elec0);
      atom0.run(true, DAMPENING);
      atom1.run(true, DAMPENING);
    }//moving
  }//electric demo

  if (combo) {
    for (int i = 0; i < combos.length; i++) {
      Orb part;
      if (i + 1 < combos.length) {
        part = combos[i+1];
      } else {
        part = combos[0];
      }
      combos[i].display();
      drawSpring(combos[i], part);
    }
    if (moving) {
      for (int i = 0; i < combos.length; i++) {
        Orb part1;
        PVector g = combos[i].getGravity(earth, GRAVITY * 7);
        combos[i].applyForce(g);
        // gravity force on all point charges
        if (i + 1 < combos.length) {
          part1 = combos[i+1];
        } else {
          part1 = combos[0];
        }
        PVector spring = combos[i].getSpring(part1, SPRING_LENGTH, SPRING_CONST);
        combos[i].applyForce(spring);
        //spring force from one orb to the next
        for (int j = 0; j < combos.length; j++) {
          if (i != j) {
            PVector elec0 = combos[i].getElectricForce(combos[j], COULOMB_CONST);
            combos[i].applyForce(elec0);
          }
        }//nested for loop (every point charge interacts each other, not just the next orb in array)
        combos[i].run(true, DAMPENING);
      }//for loop
    }//moving
  }//combo demo
}//draw


void reset () {
  falsify();
  frame();
} //reset method


void drawSpring(Orb o0, Orb o1) {
  if (abs(o0.position.dist(o1.position)) < SPRING_LENGTH) {
    stroke(255, 0, 0); //compressed = red
  } else if (abs(o0.position.dist(o1.position)) > SPRING_LENGTH) {
    stroke(0, 255, 0); //stretched = green
  } else {
    stroke (0, 0, 255); //neither = blue
  }//spring color
  line(o0.position.x, o0.position.y, o1.position.x, o1.position.y);
  stroke(0);
}//drawSpring


void keyPressed() {
  if (key == ' ') {
    moving = !moving; //space for moving any demo
  }
  if (key == '1') {
    gravity = !gravity;
  }
  if (key == '2') {
    spring = !spring;
  }
  if (key == '3') {
    friction = !friction;
  }
  if (key == '4') {
    electric = !electric;
  }
  if (key == '5') {
    combo = !combo;
  }
  if (key == 'r') {
    reset(); //r for reset
  }
  if (key == '=') {
    springOrbs.add(new Orb(int(random(0, width)), int(random(0, height)), int(random(MIN_SIZE, MAX_SIZE)), random(MIN_MASS, MAX_MASS), 0));
  }
  if (key == '-') {
    if (springOrbs.size() > 0) {
      springOrbs.remove(0);
    }
  }
  if (key == 's') {
    springConnected = !springConnected;
  } //different spring connections for spring demo

  if (keyCode == UP) { //user manually stretching spring length with arrow keys
    //fixed.position.y-= 5;
    for (int i=0; i<springOrbs.size(); i++) {
      Orb part = springOrbs.get(i);
      part.position.y-= 5;
    }
  }
  if (keyCode == DOWN) {
    //fixed.position.y+= 5;
    for (int i=0; i<springOrbs.size(); i++) {
      Orb part = springOrbs.get(i);
      part.position.y+= 5;
    }
  }
  if (keyCode == LEFT) {
    //fixed.position.x-= 5;
    for (int i=0; i<springOrbs.size(); i++) {
      Orb part = springOrbs.get(i);
      part.position.x-= 5;
    }
  }
  if (keyCode == RIGHT) {
    //fixed.position.x+= 5;
    for (int i=0; i<springOrbs.size(); i++) {
      Orb part = springOrbs.get(i);
      part.position.x+= 5;
    }
  }
}//keyPressed


void displayMode() {
  //initial setup
  color c;
  textAlign(LEFT, TOP);
  textSize(15);
  noStroke();
  //red or green boxes
  c = moving ? color(0, 255, 0) : color(255, 0, 0); //moving
  fill(c);
  rect(0, 0, 53, 20);
  c = gravity ? color(0, 255, 0) : color(255, 0, 0); //gravity
  fill(c);
  rect(54, 0, 55, 20);
  c = spring ? color(0, 255, 0) : color(255, 0, 0); //spring
  fill(c);
  rect(110, 0, 50, 20);
  c = friction ? color(0, 255, 0) : color(255, 0, 0); //friction
  fill(c);
  rect(161, 0, 62, 20);
  c = electric ? color(0, 255, 0) : color(255, 0, 0); //electric
  fill(c);
  rect(224, 0, 63, 20);
  c = combo ? color(0, 255, 0) : color(255, 0, 0); //boolean
  fill(c);
  rect(288, 0, 50, 20);

  stroke(0);
  fill(0);
  text("MOVING", 1, 0);
  text("GRAVITY", 55, 0);
  text("SPRING", 111, 0);
  text("FRICTION", 162, 0);
  text("ELECTRIC", 225, 0);
  text("COMBO", 289, 0);
}
