package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class ClanRankingLine extends MovieClip
   {
       
      
      public var txt_leader:TextField;
      
      public var txt_glory:TextField;
      
      public var rankingLineBG:MovieClip;
      
      public var status_defend:emptyMC;
      
      public var war:ClanRankingWarStatus;
      
      public var txt_member:TextField;
      
      public var mc_change:RankingChangePosition;
      
      public var btn_layer_leader:RankingMouseOverClanLayer;
      
      public var txt_name:TextField;
      
      public var btn_layer_name:RankingMouseOverNameLayer;
      
      public var status_attack:emptyMC;
      
      public var txt_level:TextField;
      
      public var txt_rang:TextField;
      
      public function ClanRankingLine()
      {
         super();
      }
   }
}
