//flashy disco mode

public class Ray{
   private float angle;
   private boolean drawShip;
   private int sWidth, sHeight;
   private float rotspeed;
   private color flagColor;
   private float Chance;
  
  Ray(int screenWidth, int screenHeight){
    sWidth = screenWidth;
    sHeight = screenHeight;
    drawShip = false;
    rotspeed = 0.05;
    
  }
  
  void startRays(float speed){
    rotspeed = speed;
    drawShip = true;
    angle = 0.0;
    
  }
  
  boolean drawRay(Ship tShip){
    if(drawShip){
       moveRay(tShip.getXmid(),tShip.getYmid(),angle,tShip.getFlagColor());
       angle+=rotspeed;
    }
    return drawShip;
  }
  
  
  void moveRay(float x,float y, float angle, color Col){
    pushMatrix();
      translate(x,y);
       rotate(angle);
       fill(Col,100);
       triangle(0,0,sWidth,sHeight,sWidth,sHeight+100);//awlays draw back to starting pt
     popMatrix();
     if(angle>(3*PI)){
       drawShip = false;
       angle = 0.0;
     }
    
  }
  
  
  
  
  
  
  
  
  
}
