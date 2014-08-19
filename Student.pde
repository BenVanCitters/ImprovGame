class Student
{
  private float sz = 5.0; // size to draw each
  private int count; // total number of students
  private float fDist = 15.0;
  private float mDist = .2;
  private Student enemy;
  private Student friend;
  private float[] dest;// identifies the intended destination vector of student
  private float[] location;  // current location vector of student
  private float[] move; // iterative displacement vector
  private char[] c; //color vector
  
  public Student(float[] location)
  {
    this.c = new char[] {(char)random(255),(char)random(255),(char)random(255)};    
    this.location = location;
    this.friend = null;
    this.enemy = null;
  }

  public void setRndEF(Student[] s)
  {
    int r = (int)random(s.length);
    this.friend = s[r];
    int t = (int)random(s.length);
    while(t == r) //friend and enemy can't be the same
      t = (int)random(s.length);
    this.enemy = s[t];
  }
  public float[] setMove()
  {
    
    if(this.friend == null || this.enemy == null)
      return null;
      //throw new Exception("friend or enemy not set");
    float[] F = this.friend.getLocation();
    float[] E = this.enemy.getLocation();
    float[] EF = new float[this.location.length];
    float denom = 0.0;
    for(int i = 0; i < EF.length; i++)
    {
      EF[i] = F[i] - E[i];
      denom += EF[i]*EF[i];
    }
    denom = sqrt(denom);
    float[] I = new float[this.location.length];
    if(denom == 0) //error! friend & enemy are in same place
      return new float[] {324.0,0};
    for(int i = 0; i < I.length; i++)
      I[i] = E[i] + EF[i] +EF[i] * fDist/denom;
    
    float[] SI = new float[this.location.length];
    denom = 0.0;
    for(int i = 0; i < SI.length; i++)
    {
      SI[i] = I[i] - this.location[i]; 
      denom += SI[i]*SI[i];
    }
    
    denom = sqrt(denom);
    if(denom == 0) //error! student & destination are in same place
      return new float[] {323.0};
    float[] N = new float[this.location.length];
    for(int i = 0; i < N.length; i++)
      N[i] = this.location[i] + SI[i] * this.mDist/denom;
    this.move = N;
    return N;
  }
  
  //moves the student to it's new location
  // in order for many students to work well
  // together setMove must be called with all
  // students before 'move' gets called on 
  // any of them.
  public float[] move()
  {
    this.location = this.move;
    return this.location;
  }
  public float[] getDelta()
  {
    return move;
  }
 
  public void setLocation(float[] location){this.location = location;}
  public float getCount(){return this.count;}
  public float getSize(){return this.sz;}
  public float[] getDest(){return this.dest;}
  public float[] getMove(){return this.move;}

  public float[] getLocation(){return this.location;}
  public char[] getColor(){return this.c;}
  public Student getFriend(){return this.friend;}
  public Student getEnemy(){return this.enemy;}
}
