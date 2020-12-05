package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   
   public class MafiaDungeonAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var dungeon:GangwarVO;
      
      public var copy:String;
      
      public var eMailVerified:Boolean;
      
      public var addFriendTooltTip:Boolean;
      
      public function MafiaDungeonAdvancedTooltipProperties(param1:GangwarVO, param2:String)
      {
         this.dungeon = param1;
         this.copy = param2;
         super();
      }
   }
}
