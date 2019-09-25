// CS 7492 - Simulation of Biology
// Project 6 - Mass-Spring Locomotion
// Author: Austin Passmore

// TODO: Clean up code, especially old Spring code

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Spring> springs = new ArrayList<Spring>();

float pointSize = 10;
int frameRateValue = 90;

float viscousConstant = 0.005;

boolean isSimulating = false;  // Controls if the simulation is paused or not
boolean isSingleStep = false;  // Controls whether the simulation advances only a single step

float tick = 0;

void setup() {
  size(1300, 800);
  background(255, 255, 255);
  noStroke();
  frameRate(frameRateValue);
  
  // TEST ADDING POINTS
  //for (int n = 0; n < 10; n++) {
  //  float posX = random(500);
  //  float posY = random(800);
  //  float velX = random(10);
  //  float velY = random(20) - 10;
    
  //  Point p = new Point(1.0, posX, posY, velX, velY);
  //  points.add(p);
  //}
  
  // TEST A SPRING TRIANGLE
  Point p1 = new Point(1.0, 500, 300, 0, 0);
  points.add(p1);
  Point p2 = new Point(1.0, 700, 300, 0, 0);
  points.add(p2);
  Point p3 = new Point(1.0, 600, 100, 0, 0);
  points.add(p3);
  Point p4 = new Point(1.0, 800, 250, 0, 0);
  points.add(p4);
  Point p5 = new Point(1.0, 725, 350, 0, 0);
  points.add(p5);
  Point p6 = new Point(1.0, 850, 325, 0, 0);
  points.add(p6);
  
  Spring spring1 = new Spring(p1, p2);
  springs.add(spring1);
  Spring spring2 = new Spring(p2, p3);
  springs.add(spring2);
  Spring spring3 = new Spring(p3, p1);
  springs.add(spring3);
  Spring spring4 = new Spring(p4, p3);
  springs.add(spring4);
  Spring spring5 = new Spring(p4, p2);
  springs.add(spring5);
  Spring spring6 = new Spring(p5, p2);
  springs.add(spring6);
  Spring spring7 = new Spring(p5, p4);
  springs.add(spring7);
  Spring spring8 = new Spring(p5, p6);
  springs.add(spring8);
  Spring spring9 = new Spring(p6, p4);
  springs.add(spring9);
  //p1.setPosX(480);
  //p2.setPosX(720);
  
  drawSprings();
  drawPoints();

}

void draw() {
  clear();
  background(255, 255, 255);
  if (isSimulating) {
    contract();
    updateVelocityVerlet();
    tick = tick + 1;
  } else if (isSingleStep) {
    contract();
    updateVelocityVerlet();
    isSingleStep = false;
    tick = tick + 1;
  }
  drawSprings();
  drawPoints();
}

void keyPressed() {
  if (key == ' ') {     // Toggle pauseing of simulation
    if (isSimulating) {
      isSimulating = false;
      println("Resuming simulation.");
    } else {
      isSimulating = true;
      println("Simulation paused.");
    }
  } else if (key == 's') {    // Move forward one frame
    isSimulating = false;
    isSingleStep = true;
    println("Advanced one frame forward");
  }
}

// Draws each point to the screen
void drawPoints() {
  noStroke();
  fill(0, 0, 0);
  for (Point p : points) {
    float x = p.getPosX();
    float y = p.getPosY();
    ellipse(x, y, pointSize, pointSize);
  }
}

// Draws each spring to the screen
void drawSprings() {
  strokeWeight(2);
  stroke(255, 0, 0);
  for (Spring s : springs) {
    Point p1 = s.getPoint1();
    Point p2 = s.getPoint2();
    
    float x1 = p1.getPosX();
    float y1 = p1.getPosY();
    float x2 = p2.getPosX();
    float y2 = p2.getPosY();
    
    line(x1, y1, x2, y2);
  }
}

