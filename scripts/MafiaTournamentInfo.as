package
{
   import flash.display.MovieClip;
   
   public dynamic class MafiaTournamentInfo extends MovieClip
   {
       
      
      public var mc_info_player:MovieClip;
      
      public var mc_info_round:MovieClip;
      
      public var mc_winner:MovieClip;
      
      public function MafiaTournamentInfo()
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
