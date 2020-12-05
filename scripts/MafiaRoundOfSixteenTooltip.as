package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaRoundOfSixteenTooltip extends MovieClip
   {
       
      
      public var txt_level_player1:TextField;
      
      public var txt_title:TextField;
      
      public var txt_level_player2:TextField;
      
      public var txt_name_player1:TextField;
      
      public var txt_name_player2:TextField;
      
      public function MafiaRoundOfSixteenTooltip()
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
