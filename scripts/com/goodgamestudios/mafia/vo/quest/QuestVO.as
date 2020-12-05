package com.goodgamestudios.mafia.vo.quest
{
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.QuestStatus;
   import com.goodgamestudios.mafia.constants.enums.QuestType;
   
   public class QuestVO
   {
       
      
      public var id:uint;
      
      public var type:QuestType;
      
      public var questStatus:QuestStatus;
      
      public var tasks:Vector.<QuestTaskVO>;
      
      public var reward:QuestRewardVO;
      
      public var districtNumber:uint;
      
      public var city:City;
      
      public function QuestVO()
      {
         super();
      }
      
      public function get complete() : Boolean
      {
         var _loc1_:QuestTaskVO = null;
         for each(_loc1_ in this.tasks)
         {
            if(!_loc1_.complete)
            {
               return false;
            }
         }
         return true;
      }
   }
}
