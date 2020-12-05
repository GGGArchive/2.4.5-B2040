package com.goodgamestudios.mafia.event.model
{
   public class MafiaMissionEvent extends MafiaEvent
   {
      
      public static const CHANGE_MISSION_DATA:String = "changeMissionData";
      
      public static const CHANGE_MISSION_TIMER:String = "changeMissionTimer";
      
      public static const CHANGE_MISSION_RESULT:String = "changeMissionResult";
      
      public static const CHANGE_ENERGYUPDATETIMER:String = "changeEnergyUpdate";
       
      
      public function MafiaMissionEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
