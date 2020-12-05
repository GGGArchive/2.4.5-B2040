package com.goodgamestudios.mafia.event.model
{
   public class MafiaWantedEvent extends MafiaEvent
   {
      
      public static const CHANGE_WANTEDDATA:String = "changeWantedData";
      
      public static const CHANGE_WANTEDRESULT:String = "changeWantedResult";
      
      public static const CHANGE_WANTEDTIMER:String = "changeWantedTimer";
      
      public static const UNLOCK_WANTED_BUTTON:String = "unlockButton";
      
      public static const WANTED_REJECTED:String = "wantedRejected";
       
      
      public function MafiaWantedEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
