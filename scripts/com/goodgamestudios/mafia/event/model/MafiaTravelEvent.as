package com.goodgamestudios.mafia.event.model
{
   public class MafiaTravelEvent extends MafiaEvent
   {
      
      public static const CHANGE_TRAVELDATA:String = "changeTravelData";
      
      public static const CHANGE_FLIGHTTIMER:String = "changeFlightTimer";
      
      public static const CHANGE_TRAVELUNLOCKDATA:String = "changeTravelUnlockData";
       
      
      public function MafiaTravelEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
