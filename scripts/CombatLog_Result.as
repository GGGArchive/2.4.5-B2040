package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class CombatLog_Result extends MovieClip
   {
       
      
      public var txt_result:TextField;
      
      public function CombatLog_Result()
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
