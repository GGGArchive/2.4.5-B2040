package com.goodgamestudios.mafia.event.model
{
   public class MafiaGangwarEvent extends MafiaEvent
   {
      
      public static const CHANGE_GANGWAR_DATA:String = "changeDungeonData";
      
      public static const CHANGE_GANGWAR_OPPONENT_DATA:String = "changeDungeonOpponentData";
      
      public static const CHANGE_GANGWAR_TIMER:String = "changeDungeonTimer";
      
      public static const CHANGE_GANGWAR_RESULT:String = "changeDungeonResult";
       
      
      public function MafiaGangwarEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
