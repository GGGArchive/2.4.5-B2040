package
{
   import flash.display.MovieClip;
   
   public dynamic class Smith extends MovieClip
   {
       
      
      public function Smith()
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
