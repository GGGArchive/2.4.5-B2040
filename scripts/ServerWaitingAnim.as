package
{
   import flash.display.MovieClip;
   
   public dynamic class ServerWaitingAnim extends MovieClip
   {
       
      
      public function ServerWaitingAnim()
      {
         super();
         addFrameScript(59,this.frame60);
      }
      
      function frame60() : *
      {
         gotoAndPlay(25);
      }
   }
}
