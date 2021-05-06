class Player
{
  
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
    triangle(playerX, playerY + playerSize, playerX, playerY - playerSize, playerX + playerSize, playerY); //Draw the player
  }
  void update()
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
}
