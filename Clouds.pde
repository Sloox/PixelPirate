//drawing clouds
import java.util.Random;


class Clouds{
  //vars used to draw
  private int MaxHeight;
  private int MaxWidth;
  private int curX;
  private int curY;
  private int Size;
  private color cCol;
  private int alpha;
  private int dir;
  private int halfsize;
  private int speed;
  
 Clouds( int _MaxWidth, int _MaxHeight){
    MaxHeight = _MaxHeight;
    MaxWidth = _MaxWidth;
    Size = randInt(10,20);
    halfsize = Size/2;
    cCol = color(255,255,255);
    alpha = randInt(70,160);
    curY = randInt(0+(Size*2),_MaxHeight);
    curX = 0-(Size*3);
    dir = 1;
    speed = randInt(1,4);
    if(randInt(1,2)%2==0){
        dir = -1;
        curX = MaxWidth+(Size*3);
    }
 } 
 
 void drawCloud(){
   //draw 3 Blocks as clouds middle 1 bigger than side 2
   noStroke();
   fill(cCol,alpha);
   ellipse(curX,curY,Size,Size);
   ellipse(curX+Size,curY,Size+halfsize,Size+halfsize);
   ellipse(curX+Size+Size,curY,Size,Size);
   stroke(color(0,0,0));//back to black
   curX+=speed*dir;
   if(curX>MaxWidth+(Size*3)+10){
     reinstantiate();
   }
   if(curX<0-(Size*3+10)){
     reinstantiate();
   }
 }
 
 void reinstantiate(){
    Size = randInt(10,20);
    halfsize = Size/2;
    cCol = color(255,255,255);
    alpha = randInt(70,160);
    curY =  randInt(0+(Size*2),MaxHeight);
    curX = 0-(Size*3);
    dir = 1;
    speed = randInt(1,4);
    if(randInt(1,2)%2==0){
        dir = -1;
        curX = MaxWidth+(Size*3);
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
}
