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
int health = 3;
float timeSurvived;
float playerSpeed = 3;
float playerY, playerX;
float playerSize = 20;
int maxRock = 15;
float[] rockSpeed = new float [maxRock];
float[] rockSize = new float [maxRock];
float[] rockX = new float [maxRock];
float[] rockY = new float [maxRock];
boolean start = false;
boolean dead;

//Player Setup
Player player1;

void setup()
{
  //Basic Setup
  size(1024, 512);
  colorMode(HSB);
  playerY = height/2;
  playerX = 100;
  player1 = new Player(playerX, playerY, playerSize, playerSpeed);
  
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
  for (int i = 0; i < buffer.size(); i ++)
  {
    sum += abs(buffer.get(i)); //adds the absolute values of the buffer together
  }

  float average = sum / buffer.size(); //takes the average of the buffer
  lerpedAverage = lerp(lerpedAverage, average, 0.1f); //lerps the average
  
  //Call Player
  player1.update();
  player1.render();
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

void Mode0()
{
 for (int i = 0; i < buffer.size(); i ++)
  {
    stroke(map(i, 0, buffer.size(), 0, 255), 255, 255); //sets color
    lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f); //lerp buffer (smooth image)
    float sample = lerpedBuffer[i] * width * 2; //new variable taking the value from the buffer 
    line(i, height / 2 - sample, i, height/2 + sample); //Draws the line based on the value of sample
  }
}
<<<<<<< Updated upstream

void Mode1()
{
  
}

void Mode2()
{

  
}

void Mode3()
{


}


void Mode4()
{

  
}
void Mode5()
{

  
}
=======
>>>>>>> Stashed changes
