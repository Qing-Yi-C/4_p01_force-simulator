class Orb {

  PVector position;
  PVector velocity;
  PVector acceleration;
  int size;
  float mass;
  float charge;
  color c;

  Orb(int x, int y, int s, float m, float q) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    charge = q;
    c = color(random(256), random(256), random(256));
  }//constructor

  void run(boolean bounce, float damp) {
    position.add(velocity);
    velocity.add(acceleration);
    velocity.mult(damp);
    acceleration.mult(0);

    if (bounce) {
      yBounce();
      xBounce();
    }
  }//run

  PVector getGravity(Orb o, float G) {
    if (o != this) {
      float d = this.position.dist(o.position);
      d = constrain(d, 5, 100);
      float mag = (G * mass * o.mass) / (d * d);
      PVector direction = PVector.sub(o.position, this.position);
      direction.normalize();
      direction.mult(mag);
      return direction;
    }
    return new PVector(0, 0);
  }//getGravity

  float getDensity() {
    return mass/size;
  }//getDensity

  void applyForce(PVector f) {
    PVector newf = f.copy();
    newf.div( mass );
    acceleration.add(newf);
  }//applyForce

  void yBounce() {
    if (position.y < size/2) {
      position.y = size/2;
      velocity.y *= -1;
    } else if (position.y >= (height-size/2)) {
      position.y = height - size/2;
      velocity.y *= -1;
    }
  }//yBounce

  void xBounce() {
    if (position.x < size/2) {
      position.x = size/2;
      velocity.x *= -1;
    } else if (position.x >= width - size/2) {
      position.x = width - size/2;
      velocity.x *= -1;
    }
  }//xBounce

  boolean checkYBoundry() {
    boolean check = position.y >= height - size/2;
    check = check || (position.y <= size/2);
    return check;
  }
  boolean checkXBoundry() {
    boolean check = position.x >= width - size/2;
    check = check || (position.x <= size/2);
    return check;
  }

  void display() {
    int t = int(map(getDensity(), MIN_MASS/MAX_SIZE, MAX_MASS/MIN_SIZE, 100, 255));
    fill(c, t);
    circle(position.x, position.y, size);
    if (electric || combo) {
      textSize(35);
      stroke(0);
      fill(0);
      if (charge > 0) {
        text("+", position.x-size/3.3, position.y-size/1.2);
      } else if (charge < 0) {
        text("-", position.x-size/3.3, position.y-size/1.2);
      } else if (charge == 0) {
        text("n", position.x-size/3.3, position.y-size/1.2);
      }
    }
  }//display

  PVector getSpring(Orb o, int springLength, float springConstant) {
    PVector dir = PVector.sub(o.position, this.position);
    float L = dir.mag();
    float x = springLength - L;

    dir.normalize();
    dir.mult(-1 * springConstant * x);
    return dir;
  }

  PVector getElectricForce(Orb o, float k) {
    PVector dist = PVector.sub(o.position, this.position);
    float r = dist.mag();
    r = constrain(r, 10, 850);
    float q1 = this.charge;
    float q2 = o.charge;

    dist.normalize();
    dist.mult(k*q1*q2*pow(10, 31));
    dist.div(sq(r));
    return dist;
  }//getElectricForce
}//OrbNode
