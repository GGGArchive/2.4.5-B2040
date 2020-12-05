package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class WinBlink_952 extends MovieClip
   {
       
      
      public function WinBlink_952()
      {
         super();
         addFrameScript(0,this.frame1,139,this.frame140);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame140() : *
      {
         gotoAndStop(1);
      }
   }
}
