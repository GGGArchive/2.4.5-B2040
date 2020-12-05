package
{
   import flash.display.MovieClip;
   
   public dynamic class MiniBox extends MovieClip
   {
       
      
      public function MiniBox()
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
