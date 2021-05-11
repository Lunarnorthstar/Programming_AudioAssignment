class Obstacles
{
  float itemX;
  float itemY; //The X and Y coords of the obstacle
  
  float itemSize = 50; //The default size of the object
  
  
  float itemSpeed = 2; //The rate at which the object moves across the screen
  
  
  Obstacles()
  {
    itemX = width + itemSize * 2; //Starting position slighty off the right side of the screen
    itemY = random(itemSize, height - itemSize); //Starting Y random
  }
  
  void render(float sizeVar)
  {
    noFill();
    stroke(map(itemSize, 0, 100, 0, 255), 255, 255); //Sets the color based on the size of the obstacle
    itemSize = lerp(itemSize, itemSize + sizeVar, 0.9); //Lerps the obstacle size for a smoother effect
    
    circle(itemX, itemY, itemSize); //Draw
  }
  
  void update()
  {
    itemX -= itemSpeed; //Move left at the obstacle's speed
    
    if(itemX < 0 - itemSize)
    {
     obstacles.remove(this); //If you're off the screen, go away
    }
    checkCollision(); 
  }
  
  void checkCollision()
  {
    for(int i = 0; i < bullets.size(); i++)//For each bullet...
    {
      Bullet b = bullets.get(i); //Get the bullet to use
      
      if(dist(itemX, itemY, b.x, b.y) < itemSize/2)
      {
        bullets.remove(b);
        obstacles.remove(this); //Remove the bullet and obstacle
      }
    }
  }
  
  
  
}
