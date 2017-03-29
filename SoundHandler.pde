//handles Andrtoid sounds

import android.media.*;
import android.content.res.*;
import android.media.MediaPlayer.OnCompletionListener;
//sound class
class SoundH{
  
  android.content.res.AssetFileDescriptor assetFileDescriptor;
  android.media.MediaPlayer mediaPlayer;
  processing.core.PApplet theSketch;
  
  boolean intro = false;
   
   public SoundH(PApplet tSketch){
     theSketch = tSketch;
   }
   
   public void startIntroSong(){
      MediaPlayer mediaPlayer = new MediaPlayer();
      AssetManager assets = theSketch.getAssets();
      AssetFileDescriptor fd ;
      try{
         fd = theSketch.getAssets().openFd("menu.mp3");
         mediaPlayer.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
         mediaPlayer.prepare();
         mediaPlayer.setOnCompletionListener(onComplete);
         mediaPlayer.start(); 
      }catch(Exception e){
         println(e);
      }
     intro = true; 
     
     
 }
 void stopPlaying(){
   startIntroSong();
 }
     
    //On complete listner
  MediaPlayer.OnCompletionListener onComplete = new OnCompletionListener()
  {

    @Override
    public void onCompletion(MediaPlayer mp)
    {
        stopPlaying();
    }
  };
     
}//end of class
