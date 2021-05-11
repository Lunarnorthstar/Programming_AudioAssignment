import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*; //Imports

//Minim Setup
Minim minim;
AudioPlayer player;
AudioBuffer buffer;
AudioInput ai;

//Variables; -S- Denotes a "set" variable, don't change the value.
float lerpedAverage = 0; //Lerps the average (smoother movement) -S-
float[] lerpedBuffer; //Lerped buffer (smoother visual) -S-
float playerSpeed = 3; //Movement speed of the player
float playerY, playerX; //Position of the player -S-
float playerSize = 20; //Size of the player
int score = 0; //The player's score -S-

int maxRock = 100; //Maximum amount of obstacles on screen at once
float itemSizeVar = 4; //The amount that each obstacle can vary in size

//Setup
Player player1; //Make the player
PImage img; //Initialize the background image

ArrayList<Obstacles> obstacles = new ArrayList<Obstacles>(); //Starts the obstacles array list
ArrayList<Bullet> bullets = new ArrayList<Bullet>();  //Starts the bullet array list

boolean[] keys = new boolean[526]; //Input array

void setup()
{
  //Basic Setup
  size(1024, 512); //Screen size
  colorMode(HSB); //Color mode
  playerY = height/2;
  playerX = 100; //Properly sets the player X and Y based on the adjusted screen size
  player1 = new Player(playerX, playerY, playerSize, playerSpeed); //Creates the player w/ paramaters

  //Minim music Setup
  minim = new Minim(this);
  player = minim.loadFile("One Step From Eden - Cloak and Revolver Shiso's Theme.mp3", width);
  player.play(); //Start playing
  ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.mix; //Get both channels of audio
  lerpedBuffer = new float[buffer.size()];
  
  //Misc Setup
  img = loadImage("Audio_Background.png"); //Load the image
}


boolean checkKey(int k)
{
  if (keys.length >= k)
  {
    return keys[k] || keys[Character.toUpperCase(k)];
  }
  return false;
} //Checks for inputs


void draw()
{
  //Setup visuals (backround color, line width, etc.
  image(img, 0, 0);
  //background(0);
  strokeWeight(1);
  
  text("Score: ", 10, 20);
  text(score, 50, 20); //Print the score

  float sum = 0; //sumvariable that resets
  float sample = 0; //Sample variable that resets
  for (int i = 0; i < buffer.size(); i ++)
  {
    lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f); //lerp buffer (smooth image)
    sample = lerpedBuffer[i] * itemSizeVar; //new variable taking the value from the buffer. This is used to adjust the size of the obstacles later.


    sum += abs(buffer.get(i)); //adds the absolute values of the buffer together
  }

  float average = sum / buffer.size(); //takes the average of the buffer
  print(average); //Prints the average (for debug purposes)


  if (average > 0.23) //If the average is high enough...
  {
    Obstacles a = new Obstacles();
    obstacles.add(a); //Create and add a new obstacle
  }

  //Call Player functions
  player1.update();
  player1.render();

  for (int i = 0; i < obstacles.size(); i++)
  {
    Obstacles a = obstacles.get(i);
    a.update(); //Call all the obstacles
    a.render(sample); //Draw the obstacles, using the sample variable to adjust size
  }
  //Call Bullets
  for (int i = 0; i < bullets.size(); i++)
  {
    Bullet b = bullets.get(i);
    b.render();
    b.move(); //Same format as the obstacles calls
  }
}


void keyPressed()
{
  keys[keyCode] = true; //For the checkKey function
  if (keyCode == 'P') //Used for pausing/playing
  {
    if (player.isPlaying()) //if you press the key and it is playing, pause
    {
      player.pause();
    } else //if it isnt playing, restart and play
    {
      player.rewind();
      player.play();
    }
  }
}


void keyReleased()
{
  keys[keyCode] = false; //For the checkKeyfunction
}
