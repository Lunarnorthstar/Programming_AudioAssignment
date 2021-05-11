class Bullet
{
  //Variables
  float size = 10;
  float speed = 5;

  float x, y;// -S-
  float rotation; //-S-

  Bullet(float x, float y)
  {
    this.x = x;
    this.y = y; //Paste the paramaters into this class
  }
  void render()
  {
    pushMatrix();
    translate(x, y);
    //line drawing up and down from the middle
    line(- size / 2, 0, + size / 2, 0);
    popMatrix(); //Draw the bullets at their positions
  }

  void move()
  {
    x += speed; //Move the bullet forward
    //checks if it leaves the screen
    if (x > width || y > height || x < 0 || y < 0)
    {
      //removes the offending bullet from the array
      bullets.remove(this);
    }
  }
}
