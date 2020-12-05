package com.goodgamestudios.mafia.view.panels.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   
   public class MafiaTroopMemberPanelProperties extends BasicProperties
   {
       
      
      public var playerID:int;
      
      public var name:String;
      
      public var troopID:int;
      
      public var rankInClan:FamilyRank;
      
      public var target:ClanMemberLine;
      
      public function MafiaTroopMemberPanelProperties(param1:ClanMemberLine)
      {
         super();
         this.playerID = param1.properties[0];
         this.troopID = param1.properties[1];
         this.rankInClan = param1.properties[2];
         this.name = param1.properties[3];
         this.target = param1;
      }
   }
}
