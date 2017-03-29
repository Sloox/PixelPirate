//Ocean the ship sits on
import java.util.Random;

class Ocean{
   protected int oceanWidthX;
   protected int ocenaHeightY;
   protected int sWidth;//Screen dims
   protected int sHeight;
   protected color theColor;
   
   protected int[] OceansY;//oceans horizan
   protected int[] OceansHeight;
   protected int[] OceansYmod;
   protected int[] OceansYmodCNT;
   protected color[] OceanCols;
   protected final int HORIZONCNT = 4;
   
   Ocean(int iOceanWidth, int iOceanHeight, int iWidth, int iHeight){
     oceanWidthX = iOceanWidth;
     ocenaHeightY = iOceanHeight;
     sWidth = iWidth;
     sHeight = iHeight;
     theColor = color(28,107,160);//default blue
     
     //set up fading horizon
     OceansY = new int[HORIZONCNT];
     OceansHeight = new int[HORIZONCNT];
     OceanCols = new color[HORIZONCNT];
     OceansYmod = new int[HORIZONCNT];
     OceansYmodCNT = new int[HORIZONCNT];
     
     int iAccum = ocenaHeightY+ocenaHeightY/2;//setup variable waves
     int r = 28, g = 117, b = 150;
     for(int i = 0;i<HORIZONCNT;++i){
       OceansY[i] = sHeight-iAccum;
       OceansHeight[i] = ocenaHeightY+iAccum;
       OceanCols[i] = color(r,g,b);
       iAccum += (ocenaHeightY/(2+(i)));
       g+=3;
       b-=3;
       OceansYmod[i] = (int)(randInt(-1,1));
       if(OceansYmod[i]==0)
         OceansYmod[i] = 1;
       OceansYmodCNT[i] = 0;
     }
     
     
    
   }
   
   void drawOcean(int State){
     boolean defaultflag = false;
     switch(State){
        case 0://intro state 1stpass
        case 1://options
          drawIntroPlain(State);
         break;
        default:
         defaultflag = true;
        
     }
     if(defaultflag){
       println("Default reached for draw ocean state:"+State);
       drawIntroPlain(0);
     }
     
   }
   //Getters & Setters
   public int getOceansHeightYfrombottom(int index){
      return sHeight-OceansY[index]; 
   }
   
   public int[] getOceanDims(){
      return new int[]{oceanWidthX,ocenaHeightY}; 
   }
   public int getOceanWidth(){
     return oceanWidthX;
   }
   public int getOceanHeight(){
     return ocenaHeightY;
   } 
   
   //ocean draw functions
   void drawIntroPlain(int state){
      noStroke();//no border
     if(state==0){//draw back sea
      //
       for(int i =0;i<HORIZONCNT;++i){
          fill(OceanCols[i],130-(i*2));
          rect(-1,OceansY[i],oceanWidthX,OceansHeight[i]);
          
          if(OceansYmodCNT[i]%2==0)
            OceansY[i] += OceansYmod[i];
         
          OceansYmodCNT[i]++;
          if(OceansYmodCNT[i]==10){
            OceansYmod[i] = OceansYmod[i]*-1;
            OceansYmodCNT[i] = 0;
          }
       }
       fill(theColor,150);
       rect(-1,sHeight-ocenaHeightY,oceanWidthX,ocenaHeightY+1);  
     }else{
       fill(theColor,100);
       rect(-1,sHeight-ocenaHeightY,oceanWidthX,ocenaHeightY+1);
       
     }
     
     stroke(color(0,0,0));//border
   }
   
   
   public int randInt(int min, int max) {

    // NOTE: Usually this should be a field rather than a method
    // variable so that it is not re-seeded every call.
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
}
  
  
}
