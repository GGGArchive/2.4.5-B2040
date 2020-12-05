package com.goodgamestudios.mafia.event.model
{
   public class MafiaWorkEvent extends MafiaEvent
   {
      
      public static const CHANGE_WORK_DATA:String = "changeWorkData";
      
      public static const CHANGE_WORK_TIMER:String = "changeWorkTimer";
      
      public static const CHANGE_WORK_RESULT:String = "changeWorkResult";
      
      public static const CHANGE_WORK_AWARD_DATA:String = "changeWorkAwardData";
       
      
      public function MafiaWorkEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
