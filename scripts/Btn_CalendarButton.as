package
{
   import flash.display.MovieClip;
   
   public dynamic class Btn_CalendarButton extends MovieClip
   {
       
      
      public var thumb:MovieClip;
      
      public var num:MovieClip;
      
      public function Btn_CalendarButton()
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
