package
{
   import flash.display.MovieClip;
   
   public dynamic class DynamicFightResult extends MovieClip
   {
       
      
      public var btn_close:MafiaBasicButtonBlue;
      
      public var reward_xp:Field_GainXP;
      
      public var reward_honor:Field_GainFame;
      
      public var btn_log:MafiaButtonCombatLog;
      
      public var reward_ap:Field_GainAP;
      
      public var reward_cash:Field_GainCash;
      
      public var reward_drink:Field_GainDrink;
      
      public var bg:MovieClip;
      
      public var reward_gold:Field_GainGold;
      
      public var title:MovieClip;
      
      public var reward_item:Quest_ItemContainer;
      
      public function DynamicFightResult()
      {
         super();
      }
   }
}
