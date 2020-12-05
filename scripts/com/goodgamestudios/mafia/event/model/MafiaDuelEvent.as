package com.goodgamestudios.mafia.event.model
{
   public class MafiaDuelEvent extends MafiaEvent
   {
      
      public static const CHANGE_DUEL_DATA:String = "changeDuelData";
      
      public static const CHANGE_DUEL_RESULT:String = "changeDuelResult";
      
      public static const CHANGE_DUEL_TIMER:String = "changeDuelTimer";
      
      public static const DUEL_REJECTED:String = "duelRejected";
      
      public static const REMOVE_DUELTIMER:String = "removeDuelTimer";
      
      public static const CANCELLED_DUEL_PREPARATION:String = "cancelledDuelPreparation";
       
      
      public function MafiaDuelEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
