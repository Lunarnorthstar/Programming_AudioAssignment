class Obstacles
{
  //Variables
  float itemX; //-S-
  float itemY; //The X and Y coords of the obstacle -S-
  
  float itemSize = 50; //The default size of the object
  float itemSpeed = 1.7; //The rate at which the object moves across the screen
  
  boolean bonk = false; //whether the object is colliding with the player -S-
  
  
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
    
    if(bonk) //If the obstacle is touching the player (detected in checkCollision)
    {
      if(itemY >= player1.playerY) //If you're "below" the player
      {
        itemY += itemSpeed; //Move downward at the set speed in addition to left
      }
      else if(itemY <= player1.playerY) //Otherwise, if you're "above" the player
      {
        itemY -= itemSpeed; //Move upward at the set speed in addition to left.
      }
    }
    
    if(itemX < 0 - itemSize) //If you're off the left side of the screen...
    {
     obstacles.remove(this); //Go away
    }
    checkCollision(); //Check for collisions
  }
  
  void checkCollision()
  {
    for(int i = 0; i < bullets.size(); i++)//For each bullet...
    {
      Bullet b = bullets.get(i); //Get the bullet to use
      
      if(dist(itemX, itemY, b.x, b.y) < itemSize/2) //If you're close enough to touch...
      {
        score += 100; //Increment the score
        bullets.remove(b);
        obstacles.remove(this); //Remove the bullet and obstacle
      }
    }
    
    if(dist(itemX, itemY, player1.playerX, player1.playerY) < player1.playerSize + itemSize/2) //If the obstacle is close enough to touch the player...
    {
      bonk = true; //Set the tracking boolean to true
    }else //otherwise...
    {
      bonk = false; //Set it to false.
    }
  }
  
  
  
}
