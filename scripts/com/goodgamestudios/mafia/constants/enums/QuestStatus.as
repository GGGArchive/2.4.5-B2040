package com.goodgamestudios.mafia.constants.enums
{
   public class QuestStatus extends BasicEnum
   {
      
      private static var _locked:QuestStatus;
      
      private static var _active:QuestStatus;
      
      private static var _paused:QuestStatus;
      
      private static var _finished:QuestStatus;
       
      
      public function QuestStatus(param1:String, param2:uint, param3:DoNotInstantiate#83)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get Locked() : QuestStatus
      {
         if(_locked == null)
         {
            _locked = new QuestStatus("Locked",1,new DoNotInstantiate#83());
         }
         return _locked;
      }
      
      public static function get Active() : QuestStatus
      {
         if(_active == null)
         {
            _active = new QuestStatus("Active",2,new DoNotInstantiate#83());
         }
         return _active;
      }
      
      public static function get Paused() : QuestStatus
      {
         if(_paused == null)
         {
            _paused = new QuestStatus("Paused",3,new DoNotInstantiate#83());
         }
         return _paused;
      }
      
      public static function get Finished() : QuestStatus
      {
         if(_finished == null)
         {
            _finished = new QuestStatus("Finished",4,new DoNotInstantiate#83());
         }
         return _finished;
      }
   }
}

class DoNotInstantiate#83
{
    
   
   function DoNotInstantiate#83()
   {
      super();
   }
}
