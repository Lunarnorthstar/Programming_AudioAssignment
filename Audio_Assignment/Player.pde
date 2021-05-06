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
    fill(255);
    stroke(255);
    triangle(playerX, playerY + playerSize, playerX, playerY - playerSize, playerX + playerSize, playerY); //Draw the player
  }
  void update()
  {
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
  int fireRate = 5;
  float timePass;
  float toPass = 1/ (float) fireRate;
  
  void shoot()
  {
     if (keyPressed) //Shoot controls
  {
    if(key == ' ' && timePass >= toPass)
    {
      float x, y;
      x = playerX + playerSize;
      y = playerY;
      Bullet b = new Bullet(x, y);
      bullets.add(b);
      timePass = 0;
    }
    timePass += 1 / 60.0f;
  }
  }
}
