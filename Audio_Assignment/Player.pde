class Player
{
   float health = 10;
   float playerX;
   float playerY;
   float playerSize;
   float playerSpeed; //Player paramaters
  
  Player(float X, float Y, float size, float speed)
  {
    playerX = X;
    playerY = Y;
    playerSize = size;
    playerSpeed = speed; //Cast the player paramaters
  }
  
  void render()
  {
    if(timePass >= fireRate)
    {
    fill(255);
    }
    else
    {
      noFill();
    }
    stroke(255);
    triangle(playerX, playerY + playerSize, playerX, playerY - playerSize, playerX + playerSize, playerY); //Draw the player
  }
  void update()
  {
   timePass += 1 / 60.0f;
   move();
   shoot();
  }
  void move()
  {
     if (keyPressed) //Player controls
  {
    if (keyCode == UP && playerY > playerSize)
    {
      playerY -= playerSpeed;
    }
    if (keyCode == DOWN && playerY < height - playerSize)
    {
      playerY += playerSpeed;
    }
    if (keyCode == RIGHT && playerX < width - playerSize)
    {
      playerX += playerSpeed;
    }
    if (keyCode == LEFT && playerX > playerSize/4)
    {
      playerX -= playerSpeed;
    }
  }
  }
  
  //Shoot Variables
  float fireRate = 0.6;
  float timePass;
  
  void shoot()
  {
     if (keyPressed) //Shoot controls
  {
    if(key == ' ' && timePass >= fireRate)
    {
      float x, y;
      x = playerX + playerSize;
      y = playerY;
      Bullet b = new Bullet(x, y);
      bullets.add(b);
      timePass = 0;
    }
    
  }
  }
}
