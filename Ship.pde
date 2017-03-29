//contains all the ships classes
import java.util.Random;


abstract class Ship{//abstract ship class
   protected int posX;
   protected int posY;
   protected int sWidth;//Screen dims
   protected int sHeight;
   
   protected int shipDimWidth;
   protected int shipDimheight;
   
   protected color flagCol;
   protected int oceanH;
   
   
   abstract void drawShip(int oceanHeight, float flagdir);//needs to be overloaded
   abstract void AI();
   
   Ship(int iX, int iY, int iWidth, int iHeight, int iDimWidth, int iDimHeight){//constructor
     posX = iX;
     posY = iY;
     sWidth = iWidth;
     sHeight = iHeight;
     shipDimWidth = iDimWidth;
     shipDimheight = iDimHeight;
     flagCol = color(255,0,0);//red atm
   }
   
   public void AddMotion(int deltaX, int deltaY){
         posX = clamp((posX+deltaX),(0),(sWidth-shipDimWidth));
         posY = clamp((posY+deltaY),(0),(sHeight-shipDimheight));
     
   }
   //Getters & Setters
   public void setPos(int X, int Y){
     posX = X;
     posY = Y; 
   }
   public int[] getPos(){
      return new int[]{posX,posY}; 
   }
   public int getX(){
     return posX;
   }
   public int getY(){
     return posY;
   } 
   public int getXmid(){
    return int(posX+ shipDimWidth/2);
   }
   
   public int getYmid(){
    return int(sHeight-(oceanH));
   }
   
   public color getFlagColor(){
    return flagCol;
   }
   
   protected int clamp(int x, int minVal, int maxVal){
    return min(max(x,minVal),maxVal);
  }
  
  
}

class PlayerShip extends Ship{//main player class
/* so i know names
   protected int posX;
   protected int posY;
   protected int sWidth;//Screen dims
   protected int sHeight;
   
   protected int shipDimWidth;
   protected int shipDimheight;
   */
  PlayerShip(int iX, int iY, int iWidth, int iHeight, int iDimWidth, int iDimHeight){
    super(iX,iY,iWidth,iHeight,iDimWidth,iDimHeight);
      flagCol = color(255,0,0);//red atm
  }
  
  void AI(){
    
  }
  void drawShip(int oceanHeight, float flagdir){
    oceanH = oceanHeight;
    drawBetterShip3Level(oceanHeight,flagdir);
    
  }
  
  void drawBetterShip3Level(int oceanHeight, float flagDir){
    //bottom half water
    int xpos1 = posX+25;
    int xwidth1 = shipDimWidth-50;
    int yHeight1 = shipDimheight/4;
    int ypos1 = sHeight-(oceanHeight);
    
    //platform 1
    
    int xpos2 = posX+10;
    int xwidth2 = shipDimWidth-20;
    int yHeight2 = shipDimheight/4;
    int ypos2 = ypos1-yHeight2;
    
    //platform 2
    int xpos3 = posX;
    int xwidth3 = shipDimWidth;
    int yHeight3 = shipDimheight/4;
    int ypos3 = ypos2-yHeight3;
    
    
    //flag pole
    int xpos4 = posX+(shipDimWidth/2-shipDimWidth/15);
    int xwidth4 = ((shipDimWidth/15)*2);
    int yHeight4 = shipDimheight-shipDimheight/10;
    int ypos4 = ypos3-yHeight4;
    
    //flag
    int xpos5 = xpos4+xwidth4;
    int xwidth5 = (30);
    int yHeight5 = 25;
    int ypos5 = ypos4;
    if(flagDir>0.0){
       xpos5 = xpos4-xwidth4-20;
       xwidth5 = (30);
       yHeight5 = 25;
       ypos5 = ypos4;
    }
    
    
    fill(77,58,40);//color
    rect(xpos1,ypos1,xwidth1,yHeight1);///bottom half water
    rect(xpos2,ypos2,xwidth2,yHeight2); //platform 1
    rect(xpos3,ypos3,xwidth3,yHeight3);
    rect(xpos4,ypos4,xwidth4,yHeight4);
    fill(255,0,0);//white
    rect(xpos5,ypos5,xwidth5,yHeight5);//flag
    
  }
  
  void drawBetterShip2Level(int oceanHeight, float flagDir){
    //bottom half water
    int xpos1 = posX+15;
    int xwidth1 = shipDimWidth-30;
    int yHeight1 = shipDimheight/3;
    int ypos1 = sHeight-(oceanHeight+(yHeight1/2));
    
    //platform 1
    
    int xpos2 = posX;
    int xwidth2 = shipDimWidth;
    int yHeight2 = shipDimheight/3;
    int ypos2 = ypos1-yHeight2;
    
    
    //flag pole
    int xpos3 = posX+(shipDimWidth/2-shipDimWidth/15);
    int xwidth3 = ((shipDimWidth/15)*2);
    int yHeight3 = shipDimheight-shipDimheight/10;
    int ypos3 = ypos2-yHeight3;
    
    //flag
    int xpos4 = xpos3+xwidth3;
    int xwidth4 = (25);
    int yHeight4 = 20;
    int ypos4 = ypos3;
    if(flagDir>0.0){
       xpos4 = xpos3-xwidth3-15;
       xwidth4 = (25);
       yHeight4 = 20;
       ypos4 = ypos3;
    }
    
    
    fill(77,58,40);//color
    rect(xpos1,ypos1,xwidth1,yHeight1);///bottom half water
    rect(xpos2,ypos2,xwidth2,yHeight2); //platform 1
    rect(xpos3,ypos3,xwidth3,yHeight3);
    fill(255,0,0);//color blue
    rect(xpos4,ypos4,xwidth4,yHeight4);//flag
    
  }
  
