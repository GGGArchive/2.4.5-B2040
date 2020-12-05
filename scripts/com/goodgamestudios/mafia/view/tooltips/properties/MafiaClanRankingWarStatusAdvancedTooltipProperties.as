package com.goodgamestudios.mafia.view.tooltips.properties
{
   public class MafiaClanRankingWarStatusAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var attackTime:String;
      
      public var attackClan:String;
      
      public var defendTime:String;
      
      public var defendClan:String;
      
      public function MafiaClanRankingWarStatusAdvancedTooltipProperties(param1:String, param2:String, param3:String, param4:String)
      {
         this.attackTime = param1;
         this.attackClan = param2;
         this.defendTime = param3;
         this.defendClan = param4;
         super();
      }
   }
}
