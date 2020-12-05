package com.goodgamestudios.mafia.vo.quest
{
   import com.goodgamestudios.mafia.constants.enums.City;
   
   public class QuestTaskVO
   {
       
      
      public var id:uint;
      
      public var iconId:uint;
      
      public var requiredValue:uint;
      
      public var currentValue:uint;
      
      public var city:City;
      
      public var districtNumber:int;
      
      public function QuestTaskVO()
      {
         super();
      }
      
      public function get complete() : Boolean
      {
         return this.currentValue >= this.requiredValue;
      }
   }
}
