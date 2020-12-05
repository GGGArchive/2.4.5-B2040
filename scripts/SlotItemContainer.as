package
{
   import flash.display.MovieClip;
   
   public dynamic class SlotItemContainer extends MovieClip
   {
       
      
      public var holder:emptyMC;
      
      public function SlotItemContainer()
      {
         super();
         addFrameScript(0,this.frame1,141,this.frame142);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame142() : *
      {
         gotoAndStop(1);
      }
   }
}
