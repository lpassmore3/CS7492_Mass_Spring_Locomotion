// CS 7492 - Simulation of Biology
// Project 6 - Mass-Spring Locomotion
// Author: Austin Passmore

// A class to represent a point mass

class Point {

  private float mass;
  private float posX;
  private float posY;
  private float velX;
  private float velY;
  private float forceX;
  private float forceY;
  
  public Point(float m, float pX, float pY, float vX, float vY) {
    this.mass = m;
    this.posX = pX;
    this.posY = pY;
    this.velX = vX;
    this.velY = vY;
    this.forceX = 0;
    this.forceY = 0;
  }
  
  // Getter methods
  
  public float getMass() {
    return this.mass;
  }
  
  public float getPosX() {
    return this.posX;
  }
  
  public float getPosY() {
    return this.posY;
  }
  
  public float getVelX() {
    return this.velX;
  }
  
  public float getVelY() {
    return this.velY;
  }
  
  public float getForceX() {
    return this.forceX;
  }
  
  public float getForceY() {
    return this.forceY;
  }
  
  // Setters
  
  public void setPosX(float pX) {
    this.posX = pX;
  }
  
  public void setPosY(float pY) {
    this.posY = pY;
  }
  
  public void setVelX(float vX) {
    this.velX = vX;
  }
  
  public void setVelY(float vY) {
    this.velY = vY;
  }
  
  public void setForceX(float fX) {
    this.forceX = fX;
  }
  
  public void setForceY(float fY) {
    this.forceY = fY;
  }
  
}
