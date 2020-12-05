package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class NewAchievementVO
   {
       
      
      public var achievementID:int;
      
      public var achievementLevel:int;
      
      public var allAttributesBonus:int;
      
      public var goldBonus:int;
      
      public var item:ItemVO;
      
      public function NewAchievementVO()
      {
         super();
      }
   }
}
