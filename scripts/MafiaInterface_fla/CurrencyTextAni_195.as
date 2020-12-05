package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class CurrencyTextAni_195 extends MovieClip
   {
       
      
      public var value:MovieClip;
      
      public function CurrencyTextAni_195()
      {
         super();
         addFrameScript(0,this.frame1,10,this.frame11);
      }
      
      function frame1() : *
      {
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      function frame11() : *
      {
         gotoAndStop(1);
      }
   }
}
