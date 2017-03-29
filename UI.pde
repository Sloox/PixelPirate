//UI stuff

import android.media.*;
import android.content.res.*;

class UI{
  
  processing.core.PApplet theSketch;
  private boolean intro = false;
  private SoundH Shandler;
  
  private int xWidth, yHeight;
  
  
  //name flashing
  private int labelXred = 200;
  private boolean lxredOscilate = false;
  
  
  //intro & Text values for movement
  private int introX, introY;
  private int OptionsX, OptionsY;
  private int NameX,NameY;
  
  private boolean drawIntro, drawOptions, drawName;
  private boolean finishedMoving;
  
  
  //global CONST VARS
  private final int NAMEYMIN = 100;
  private int NameYMAX;
  private final int INTROXMIN = -350;
  private int IntroXMAX;
  //global vars (cant be const due to variable screen dims)
  private int OptionsMAX; 
  private int OptionsMINX;
  
  //MOVEMENT speeds
  private final int DELTASLOWX = 2;
  private final int DELTASLOWY = 2;
  
  private final int DELTAMIDX = 10;
  private final int DELTAMIDY = 10;
  
  private final int DELTAFASTX = 20;
  private final int DELTAFASTY = 20;
  private ArrayList<Stars> theStars;
  private boolean dostars;
  private final int STARCNT = 30;
  
public UI(PApplet tSketch,int _screenWidth, int _screenHeight ){
     theSketch = tSketch;
     Shandler = new SoundH(theSketch);
     theStars = new ArrayList<Stars>();
     
     for(int i = 0;i<STARCNT;++i){
       theStars.add(new Stars(width, height-(height/3)));
     }
     dostars = true;
     
     NameX = _screenWidth/2;
     NameY =int(_screenHeight/3);
     NameYMAX = NameY;
     //
     introX = _screenWidth/2;
     introY = _screenHeight/2;
     IntroXMAX = _screenWidth/2;
     
     //
     OptionsX = _screenWidth+200;
     OptionsY = int(_screenHeight/2.5);
     OptionsMAX = OptionsX;
     OptionsMINX = _screenWidth/2;
     
     xWidth = _screenWidth;
     yHeight = _screenHeight;
     
    
     
     drawIntro = true;
     drawName = true;
     drawOptions = false;
     
     finishedMoving = true;
}
   
//////////////////////////////////////////////START SCREEN//////////////////////////////////////////////////
 public void startScreenStatic(){
  //textFont(createFont("SanSerif", 32));
  //textAlign(CENTER);
  drawText();
  fill(0,0,0);
  if(!intro){
    Shandler.startIntroSong();
    intro = true;
  } 
 }
 
//////////////////////////////////////////////START SCREEN MOVE//////////////////////////////////////////////////
public boolean moveforoptions(){
  //moves logo up, options come in from rhs and intro goes left
  //move intro left until limit hit
  
  finishedMoving = true;//used for exiting this process!
  
  if(introX<INTROXMIN){//move intro fast left
    drawIntro = false;
  }else{
    finishedMoving = false;
    introX -=DELTAFASTX;
     drawIntro = true;
  }
  
  if(NameY>NAMEYMIN){//move name slow up
    finishedMoving = false;
    NameY-=DELTASLOWY;
  }
  
  if(OptionsX>OptionsMINX){//move options slow left
    finishedMoving = false;
    OptionsX-=DELTAMIDX;
    drawOptions = true;
  }
  
  drawText();
  
  return finishedMoving;
}


public boolean moveforstartscreen(){
  //moves logo up, options come in from rhs and intro goes left
  //move intro left until limit hit
  
  finishedMoving = true;//used for exiting this process!
  
  if(introX<IntroXMAX){//move intro med  right
    finishedMoving = false;
    introX +=DELTAMIDX;
    drawIntro = true;
  }
  
  if(NameY<NameYMAX){//move name slow up
    finishedMoving = false;
    NameY+=DELTASLOWY;
    drawName = true;
  }
  
  if(OptionsX<OptionsMAX){//move options slow left
    finishedMoving = false;
    OptionsX+=DELTAFASTX;
    drawOptions = true;
  }else{
    drawOptions = false;
  }
  
  drawText();
  
  return finishedMoving;
}


////////////////////////////////////OPTIONS//////////////////////////////////////////////////

 public void optionsStatic(){
  //textFont(createFont("SanSerif", 32));
  textAlign(CENTER);
  drawText();
  if(!intro){
    Shandler.startIntroSong();
    intro = true;
  } 
 }
 
 

 
  private int clamp(int x, int minVal, int maxVal){
    return min(max(x,minVal),maxVal);
  }
  
  private int smoothRandomRed(){
      if(lxredOscilate){
        labelXred += (int)random(1, 15);
        labelXred = clamp(labelXred,100,255);
        if(labelXred==255)
          lxredOscilate = false;
      }
      else{
        labelXred -= (int)random(1, 15);
        labelXred = clamp(labelXred,100,255);
        if(labelXred==100)
          lxredOscilate = true;
      }
      return labelXred;
  }
  
  //draws text on screen here
  private void drawText(){
    if(drawName){
      textSize(72);//size
      fill(smoothRandomRed(),0,0);
      text("Pixel Pirate",NameX,NameY);
    }
    
    if(drawIntro){
       textSize(28);//size
       fill(255,255,255);
       text("[Swipe] up to start!\n [Swipe] right for options & How to Play\n",introX,introY);
    }
    
    if(drawOptions){
       textSize(28);//size
       fill(255,255,255);
       text("Options Menu!\n Options comeing soong, & i guess how to play aswell!\n [Swipe] left to go back to main screen",OptionsX,OptionsY);
    }
      
    
  }
  
  
  
 private void drawStars(){
   for(int i = 0;i<STARCNT;++i){
       theStars.get(i).shine();
     }
 
 }
  
}



class Stars {
  // They are born dark
  float x, y, bri = -1, dir, sz;
  int pHeight, pWidth;
  Stars(int nWidth, int nHeight){
    pHeight = nHeight;
    pWidth = nWidth;
  }
  
  void shine() {
    // if the star has completely faded to black
    // make it reappear somewhere else
    // (random position, random size and random brightness increase speed)
    if(bri < 0) {
      x = random(pWidth);
      y = random(pHeight);
      sz = random(1, 5);
      dir = random(1, 3);
      bri = 0;
    }
    // set the brightness and draw the star
    fill(bri);
    ellipse(x, y, sz, sz);
    // increase or decrease the brightness
    bri = bri + dir;
    // if it achieved maximum brightness
    // choose a random fade out speed
    if(bri > 255) {
      bri = 255;
      dir = random(-1, -3);
    }
  }
}


