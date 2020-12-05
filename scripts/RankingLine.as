package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class RankingLine extends MovieClip
   {
       
      
      public var txt_guild:TextField;
      
      public var txt_glory:TextField;
      
      public var rankingLineBG:MovieClip;
      
      public var mc_class:emptyMC;
      
      public var btn_layer_leader:RankingMouseOverClanLayer;
      
      public var mc_change:RankingChangePosition;
      
      public var txt_name:TextField;
      
      public var btn_layer_name:RankingMouseOverNameLayer;
      
      public var txt_level:TextField;
      
      public var txt_rang:TextField;
      
      public function RankingLine()
      {
         super();
      }
   }
}