  void drawSimpleShip(int oceanHeight){
    //bottom half water
    int xpos1 = posX;
    int xwidth1 = shipDimWidth;
    int yHeight1 = shipDimheight/2;
    int ypos1 = sHeight-(oceanHeight+yHeight1);
    
    //platform
    
    
    //flag pole
    int xpos2 = posX+(shipDimWidth/2-shipDimWidth/15);
    int xwidth2 = ((shipDimWidth/15)*2);
    int yHeight2 = shipDimheight-shipDimheight/10;
    int ypos2 = sHeight-(oceanHeight+yHeight1+yHeight2);
    
    //flag
    int xpos3 = xpos2+xwidth2;
    int xwidth3 = (25);
    int yHeight3 = 20;
    int ypos3 = ypos2;
   
    
    fill(77,58,40);//color
    rect(xpos1,ypos1,xwidth1,yHeight1);//bottom floor
    rect(xpos2,ypos2,xwidth2,yHeight2);//pole
    fill(255,0,0);//color blue
    rect(xpos3,ypos3,xwidth3,yHeight3);//flag
  }
  
  
}


class AIShip extends Ship{//main player class

  int dir = -1;//left or right and intensity is given by size
  int xPostto;//the direction it wants to goto
  int speed;
  
  boolean moving;
  //speeds
  final int XSPEEDMIN = 1;
  final int XSPEEDMED = 2;
  final int XSPEEDFAST = 4;
  final int XSPEEDZOOM = 8;
  
  
  AIShip(int iX, int iY, int iWidth, int iHeight, int iDimWidth, int iDimHeight){
    super(iX,iY,iWidth,iHeight,iDimWidth,iDimHeight);
    moving = false;
       flagCol = color(0,255,0);//red atm
    
  }
  
  void AI(){
    
  }
  
  void drawShip(int oceanHeight, float flagdir){
    StartAI(oceanHeight,dir);
    
  }
  void moveAI(){
    if(!moving)
        return;
        
    AddMotion((speed*dir),0);
    

    if(dir<=-1){//moving left
      if(posX<xPostto)//gone past point
        moving = false;
        return;
    }else if (dir>=1){//going right
      if(posX>xPostto)//gone past point
        moving = false;
        return;
    }
  }
  
  //sets up the place to move to
  void setupPossibleAImove(){
    //should we move at all?
    int movetest = randInt(0,100);
    
    if(movetest<5){//30% chance to move
      moving = true;
      xPostto = (randInt((0),(sWidth-shipDimWidth)));
      
      if(xPostto>posX){
        dir = 1;
      }else{
       dir = -1; 
      }
      int speedChance = randInt((1),(3));
      switch(speedChance){
         case 1:
             speed = XSPEEDMED;
           break;
         case 2:
             speed = XSPEEDMIN;
           break;
         case 3:
             speed = XSPEEDFAST;
           break;
      }
      
    }
    
  }
  
  private int randInt(int min, int max) {

    // NOTE: Usually this should be a field rather than a method
    // variable so that it is not re-seeded every call.
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
    }
  
  
  void StartAI(int oceanHeight, float flagDir){
    //bottom half water
    int xpos1 = posX+15;
    int xwidth1 = shipDimWidth-30;
    int yHeight1 = shipDimheight/3;
    int ypos1 = sHeight-(oceanHeight+(yHeight1/2));
    
    //platform 1
    
    int xpos2 = posX;
    int xwidth2 = shipDimWidth;
    int yHeight2 = shipDimheight/3;
    int ypos2 = ypos1-yHeight2;
    
    
    //flag pole
    int xpos3 = posX+(shipDimWidth/2-shipDimWidth/15);
    int xwidth3 = ((shipDimWidth/15)*2);
    int yHeight3 = shipDimheight-shipDimheight/10;
    int ypos3 = ypos2-yHeight3;
    
    //flag
    int xpos4 = xpos3+xwidth3;
    int xwidth4 = (25);
    int yHeight4 = 20;
    int ypos4 = ypos3;
    if(flagDir>0.0){
       xpos4 = xpos3-xwidth3-15;
       xwidth4 = (25);
       yHeight4 = 20;
       ypos4 = ypos3;
    }
    
    
    fill(color(60,50,42),180);//color
    rect(xpos1,ypos1,xwidth1,yHeight1);///bottom half water
     fill(color(60,50,42));//color
    rect(xpos2,ypos2,xwidth2,yHeight2); //platform 1
    rect(xpos3,ypos3,xwidth3,yHeight3);
    
    stroke(color(255,255,255));//white border
    fill(color(0,0,0),220);//black 
    rect(xpos4,ypos4,xwidth4,yHeight4);//flag
    
    stroke(color(255,255,255),220);//white 
    line(xpos4+xwidth4,ypos4,xpos4,yHeight4+ypos4);
    line(xpos4+xwidth4,ypos4+yHeight4,xpos4,ypos4);
    stroke(color(0,0,0));//white border
    //random movement
    if(moving)
      moveAI();
    else
      setupPossibleAImove();
    
  }

}

