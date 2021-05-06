import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Minim Setup
Minim minim;
AudioPlayer player;
AudioBuffer buffer;
AudioInput ai;

//Variables
float lerpedAverage = 0; //Lerps the average (smoother movement)
float[] lerpedBuffer; //Lerped buffer (smoother visual)
int health = 3; //Health of the player
float timeSurvived; //Measures the time alive
float playerSpeed = 3; //Movement speed of the player
float playerY, playerX; //Position of the player
float playerSize = 20; //Size of the player

int maxRock = 100; //Maximum amount of obstacles on screen at once
float itemSizeVar = 5; //The amount that each obstacle can vary in size

//boolean start = false;
boolean dead; //Whether the player is dead

//Setup
Player player1;

ArrayList<Obstacles> obstacles = new ArrayList<Obstacles>(); //Starts the obstacles array list

void setup()
{
  //Basic Setup
  size(1024, 512); //Screen size
  colorMode(HSB); //Color mode
  playerY = height/2;
  playerX = 100; //Properly sets the player X and Y based on the adjusted screen size
  player1 = new Player(playerX, playerY, playerSize, playerSpeed); //Creates the player
  
  //Minim music Setup
  minim = new Minim(this);
  player = minim.loadFile("One Step From Eden - Cloak and Revolver Shiso's Theme.mp3", width);
  player.play();
  ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.left;
  lerpedBuffer = new float[buffer.size()];
}

void draw()
{
  //Setup visuals (backround color, line width, etc.
  background(0);
  keyPressed();
  strokeWeight(1);

  //Smooths buffer
  float sum = 0; //sumvariable that resets
  float sample = 0; //Sample variable that resets
  for (int i = 0; i < buffer.size(); i ++)
  {
    stroke(map(i, 0, buffer.size(), 0, 255), 255, 255); //sets color
    lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f); //lerp buffer (smooth image)
    sample = lerpedBuffer[i] * itemSizeVar; //new variable taking the value from the buffer 
    
    
    sum += abs(buffer.get(i)); //adds the absolute values of the buffer together
  }

  float average = sum / buffer.size(); //takes the average of the buffer
  print(average); //Prints the average (for debug purposes)
  
  
  if(average > 0.23) //If the average is high enough...
  {
    Obstacles a = new Obstacles();
    obstacles.add(a); //Create and add a new obstacle
  }
  
  //Call Player
  player1.update();
  player1.render();
  
  for(int i = 0; i < obstacles.size(); i++)
  {
    Obstacles a = obstacles.get(i);
    a.update(); //Call all the obstacles
    a.render(sample); //Draw the obstacles, using the sample variable to adjust size
    
  }
}

void keyPressed()
{
  if (keyCode == ' ') //Used for pausing/playing
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
