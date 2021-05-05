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

void setup()
{
  //Basic Setup
  size(800, 800);
  colorMode(HSB);
  
  //Minim music Setup
  minim = new Minim(this);
  player = minim.loadFile("One Step From Eden - Cloak and Revolver Shiso's Theme.mp3", width);
  player.play();
  ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.left;
  lerpedBuffer = new float[buffer.size()];
}

//Variable for setting which input you've chosen
int which = 0;

void draw()
{
  //Setup visuals (backround color, line width, etc.
  background(0);
  keyPressed();
  strokeWeight(1);

  //Sets the input based on player input for interactivity
  if (which == 0)
  {
    Mode0();
  }

  if (which == 1)
  {
    Mode1();
  }
  if (which ==2)
  {
    Mode2();
  }
  if (which == 3)
  {
    Mode3();
  }
  if (which ==4)
  {
    Mode4();
  }
  if (which ==5)
  {
    Mode5();
  }

  //Smooths buffer
  float sum = 0; //sumvariable that resets
  for (int i = 0; i < buffer.size(); i ++)
  {
    sum += abs(buffer.get(i)); //adds the absolute values of the buffer together
  }

  float average = sum / buffer.size(); //takes the average of the buffer
  lerpedAverage = lerp(lerpedAverage, average, 0.1f); //lerps the average
}

void keyPressed()
{
  // Set the value of which based on which key was pressed
  if (keyCode >= '0' && keyCode <= '5')
  {
    which = keyCode - '0';
  }
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
