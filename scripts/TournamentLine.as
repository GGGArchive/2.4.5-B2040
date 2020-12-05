package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class TournamentLine extends MovieClip
   {
       
      
      public var rankingLineBG:MovieClip;
      
      public var mc_class:emptyMC;
      
      public var txt_clan:TextField;
      
      public var txt_name:TextField;
      
      public var btn_layer_clan:RankingMouseOverClanLayer;
      
      public var btn_layer_name:RankingMouseOverNameLayer;
      
      public var txt_level:TextField;
      
      public function TournamentLine()
      {
         super();
      }
   }
}
