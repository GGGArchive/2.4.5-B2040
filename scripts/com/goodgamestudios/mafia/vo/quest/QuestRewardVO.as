package com.goodgamestudios.mafia.vo.quest
{
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class QuestRewardVO
   {
       
      
      public var cash:uint;
      
      public var gold:uint;
      
      public var xp:uint;
      
      public var ap:uint;
      
      public var item:ItemVO;
      
      public var unlockCity:City;
      
      public function QuestRewardVO()
      {
         super();
      }
   }
}
