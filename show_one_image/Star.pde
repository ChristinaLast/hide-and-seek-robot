class Star {
  float xPos;
  float yPos;
  float zPos;
  
  float starVelocity;
  
  float zPrevPos;
  
  Star() {
    xPos = random(-width/2, width/2);
    yPos = random(-height/2, height/2);
    zPos = random(width/2);
        
    zPrevPos = zPos;
  }
  
  void update(){
    zPos = zPos - starSpeed;
    if(zPos < 1) {
      zPos = width/2;
      xPos = random(-width/2, width/2);
      yPos = random(-height/2, height/2);
      
      zPrevPos = zPos;
    }
  }
  
  void show() {
    fill(255);
    noStroke();
    
    float starX = map(xPos / zPos, 0, 1, 0, width/2);
    float starY = map(yPos / zPos, 0, 1, 0, height/2);

    //usinf z value to increase the star size between a range from 0 to 16
    float starSmall = 0;
    float starLarge = 16;
    
    float starSize = map(zPos, 0, width/2, starLarge, starSmall);
    ellipse(starX, starY, starSize, starSize);
    
    //Creating star trail
    float xPrevPos = map(xPos / zPrevPos, 0, 1, 0, width/2);
    float yPrevPos = map(yPos / zPrevPos, 0, 1, 0, height/2);
    
    zPrevPos = zPos;

    stroke(255);
    line(xPrevPos, yPrevPos, starX, starY);
  }
}
