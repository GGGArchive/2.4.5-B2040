package com.goodgamestudios.mafia.constants.enums
{
   public class QuestType extends BasicEnum
   {
      
      private static var _none:QuestType;
      
      private static var _cityQuest:QuestType;
      
      private static var _cityUnlockQuest:QuestType;
      
      private static var _guidingQuest:QuestType;
       
      
      public function QuestType(param1:String, param2:uint, param3:DoNotInstantiate#76)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get None() : QuestType
      {
         if(_none == null)
         {
            _none = new QuestType("None",0,new DoNotInstantiate#76());
         }
         return _none;
      }
      
      public static function get CityQuest() : QuestType
      {
         if(_cityQuest == null)
         {
            _cityQuest = new QuestType("CityQuest",1,new DoNotInstantiate#76());
         }
         return _cityQuest;
      }
      
      public static function get CityUnlockQuest() : QuestType
      {
         if(_cityUnlockQuest == null)
         {
            _cityUnlockQuest = new QuestType("CityUnlockQuest",2,new DoNotInstantiate#76());
         }
         return _cityUnlockQuest;
      }
      
      public static function get GuidingQuest() : QuestType
      {
         if(_guidingQuest == null)
         {
            _guidingQuest = new QuestType("GuidingQuest",3,new DoNotInstantiate#76());
         }
         return _guidingQuest;
      }
   }
}

class DoNotInstantiate#76
{
    
   
   function DoNotInstantiate#76()
   {
      super();
   }
}
