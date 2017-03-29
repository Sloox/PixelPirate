//main class here, main drawing calls must be performed from here!

import ketai.ui.*;
import ketai.sensors.*;
KetaiSensor sensor;
import android.media.MediaPlayer; 
import android.view.MotionEvent;

float accelerometerX, accelerometerY, accelerometerZ;
color backgroundcolor = color(0, 0, 0);
int State = 0;
UI pUI;


//CONSTANTS
final int SWIPERIGHT = 1;
final int SWIPELEFT = 2;
final int SWIPEUP = 3;
final int SWIPEDOWN = 4;

//Gestures
KetaiGesture gesture;
boolean MenuGestures = true;//flag to know when to handle gestures at menu


//Personal Classes
Ocean theOcean;
PlayerShip pShip;
AIShip enemyShip;
Clouds[] theClouds;
int NumClouds;
Ray test;

//Accelerometer
int SmoothnessCNT = 0;
final int SMOOTHNESSFACTOR = 1;//used to smooth out movements
float accelX;

void setup()
{
  //instantiationg
  pUI = new UI(this,width,height);
  theOcean = new Ocean(width,(height/10)+5,width,height);
  pShip = new PlayerShip(width/3+10,height/10,width,height,100,70);
  enemyShip = new AIShip(width/3+10,height/10,width,height,80,50);
  test = new Ray(width,height);
  test.startRays(0.05);
  //clouds
  NumClouds = randInt(3,10);
  theClouds = new Clouds[NumClouds];
  for(int i = 0;i<NumClouds;++i){
     theClouds[i] = new Clouds(width,height/4);
  }
  
  //sensors
  gesture = new KetaiGesture(this);//gesture event handler
  sensor = new KetaiSensor(this);//start sensors handler
  sensor.start();
  
  orientation(LANDSCAPE);//landscape only
  
  textSize(28);//size
  textAlign(CENTER);
 
}


void draw()
{
  background(backgroundcolor);
  doState(State);
}





void doState(int state){//simple state machine
  switch(state){
     case 0://start up first time!
       performGameDraw();//update background
       pUI.startScreenStatic();
      break;
     case 1://user has swiped right i.e. Text is moving to left and new text to from right & name goes up
        performGameDraw();//update background
       if(pUI.moveforoptions()){
          State = 2;
       }
      
      break;
     case 2://in options menu now
        performGameDraw();//updatebackground
        pUI.optionsStatic();
        
       break;
     case 3://wants to move to main screen
       performGameDraw();//update background
       if(pUI.moveforstartscreen()){
          State = 0;
       }
       
       break;
     default:
      State = 0;
  }
} 
  
  
//Event Managers
void onAccelerometerEvent(float x, float y, float z)//event handler
{
  SmoothnessCNT++;
  if(SmoothnessCNT==SMOOTHNESSFACTOR){
    SmoothnessCNT = 0;
   if(pShip!=null){
     accelX += y;
     accelX = clamp(accelX,-10,10);
    
   }
  }
  
}

void onFlick( float x, float y, float px, float py, float v)
{
  if(MenuGestures)
    interpretFlick(x,y,px,py,v,State);
}

//catch events handle then forward back to android
public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}

//Sensor Utils
  
void interpretFlick(float x, float y, float px, float py, float v, int CurState){
  float angle = atan2(x-px, y-py)* 180 / PI;
  int SwipeDirection = SwipeDir(angle);
  
  if(CurState == 0){//user at home screen
    if(SwipeDirection==SWIPERIGHT){
       State = 1;//user wants to move to options
    }
  }else if(CurState==2){//in options
  if(SwipeDirection==SWIPELEFT){
       State = 3;//user wants to move to Main screen
    }
    
  }
}
  
  //Swipe direction interpretation
int SwipeDir(float angle){
  if(angle<125&&angle>80){//swipe right
      return SWIPERIGHT;
    }else if((angle>125&&angle<180)||(angle>-180&&angle<-125)){//angles suck ey?
      return SWIPEUP;
    }else if(angle>-125&&angle<-80){
      return SWIPELEFT;
    }else{
      return SWIPEDOWN;
    }
}
//UTILS
public float clamp(float x, float minVal, float maxVal){
    return min(max(x,minVal),maxVal);
  }
  
//Drawing Calls
public void performGameDraw(){
  //start at furthest back part of the screen and draw
  pUI.drawStars();//1st
  
  for(int i = 0;i<NumClouds;++i){
     theClouds[i].drawCloud();
  }
  theOcean.drawOcean(0);//first pass
  //player Ship
  enemyShip.drawShip(theOcean.getOceansHeightYfrombottom(1),1.0);
  pShip.drawShip(theOcean.getOceanHeight(),accelX);
  
  if(!(test.drawRay(pShip)))
    if(testRandomChance(1.0))
      test.startRays(0.03);
 
  
  theOcean.drawOcean(1);//second pass
  pShip.AddMotion((int)(accelX),0);
}


//helper
private int randInt(int min, int max) {
    // NOTE: Usually this should be a field rather than a method
    // variable so that it is not re-seeded every call.
    Random rand = new Random();
    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
}

private boolean testRandomChance(float chancepercent){
  float chance = random(100);
  if(chance<chancepercent){
    return true;
  }
  return false;
  
  
}

/*STATES CURRENTLY
0->HomeScreen
1->Moving to options
2->At options
3->Moving from options to HomeScreen
*/
  


