Student[] kids;
int scrSize = 350;
MoveThread m;
boolean started = false;

class MoveThread extends Thread
{  
  public boolean running = false;
  public void run()
  {
    running = true;
     while (true)
     {
       if(started)
       {
         running = true;
         for(int i = 0; i < kids.length && !isInterrupted(); i++)
           if(started)
             kids[i].setMove();
         for(int i = 0; i < kids.length; i++)
           kids[i].move();
//         print("mv runnin millis: " + millis());
       } 
       else
       {
         println("mv not runnin millis: " + millis());
         running = false;
       }
     }
  }
}


void setup()
{
  m = new MoveThread();
  size(scrSize*2,scrSize,P3D);
  int numberOfStudents = 3000;
  kids = new Student[numberOfStudents];
  reset();
  m.start();
}

void reset()
{
  started = false;
  //loop until they're done
  while(m.running);
  background(0);
  int maxSz = 100;
  for(int i = 0; i < kids.length; i++)
    kids[i] = new Student(new float[] {random(scrSize)-200,
                                       random(scrSize)-200,
                                       random(scrSize)- 1000}); 
  for(int i = 0; i < kids.length; i++)
    kids[i].setRndEF(kids);
  m.running = true;
}

void draw()
{
  background(0);
  if(mousePressed)
    reset();
  try
  {
    if(!started)
    {
      started = true;
//      m.start();
    }
    float[] loc;
    for(int i = 0; i < kids.length; i++)
    {
      loc = kids[i].getLocation();
      pushMatrix();
      translate(loc[0], loc[1], loc[2]);
      fill(color(kids[i].getColor()[0],
                 kids[i].getColor()[1],
                 kids[i].getColor()[2]), 255);
      noStroke();    
      ellipse(loc[0],loc[1],kids[i].getSize(),kids[i].getSize());
      popMatrix();
    }
  }
  catch(Exception e){print(e);}
}

