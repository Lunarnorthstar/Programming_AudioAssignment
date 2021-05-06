class Bullet
{
  float size = 10;
  float speed = 5;

  float x, y;
  float rotation;
  float life = 5;

  Bullet(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  void render()
  {
    pushMatrix();
    translate(x, y);
    //line drawing up and down from the middle
    line(- size / 2, 0, + size / 2, 0);
    popMatrix();
  }
  void move()
  {
    x += speed;
    //checks if it leaves the screen
     if(x > width || y > height || x < 0 || y < 0)
     {
     //removes the offending bullet from the array
     bullets.remove(this);
     }


     /* life -= 1/ 60.0f;
    if (life <= 0)
    {
      bullets.remove(this);
    }*/

  }
}
