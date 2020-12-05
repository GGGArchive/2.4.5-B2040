package
{
   import flash.display.MovieClip;
   
   public dynamic class TutorialPanel extends MovieClip
   {
       
      
      public var bubble:MovieClip;
      
      public function TutorialPanel()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
