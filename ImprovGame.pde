Student[] kids;
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
  size(800,800,P3D);
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
    kids[i] = new Student(new float[] {random(width)-200,
                                       random(width)-200,
                                       random(width)- 1000}); 
  for(int i = 0; i < kids.length; i++)
    kids[i].setRndEF(kids);
  m.running = true;
}

void draw()
{
  float[] midPt = getStudentMedian(); 
  //camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
  //keep the action centered
  if(false)
  {
    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0),
           midPt[0],midPt[1],midPt[2], 
           0, 1, 0);
  }
  
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
      ellipse(0,0,kids[i].getSize(),kids[i].getSize());
      popMatrix();
      //draw friend/enemy connections
      {
        float[] fPos = kids[i].getFriend().getLocation();
        float[] ePos = kids[i].getEnemy().getLocation();
        stroke(0,255,0,30);
        line(loc[0], loc[1], loc[2],fPos[0],fPos[1],fPos[2]);
        stroke(255,0,0,20);
        line(loc[0], loc[1], loc[2],ePos[0],ePos[1],ePos[2]);
      } 
    }
  }
  catch(Exception e){print(e);}
}

float[] getStudentMedian()
{
  float[] loc = new float[]{0,0,0};
  for(int i = 0; i < kids.length; i++)
  {
    float[] kpos = kids[i].getLocation();
    loc[0] += kpos[0];
    loc[1] += kpos[1];
    loc[2] += kpos[2];
  }
  loc[0] /= kids.length;
  loc[1] /= kids.length;
  loc[2] /= kids.length;
  return loc;
}
