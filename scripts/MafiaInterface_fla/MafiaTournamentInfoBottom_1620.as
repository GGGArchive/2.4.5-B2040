package MafiaInterface_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaTournamentInfoBottom_1620 extends MovieClip
   {
       
      
      public var mc_healthBar:TournamentHealth_Bar;
      
      public var btn_heal:NewBasicRightGrowButtonGreen;
      
      public var txt_health_value:TextField;
      
      public var txt_heal_title:TextField;
      
      public var txt_heal_cost:TextField;
      
      public var txt_title:TextField;
      
      public var txt_copy:TextField;
      
      public var btn_info:Btn_Info;
      
      public function MafiaTournamentInfoBottom_1620()
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
