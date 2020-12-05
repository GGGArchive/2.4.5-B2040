package com.goodgamestudios.mafia.vo.gangwar
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CityFightProgress;
   import com.goodgamestudios.mafia.constants.enums.QuestAndFightProgress;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   
   public class GangwarVO
   {
       
      
      public var district_id:int;
      
      public var playerProgress:int;
      
      public var unlockable:Boolean;
      
      public var lockAndHasToolTip:Boolean;
      
      public var minRecruitedFriends:int;
      
      public var minLevel:int;
      
      public var unlockPriceC2:int;
      
      public var nextChallengeLevel:int;
      
      public var nextChallengeClass:CharacterClass;
      
      public var cityQuest:QuestVO;
      
      public var cityFightProgress:CityFightProgress;
      
      public var questAndFightProgress:QuestAndFightProgress;
      
      public var cityFighterLevel:int;
      
      public var cityFighterClass:CharacterClass;
      
      public function GangwarVO()
      {
         super();
      }
   }
}
