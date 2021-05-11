class Player
{
  //Variables
  float playerX; //-S-
  float playerY; //-S-
  float playerSize; //-S-
  float playerSpeed; //-S-

  Player(float X, float Y, float size, float speed)
  {
    playerX = X;
    playerY = Y;
    playerSize = size;
    playerSpeed = speed; //Cast the player paramaters
  }

  void render()
  {
    if (timePass >= fireRate) //If the player is able to shoot
    {
      fill(255); //Fill them in
    } else //If the player can't shoot...
    {
      noFill(); //Don't fill them in
    }
    stroke(255); //The player should always have a static color
    triangle(playerX, playerY + playerSize, playerX, playerY - playerSize, playerX + playerSize, playerY); //Draw the player
  }

  void update()
  {
    timePass += 1 / 60.0f; //Advance time by 1 frame
    move();
    shoot();
  }

  void move()
  {
    if (checkKey(UP) && playerY > playerSize)
    {
      playerY -= playerSpeed;
    } //If the up arrow is held down, move up.
    if (checkKey(DOWN) && playerY < height - playerSize)
    {
      playerY += playerSpeed;
    } //Same here, with down instead
    if (checkKey(RIGHT) && playerX < width - playerSize)
    {
      playerX += playerSpeed;
    } //Same with right
    if (checkKey(LEFT) && playerX > playerSize/4)
    {
      playerX -= playerSpeed;
    } //And with left
  }

  //Shoot Variables
  float fireRate = 0.3;
  float timePass; //-S-

  void shoot()
  {

    if (checkKey(' ') && timePass >= fireRate) //If you're pressing shoot and you can shoot...
    {
      float x, y;
      x = playerX + playerSize;
      y = playerY; //Positions of the bullet
      Bullet b = new Bullet(x, y); //Make a new bullet
      bullets.add(b);
      timePass = 0; //Reset the cooldown
    }
  }
}
