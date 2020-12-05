package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaOwnProfile extends MovieClip
   {
       
      
      public var mc_policePenalty:PolicePenaltyTimeComp;
      
      public var profileStats:ProfileStats;
      
      public var btn_addEndurance:PlusButton;
      
      public var profileValues:ProfileStats;
      
      public var btn_addLuck:PlusButton;
      
      public var btn_toFamily:Btn_GotoClan;
      
      public var tutpoint_12:emptyMC;
      
      public var inventory:MafiaInventory;
      
      public var txt_name:TextField;
      
      public var btn_change_avatar:ButtonRefresh;
      
      public var tutpoint_14:emptyMC;
      
      public var txt_familyname:TextField;
      
      public var mc_policebonus:PoliceBonusTimeComp;
      
      public var btn_addAttack:PlusButton;
      
      public var btn_addResistance:PlusButton;
      
      public var defense:DefenseSymbol;
      
      public function MafiaOwnProfile()
      {
         super();
      }
   }
}
