package
{
   import flash.display.MovieClip;
   
   public dynamic class Food extends MovieClip
   {
       
      
      public var cross:MovieClip;
      
      public var item:emptyMC;
      
      public var helpBG:MovieClip;
      
      public function Food()
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
