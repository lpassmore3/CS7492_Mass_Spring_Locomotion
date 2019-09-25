// CS 7492 - Simulation of Biology
// Project 6 - Mass-Spring Locomotion
// Author: Austin Passmore

// A class to represent a spring between two points

class Spring {

  private Point point1;
  private Point point2;
  
  private float restLengthX;
  private float restLengthY;
  
  private float springConstant = 0.02;
  
  private float maxRestLengthX;
  private float maxRestLengthY;
  private float minRestLengthX;
  private float minRestLengthY;
  private float contractFactor = 1;
  
  private float frequency = 10;
  private float amplitude = 25;
  private float phase;
  
  public Spring(Point p1, Point p2) {
    this.point1 = p1;
    this.point2 = p2;
    
    float xDiff = p2.getPosX() - p1.getPosX();
    this.restLengthX = abs(xDiff);
    float yDiff = p2.getPosY() - p1.getPosY();
    this.restLengthY = abs(yDiff);
    
    this.maxRestLengthX = xDiff;
    this.maxRestLengthY = yDiff;
    this.minRestLengthX = xDiff * contractFactor;
    this.minRestLengthY = yDiff * contractFactor;
    
    this.phase = 0;
  }
  
  // Getters
  public Point getPoint1() {
    return this.point1;
  }
  
  public Point getPoint2() {
    return this.point2;
  }
  
  public float getRestLengthX() {
    return this.restLengthX;
  }
  
  public float getRestLengthY() {
    return this.restLengthY;
  }
  
  public float getSpringConstant() {
    return this.springConstant;
  }
  
  public float getMaxRestLengthX() {
    return this.maxRestLengthX;
  }
  
  public float getMaxRestLengthY() {
    return this.maxRestLengthY;
  }
  
  public float getMinRestLengthX() {
    return this.minRestLengthX;
  }
  
  public float getMinRestLengthY() {
    return this.minRestLengthY;
  }
  
  public float getPhase() {
    return this.phase;
  }
  
  public float getAmplitude() {
    return this.amplitude;
  }
  
  public float getFrequency() {
    return this.frequency;
  }
  
  // Setters
  public void setRestLengthX(float xDiff) {
    this.restLengthX = xDiff;
  }
  
  public void setRestLengthY(float yDiff) {
    this.restLengthY = yDiff;
  }
  
  public void incrementPhase() {
    this.phase = this.phase + 1;
  }
  
  
}