// Update the position of all points using the Velocity Verlet method
void updateVelocityVerlet() {
  calculateForces();
  updateVelocitiesHalf();
  updatePositions();
  calculateForces();
  updateVelocitiesHalf();
}

// Calculates the forces for all points
void calculateForces() {
  
  for (Point p : points) {
    
    // Viscous Damping force
    float viscousX = -1 * viscousConstant * p.getVelX();
    float viscousY = -1 * viscousConstant * p.getVelY();
    
    // Gravitational force
    float gravY = 9.8 / frameRateValue;
    //float gravY = 0;
    
    float forceX = viscousX;
    float forceY = viscousY + gravY;
    p.setForceX(forceX);
    p.setForceY(forceY);
  }
  
  // Update forces based on all springs
  for (Spring s : springs) {
    Point p1 = s.getPoint1();
    Point p2 = s.getPoint2();

    float xDiff = abs(p2.getPosX() - p1.getPosX()) - s.getRestLengthX();
    float springForceX = -1 * s.getSpringConstant() * xDiff;
    if (p2.getPosX() > p1.getPosX()) {
      p2.setForceX(p2.getForceX() + springForceX);
      p1.setForceX(p1.getForceX() + (-1 * springForceX));
    } else {
      p1.setForceX(p1.getForceX() + springForceX);
      p2.setForceX(p2.getForceX() + (-1 * springForceX));
    }
    
    float yDiff = abs(p2.getPosY() - p1.getPosY()) - s.getRestLengthY();
    float springForceY = -1 * s.getSpringConstant() * yDiff;
    if (p2.getPosY() > p1.getPosY()) {
      p2.setForceY(p2.getForceY() + springForceY);
      p1.setForceY(p1.getForceY() + (-1 * springForceY));
    } else {
      p1.setForceY(p1.getForceY() + springForceY);
      p2.setForceY(p2.getForceY() + (-1 * springForceY));
    }
  }
  
}

// Updates the velocities of each point for half a timestep
void updateVelocitiesHalf() {
  for (Point p : points) {
    float m = p.getMass();
    float vX = p.getVelX();
    float vY = p.getVelY();
    float aX = p.getForceX() / m;
    float aY = p.getForceY() / m;
    
    p.setVelX(vX + (0.5 * aX));
    p.setVelY(vY + (0.5 * aY));
  }
}

// Updates the positions of each point for one timestep
void updatePositions() {
  float floor = 800 - (pointSize / 2);
  for (Point p : points) {
    float pX = p.getPosX();
    float pY = p.getPosY();
    float vX = p.getVelX();
    float vY = p.getVelY();
    
    // Keep points from falling through the floor
    float newPosY = pY + vY;
    if (newPosY >= floor) {
      newPosY = floor - (newPosY - floor);
      p.setVelY(newPosY - floor);
      //p.setVelY(vY * -1);
      //newPosY = pY + p.getVelY();
    }
    
    p.setPosX(pX + vX);
    p.setPosY(newPosY);
  }
  
}

// Updates the rest lengths of springs
void contract() {
  for (Spring s : springs) {
    float amplitude = s.getAmplitude();
    float phase = s.getPhase();
    float frequency = s.getFrequency();
    //float maxRestX = s.getMaxRestLengthX();
    //float maxRestY = s.getMaxRestLengthX();
    //float minRestX = s.getMinRestLengthX();
    //float minRestY = s.getMinRestLengthY();
        
    //float restLengthX = ((maxRestX - minRestX) * ((cos(phase * TWO_PI / frameRateValue) + 1) / 2)) + minRestX;
    //float restLengthY = ((maxRestY - minRestY) * ((cos(phase * TWO_PI / frameRateValue) + 1) / 2)) + minRestY;
    
    //println(tick);
    
    float diff = amplitude * sin(frequency * tick + phase);
    
    println(diff);
    
    s.setRestLengthX(s.getRestLengthX() + diff);
    s.setRestLengthY(s.getRestLengthY() + diff);
    //s.incrementPhase();
  }
}
