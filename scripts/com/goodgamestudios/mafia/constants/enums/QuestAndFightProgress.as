package com.goodgamestudios.mafia.constants.enums
{
   public class QuestAndFightProgress extends BasicEnum
   {
      
      private static var _none:QuestAndFightProgress;
      
      private static var _unavailableQuest:QuestAndFightProgress;
      
      private static var _availableQuest:QuestAndFightProgress;
      
      private static var _activeQuest:QuestAndFightProgress;
      
      private static var _fightAvailable:QuestAndFightProgress;
      
      private static var _fightVictory:QuestAndFightProgress;
      
      private static var _rewardTaken:QuestAndFightProgress;
      
      private static var _pausedQuest:QuestAndFightProgress;
       
      
      public function QuestAndFightProgress(param1:String, param2:uint, param3:DoNotInstantiate#97)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : QuestAndFightProgress
      {
         if(_none == null)
         {
            _none = new QuestAndFightProgress("None",0,new DoNotInstantiate#97());
         }
         return _none;
      }
      
      public static function get AvailableQuest() : QuestAndFightProgress
      {
         if(_availableQuest == null)
         {
            _availableQuest = new QuestAndFightProgress("AvailableQuest",1,new DoNotInstantiate#97());
         }
         return _availableQuest;
      }
      
      public static function get ActiveQuest() : QuestAndFightProgress
      {
         if(_activeQuest == null)
         {
            _activeQuest = new QuestAndFightProgress("ActiveQuest",2,new DoNotInstantiate#97());
         }
         return _activeQuest;
      }
      
      public static function get FightAvailable() : QuestAndFightProgress
      {
         if(_fightAvailable == null)
         {
            _fightAvailable = new QuestAndFightProgress("FightAvailable",3,new DoNotInstantiate#97());
         }
         return _fightAvailable;
      }
      
      public static function get FightVictory() : QuestAndFightProgress
      {
         if(_fightVictory == null)
         {
            _fightVictory = new QuestAndFightProgress("FightVictory",4,new DoNotInstantiate#97());
         }
         return _fightVictory;
      }
      
      public static function get RewardTaken() : QuestAndFightProgress
      {
         if(_rewardTaken == null)
         {
            _rewardTaken = new QuestAndFightProgress("RewardTaken",5,new DoNotInstantiate#97());
         }
         return _rewardTaken;
      }
      
      public static function get PausedQuest() : QuestAndFightProgress
      {
         if(_pausedQuest == null)
         {
            _pausedQuest = new QuestAndFightProgress("PausedQuest",1,new DoNotInstantiate#97());
         }
         return _pausedQuest;
      }
      
      public static function get UnavailableQuest() : QuestAndFightProgress
      {
         if(_unavailableQuest == null)
         {
            _unavailableQuest = new QuestAndFightProgress("UnavailableQuest",1,new DoNotInstantiate#97());
         }
         return _unavailableQuest;
      }
   }
}

class DoNotInstantiate#97
{
    
   
   function DoNotInstantiate#97()
   {
      super();
   }
}
