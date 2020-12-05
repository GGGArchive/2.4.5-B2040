package
{
   import flash.display.MovieClip;
   
   public dynamic class Energy extends MovieClip
   {
       
      
      public function Energy()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.mouseChildren = false;
         stop();
      }
   }
}
