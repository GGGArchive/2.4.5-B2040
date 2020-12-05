package
{
   import flash.display.MovieClip;
   
   public dynamic class DynamitePlace extends MovieClip
   {
       
      
      public var amount:MovieClip;
      
      public var cross:MovieClip;
      
      public var item:emptyMC;
      
      public var helpBG:MovieClip;
      
      public function DynamitePlace()
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
